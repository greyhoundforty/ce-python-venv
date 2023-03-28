FROM python:3.10.10-slim-bullseye as base

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv "$VIRTUAL_ENV"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

CMD [ "python", "./app.py" ]