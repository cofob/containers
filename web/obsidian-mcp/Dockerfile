FROM golang:1-bookworm AS mcp_fs_builder

# go install fetches from VCS; git + ca-certs avoid common failures
RUN apt-get update && apt-get install -y --no-install-recommends \
      git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Builds and installs the binary into /go/bin
RUN go install github.com/cofob/mcp-filesystem-server@1.2.3

# --- Runtime image (Node) ---
FROM node:22-bookworm-slim

# Copy the server binary into the PATH
COPY --from=mcp_fs_builder /go/bin/mcp-filesystem-server /usr/local/bin/mcp-filesystem-server

# Keep your existing MCP installs
RUN npm i -g mcp-proxy @mauricio.wolff/mcp-obsidian@0.7.3
