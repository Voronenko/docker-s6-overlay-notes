build:
	docker build -t docker-s6-overlay-notes:latest .

run:
	docker run -it docker-s6-overlay-notes:latest bash
