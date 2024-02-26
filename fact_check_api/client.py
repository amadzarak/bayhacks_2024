import requests

API_URL = "https://api-inference.huggingface.co/models/dongyru/Mistral-7B-Claim-Extractor"
headers = {"Authorization": f"Bearer {API_TOKEN}"}

def query(payload):
	response = requests.post(API_URL, headers=headers, json=payload)
	return response.json()
	
output = query({
	"inputs": "Can you please let us know more details about your ",
})
