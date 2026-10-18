# Salmonella WGS AI Assistant

A Streamlit application that uses the Google Gemini API to explain bioinformatics results from Salmonella whole-genome sequencing projects.

## Features

- Upload CSV and TSV result files.
- Preview uploaded data using pandas.
- Ask natural-language questions about results.
- Generate AI-assisted interpretations with Gemini.
- Display limitations and suggested validation steps.
- Handle API errors and missing configuration.

## Technology Stack

- Python
- Streamlit
- Pandas
- Google Gemini API (`google-genai`)

## Installation

```bash
git clone YOUR_REPOSITORY_URL
cd salmonella_wgs/ai_assistant

python -m venv .venv
source .venv/bin/activate

pip install -r requirements.txt
```

## Configuration

Create a Gemini API key using [Google AI Studio](https://aistudio.google.com/).

Set it as an environment variable:

```bash
export GEMINI_API_KEY="your_api_key"
```

Never commit your API key to GitHub.

## Run the application

```bash
streamlit run app.py
```

## Limitations

- The application sends selected file contents to an external AI service.
- The current implementation sends only a subset of uploaded rows for interpretation.
- AI-generated interpretations require independent verification.
- API model availability and request quotas depend on the Google AI project.

## Disclaimer

This is a research and educational tool. It is not a validated clinical diagnostic or antimicrobial susceptibility testing system.
