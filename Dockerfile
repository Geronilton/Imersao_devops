FROM python:3.13.5-alpine3.21

# 2. Set Working Directory: Define the working directory for subsequent commands.
WORKDIR /app

# 3. Copy and Install Dependencies:
# Copy requirements.txt first to leverage Docker's layer caching.
# The dependencies will only be re-installed if this file changes.
COPY requirements.txt ./

# Install the Python dependencies. The --no-cache-dir option keeps the image size smaller.
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy Application Code:
# Copy the rest of the application's source code into the container.
COPY . .

# 5. Expose Port:
# Expose the port the app runs on. Uvicorn defaults to 8000.
EXPOSE 8000

# 6. Run Application:
# Define the command to run the application using uvicorn.
# --host 0.0.0.0 is crucial to make the server accessible from outside the container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]