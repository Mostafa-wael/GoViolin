# The base image to build the application on top of it
FROM golang:1.16.7-alpine3.15 AS builder

# Create a directory to work in
RUN mkdir /app

# Copy the application to the directory
COPY ./ /app

# Change the working directory to /app
WORKDIR /app

# Build the binaries
RUN go build -o runnable.o .

# use alpine image for the multistage build to reduce size
FROM alpine:latest

# path flag: create all directories leading up to the given directory that do not exist already.
RUN mkdir -p /app/

# copy the generated binary files from the build stage to the app directory
COPY --from=builder /app/ /app/

# Change the working directory to /app
WORKDIR /app

# Expose the port
EXPOSE 8080

# Run the binary file
CMD ["./runnable.o"]