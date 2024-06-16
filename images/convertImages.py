import base64

def convert_to_base64(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode("utf-8")

# Convert images and save base64 strings to text files
schema_base64 = convert_to_base64("schema_phase1.jpg")
er_base64 = convert_to_base64("er_diagram_phase2.jpg")
normalized_base64 = convert_to_base64("normalized_schema_phase3.jpg")

# Write base64 strings to text files
with open("schema_base64.txt", "w") as f:
    f.write(schema_base64)

with open("er_base64.txt", "w") as f:
    f.write(er_base64)

with open("normalized_base64.txt", "w") as f:
    f.write(normalized_base64)

print("Base64 strings saved to text files.")
