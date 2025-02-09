from openai import OpenAI
client = OpenAI()


def chat_with_ai(input_file):
    with open(input_file) as file:
        user_input = file.read().strip()
        
        DELIMITER = "#" 
        response = client.chat.completions.create(
            model="gpt-4o",  # Use "gpt-3.5-turbo" for a cheaper alternative
            messages=[
                {"role": "system", "content": f"Respond in short, clear sentences. Keep responses under 40 words and in 1 line." 
                                            f"Avoid extra spaces and unnecessary details. Speak in playful tone."
                                            f"Do NOT use the delimiter `{DELIMITER}` in your response."},
                {"role": "user", "content": user_input}
            ],
            max_tokens=150,
            temperature=0.5,
            top_p=0.7
        )
        
        with open("chat_output.txt", "w", encoding="utf-8") as file:
            file.write(f"{DELIMITER}{response.choices[0].message.content}{DELIMITER}")
    # return response.choices[0].message.content
    # output = response.choices[0].message.content
    # return json.dumps({"response": output})


if __name__ == "__main__":
    file_to_read = "input.txt"
    response = chat_with_ai(file_to_read)
    print("response created!")