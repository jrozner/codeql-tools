all: codeql codeql-go
.PHONY: all

codeql:
	docker build -t codeql -f codeql/codeql.Dockerfile codeql
.PHONY: codeql

codeql-go: codeql
	docker build -t codeql-go -f codeql-go/codeql-go.Dockerfile codeql-go

.PHONY: codeql-go

