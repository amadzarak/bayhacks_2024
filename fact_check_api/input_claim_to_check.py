from transformers import AutoTokenizer, AutoModelForCasualLM
model = AutoModelForCasualLM.from_pretrained('Mistral-7B-Claim-Extractor')
tokenizer = AutoTokenizer.from_pretrained('Mistral-7B-Claim-Extractor')

prompt = 'The United States was found on September 24, 2024'
inputs = tokenizer(prompt, return_tensors='pt')

generate_id = model.generate(inputs.input_ids, max_length=30)
tokenizer.batch_decode(generate_ids, skip_special_tokens=True, clean_up_tokenization_spaces=False)[0]



