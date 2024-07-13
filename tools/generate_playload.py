import argparse
import base64
import json

def main():
    parser = argparse.ArgumentParser(description="Generate Nimbus Judge Lambda Payload for test specific files")

    parser.add_argument('file_path', type=str, help='<target judge file>')
    parser.add_argument('problemid', type=str, help='<problem id>')
    parser.add_argument('filename', type=str, help='<filename>')
    parser.add_argument('language', type=str, help='<language>')

    args = parser.parse_args()

    with open(args.file_path, 'rb') as file:
        file_content = file.read()
        file64 = base64.b64encode(file_content).decode('utf-8')
    
    payload = {
        "problemid": args.problemid,
        "file64": file64,
        "filename": args.filename,
        "language": args.language
    }

    print(json.dumps(payload, indent=2))

if __name__ == "__main__":
    main()
