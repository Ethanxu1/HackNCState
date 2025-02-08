from openai import OpenAI
import json
client = OpenAI()


def chat_with_ai(user_input):
    response = client.chat.completions.create(
        model="gpt-4o",  # Use "gpt-3.5-turbo" for a cheaper alternative
        messages=[
            {"role": "system", "content": "You are a helpful financial chatbot."},
            {"role": "user", "content": user_input}
        ],
        max_tokens=100
    )
    output = response.choices[0].message.content
    return json.dumps({"response": output})


while True:
    user_input = input("You: ")
    if user_input.lower() in ["exit", "quit"]:
        print("Chatbot: Goodbye!")
        break
    response = chat_with_ai(user_input)
    print("Chatbot:", response)