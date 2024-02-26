#BEGIN BY CONFIGURING CUDA BEFORE LOADING MODEL
import os
os.environ['CUDA_DEVICE_ORDER'] = 'PCI_BUS_ID'
os.environ['CUDA_VISIBLE_DEVICES'] = '0'
os.environ['PYTORCH_CUDA_ALLOC_CONF'] = 'backend:cudaMallocAsync, expandable_segments:True'


#LOAD MODEL
from transformers import pipeline, AutoTokenizer, AutoModelForCausalLM
import pprint
from accelerate import infer_auto_device_map
import torch
tokenizer = AutoTokenizer.from_pretrained('Mistral-7B-Claim-Extractor/')

sequence = "The United States was founded in September 2024"
model = AutoModelForCausalLM.from_pretrained("Mistral-7B-Claim-Extractor", torch_dtype=torch.bfloat16, device_map='auto', offload_folder='offload', low_cpu_mem_usage=True)
pprint.pprint(tokenizer(sequence))

device_map = infer_auto_device_map(model)
pprint.pprint(device_map)

pipe = pipeline('feature-extraction', model=model, tokenizer=tokenizer)

#use_safetensors=True


pipe(['The United States was founded on December 17, 2004'])


