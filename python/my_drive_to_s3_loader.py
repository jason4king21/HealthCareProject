import os
import io
import boto3
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload

# Configurations
GDRIVE_FOLDER_ID = 'YOUR_GOOGLE_DRIVE_FOLDER_ID'
S3_BUCKET_NAME = 'your-s3-bucket-name'
S3_FOLDER_PREFIX = 'your/s3/folder/path/'  # Example: 'healthcare/raw/'

# AWS client
s3_client = boto3.client('s3')

# Google Drive API scopes
SCOPES = ['https://www.googleapis.com/auth/drive.readonly']

# Authenticate and build the Drive service
def get_drive_service():
    creds = None
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.json', 'w') as token:
            token.write(creds.to_json())
    service = build('drive', 'v3', credentials=creds)
    return service

# List files in a Google Drive folder
def list_drive_files(service, folder_id):
    results = service.files().list(
        q=f"'{folder_id}' in parents and mimeType='application/vnd.google-apps.spreadsheet' or '{folder_id}' in parents and mimeType='text/csv'",
        pageSize=1000,
        fields="files(id, name, mimeType, modifiedTime)").execute()
    return results.get('files', [])

# Download a Drive file and upload to S3
def download_and_upload_file(service, file):
    file_id = file['id']
    file_name = file['name']
    print(f"Processing file: {file_name}")

    request = service.files().get_media(fileId=file_id)
    fh = io.BytesIO()
    downloader = MediaIoBaseDownload(fh, request)
    done = False
    while not done:
        status, done = downloader.next_chunk()
        print(f"Download progress: {int(status.progress() * 100)}%")

    fh.seek(0)
    s3_key = f"{S3_FOLDER_PREFIX}{file_name}"
    print(f"Uploading to S3: s3://{S3_BUCKET_NAME}/{s3_key}")
    s3_client.upload_fileobj(fh, S3_BUCKET_NAME, s3_key)
    print("Upload complete.")

# Main pipeline
def main():
    service = get_drive_service()
    files = list_drive_files(service, GDRIVE_FOLDER_ID)
    print(f"Found {len(files)} files in Google Drive folder.")

    for file in files:
        download_and_upload_file(service, file)

if __name__ == '__main__':
    main()
