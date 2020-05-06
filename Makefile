all:
	docker build . -t pyogp
	docker run -it --rm pyogp bash
