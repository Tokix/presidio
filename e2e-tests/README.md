# Ollama Endpoint and Model Configuration

Presidio's end-to-end tests for Ollama-based recognizers are fully configurable and do **not** use hardcoded Ollama endpoints or model IDs.

## How configuration works

- All test configuration files (e.g., `ollama_test_config.yaml`) use Jinja2 templates to resolve the Ollama endpoint and model ID from environment variables:
   - `MODEL_ID` (default: `qwen2.5:1.5b`)
   - `OLLAMA_BASE_URL` or `OLLAMA_HOST` (default: `http://localhost:11434`)
- This ensures tests are portable across local, CI, and cloud environments.

## Example

```yaml
model_id: "{{ MODEL_ID | default('qwen2.5:1.5b') }}"
model_url: "{{ OLLAMA_BASE_URL | default(OLLAMA_HOST | default('http://localhost:11434')) }}"
```

## Usage

Set the environment variables before running tests:

```sh
export MODEL_ID="qwen2.5:1.5b"
export OLLAMA_BASE_URL="http://ollama.mycompany.svc:11434"
pytest
```

If not set, the defaults will be used.

**Note:** All test code and configs are validated to ensure no hardcoded Ollama URLs or model IDs remain.
# End-to-end tests

This folder contains end-to-end tests for Presidio.
It requires the different services to be running as HTTP services.

Steps:
1. [Install presidio](https://microsoft.github.io/presidio/installation/)
2. Run services, e.g., using `docker-compose`:
    ```sh
   docker-compose up --build -d 
   ```
   Note that these might take some time to build for the first time.
   
3. Install the e2e-tests framework, preferably in a virtual environment:
   ```sh
   pip install -r requirements.txt
   ```
4. Run tests:
   ```
   pytest
   ```

See more information on [Presidio's documentation on E2E tests](https://microsoft.github.io/presidio/development/#end-to-end-tests).
