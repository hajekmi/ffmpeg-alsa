help:
	echo "=== Targets ==="
	@grep '^[^#[:space:]].*:' Makefile

build:
	docker build -t ghcr.io/hajekmi/ffmpeg-alsa -f Dockerfile --platform linux/amd64 .

auth:
	docker login ghcr.io

push:
	docker push ghcr.io/hajekmi/ffmpeg-alsa:latest

clean:
	docker container exists ffmpeg-alsa && docker container stop -t 3 ffmpeg-alsa || echo
	docker image exists ghcr.io/hajekmi/ffmpeg-alsa:latest && docker image rm ghcr.io/hajekmi/ffmpeg-alsa:latest || echo 

loadaudio:
	modprobe snd-aloop pcm_substreams=1 index=10 id=LoopRadio # parametry  modinfo snd-aloop
	aplay -l

runsh:
	docker run -it --rm --name ffmpeg-alsa --device=/dev/snd:/dev/snd ghcr.io/hajekmi/ffmpeg-alsa /bin/sh

startradio: loadaudio
	docker run -d --rm --name ffmpeg-alsa --device=/dev/snd:/dev/snd --volume=./conf/asound.conf:/etc/asound.conf ghcr.io/hajekmi/ffmpeg-alsa ffmpeg -i "http://82.142.127.102/color192.mp3" -vn -acodec pcm_s16le -ac 1 -ar 8000 -f alsa hw:LoopRadio,1

stopradio:
	docker container stop -t 3 ffmpeg-alsa

# vim: noexpandtab filetype=make
