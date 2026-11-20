import { S3Client, ListBucketsCommand, CreateBucketCommand, PutBucketPolicyCommand, PutPublicAccessBlockCommand, PutObjectCommand } from '@aws-sdk/client-s3';
import { CloudFrontClient, CreateDistributionCommand, ListDistributionsCommand, GetDistributionCommand } from '@aws-sdk/client-cloudfront';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.join(__dirname, '../../.env') });

const region = process.env.AWS_REGION || 'us-east-1';
const accessKeyId = process.env.AWS_ACCESS_KEY_ID?.trim();
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY?.trim();

if (!accessKeyId || !secretAccessKey) {
  console.error('❌ AWS credentials not found in backend/.env');
  process.exit(1);
}

const credentials = { accessKeyId, secretAccessKey };

const s3Client = new S3Client({ region, credentials });
const cfClient = new CloudFrontClient({ region: 'us-east-1', credentials });

async function setupAws() {
  console.log('🚀 Starting AWS S3 & CloudFront setup for Royal Logistics...');
  console.log(`Region: ${region}`);

  // 1. Verify credentials by listing buckets
  let existingBuckets = [];
  try {
    const listRes = await s3Client.send(new ListBucketsCommand({}));
    existingBuckets = (listRes.Buckets || []).map(b => b.Name);
    console.log(`✅ AWS Credentials validated. Found ${existingBuckets.length} existing buckets.`);
  } catch (err) {
    console.error('❌ Failed to authenticate with AWS:', err.message);
    process.exit(1);
  }

  // Determine bucket name
  let bucketName = process.env.AWS_S3_BUCKET?.trim();
  if (!bucketName) {
    // Generate unique bucket name
    const timestamp = Date.now().toString().slice(-6);
    bucketName = `royal-logistics-assets-${timestamp}`;
  }

  console.log(`📦 Target S3 Bucket: ${bucketName}`);

  // Create bucket if it doesn't exist
  if (!existingBuckets.includes(bucketName)) {
    try {
      console.log(`Creating S3 bucket: ${bucketName}...`);
      const createParams = {
        Bucket: bucketName,
        ...(region !== 'us-east-1' ? {
          CreateBucketConfiguration: {
            LocationConstraint: region,
          },
        } : {}),
      };
      await s3Client.send(new CreateBucketCommand(createParams));
      console.log(`✅ S3 bucket created: ${bucketName}`);
    } catch (err) {
      if (err.name === 'BucketAlreadyOwnedByYou') {
        console.log(`Bucket ${bucketName} already exists and is owned by you.`);
      } else {
        console.error(`❌ Failed to create S3 bucket:`, err.message);
        process.exit(1);
      }
    }
  } else {
    console.log(`Bucket ${bucketName} already exists.`);
  }

  // 2. Configure Public Access & Bucket Policy for Web Assets
  try {
    console.log('Configuring public access block settings...');
    await s3Client.send(new PutPublicAccessBlockCommand({
      Bucket: bucketName,
      PublicAccessBlockConfiguration: {
        BlockPublicAcls: false,
        IgnorePublicAcls: false,
        BlockPublicPolicy: false,
        RestrictPublicBuckets: false,
      },
    }));

    console.log('Applying read-only bucket policy for public access...');
    const bucketPolicy = {
      Version: '2012-10-17',
      Statement: [
        {
          Sid: 'PublicReadGetObject',
          Effect: 'Allow',
          Principal: '*',
          Action: 's3:GetObject',
          Resource: `arn:aws:s3:::${bucketName}/*`,
        },
      ],
    };

    await s3Client.send(new PutBucketPolicyCommand({
      Bucket: bucketName,
      Policy: JSON.stringify(bucketPolicy),
    }));
    console.log('✅ Bucket policy applied successfully.');
  } catch (err) {
    console.warn('⚠️ Note on bucket policy:', err.message);
  }

  // 3. Upload a sample test asset
  const testKey = 'test/royal-logistics-health.json';
  try {
    console.log(`Uploading test asset to s3://${bucketName}/${testKey}...`);
    await s3Client.send(new PutObjectCommand({
      Bucket: bucketName,
      Key: testKey,
      Body: JSON.stringify({
        project: 'Royal Logistics',
        aviationTier: 'First Suite All-Inclusive',
        cdnEnabled: true,
        deployedAt: new Date().toISOString(),
      }, null, 2),
      ContentType: 'application/json',
    }));
    console.log(`✅ Test asset uploaded: https://${bucketName}.s3.${region}.amazonaws.com/${testKey}`);
  } catch (err) {
    console.error('❌ Failed to upload test object:', err.message);
  }

  // 4. Set up or check CloudFront Distribution
  const s3OriginDomain = `${bucketName}.s3.${region}.amazonaws.com`;
  console.log(`🌐 Looking for CloudFront distribution for origin: ${s3OriginDomain}...`);

  let cloudFrontDomain = '';
  try {
    const listDists = await cfClient.send(new ListDistributionsCommand({}));
    const distItems = listDists.DistributionList?.Items || [];
    
    const existingDist = distItems.find(d => 
      d.Origins?.Items?.some(o => o.DomainName.includes(bucketName))
    );

    if (existingDist) {
      cloudFrontDomain = existingDist.DomainName;
      console.log(`✅ Found existing CloudFront distribution: https://${cloudFrontDomain} (ID: ${existingDist.Id}, Status: ${existingDist.Status})`);
    } else {
      console.log(`Creating new CloudFront distribution for ${s3OriginDomain}...`);
      const callerRef = `royal-logistics-${Date.now()}`;
      const createDistRes = await cfClient.send(new CreateDistributionCommand({
        DistributionConfig: {
          CallerReference: callerRef,
          Comment: 'Royal Logistics Global CDN Distribution',
          Enabled: true,
          DefaultRootObject: 'index.html',
          Origins: {
            Quantity: 1,
            Items: [
              {
                Id: `S3-${bucketName}`,
                DomainName: s3OriginDomain,
                CustomHeaders: { Quantity: 0 },
                S3OriginConfig: {
                  OriginAccessIdentity: '',
                },
                ConnectionAttempts: 3,
                ConnectionTimeout: 10,
              },
            ],
          },
          DefaultCacheBehavior: {
            TargetOriginId: `S3-${bucketName}`,
            ViewerProtocolPolicy: 'redirect-to-https',
            AllowedMethods: {
              Quantity: 2,
              Items: ['GET', 'HEAD'],
              CachedMethods: {
                Quantity: 2,
                Items: ['GET', 'HEAD'],
              },
            },
            ForwardedValues: {
              QueryString: false,
              Cookies: { Forward: 'none' },
              Headers: { Quantity: 0 },
            },
            MinTTL: 0,
            DefaultTTL: 86400,
            MaxTTL: 31536000,
            Compress: true,
          },
        },
      }));

      cloudFrontDomain = createDistRes.Distribution.DomainName;
      console.log(`✅ CloudFront distribution created!`);
      console.log(`Domain: https://${cloudFrontDomain}`);
      console.log(`Distribution ID: ${createDistRes.Distribution.Id}`);
      console.log(`Status: ${createDistRes.Distribution.Status}`);
    }
  } catch (err) {
    console.error('❌ CloudFront distribution error:', err.message);
  }

  // 5. Update .env file
  const envPath = path.join(__dirname, '../../.env');
  let envContent = fs.readFileSync(envPath, 'utf8');

  envContent = envContent.replace(/AWS_S3_BUCKET=.*/g, `AWS_S3_BUCKET="${bucketName}"`);
  if (!envContent.includes('AWS_S3_BUCKET=')) {
    envContent += `\nAWS_S3_BUCKET="${bucketName}"`;
  }

  if (cloudFrontDomain) {
    envContent = envContent.replace(/CLOUDFRONT_URL=.*/g, `CLOUDFRONT_URL="https://${cloudFrontDomain}"`);
    if (!envContent.includes('CLOUDFRONT_URL=')) {
      envContent += `\nCLOUDFRONT_URL="https://${cloudFrontDomain}"`;
    }
  }

  fs.writeFileSync(envPath, envContent, 'utf8');
  console.log(`📝 Updated backend/.env with S3 bucket and CloudFront URL.`);

  console.log('\n======================================================');
  console.log('🎉 AWS S3 & CLOUDFRONT CONFIGURATION COMPLETE');
  console.log(`📦 S3 Bucket:       ${bucketName}`);
  console.log(`🌐 S3 Direct URL:   https://${bucketName}.s3.${region}.amazonaws.com/${testKey}`);
  if (cloudFrontDomain) {
    console.log(`⚡ CloudFront URL:  https://${cloudFrontDomain}/${testKey}`);
  }
  console.log('======================================================\n');
}

setupAws().catch(err => {
  console.error('Unhandled script error:', err);
  process.exit(1);
});

