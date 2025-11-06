install:
	sudo apt install swaks -y

send:
	swaks --to recipient@example.com --server localhost:2525

build:
	docker compose -f compose.yml up --build