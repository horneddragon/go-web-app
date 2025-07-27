# Use the official Go image as the base image
FROM golang:1.22.5 as base

# Set the working directory to /app
WORKDIR /app

# Copy the Go module files
COPY go.mod .
 
# Download the Go module dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .



# Build the Go application
# Compile the Go application into a binary named 'main'
RUN go build -o main .

# Use a distroless base image for the final build
FROM gcr.io/distroless/base

# Copy the compiled binary and static files from the base image
COPY --from=base /app/main .

COPY --from=base /app/static ./static

# Expose port 8080 for the application
EXPOSE 8080

# Set the command to run the application
CMD ["./main"]