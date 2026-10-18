# Whisper (transcripción local)

Transcripción de vídeos y audios en local con [whisper.cpp](https://github.com/ggml-org/whisper.cpp), acelerado por Metal en Mac con Apple Silicon. No sube nada a internet.

## Instalación (una vez por equipo)

```bash
brew install whisper-cpp ffmpeg
curl -L -o recursos/herramientas/whisper/modelos/ggml-large-v3-turbo-q5_0.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q5_0.bin
```

El modelo (~550 MB) no se sube al repo: `modelos/` está en `.gitignore`.

## Uso

```bash
recursos/herramientas/whisper/transcribir.sh ruta/al/video.mp4        # idioma automático
recursos/herramientas/whisper/transcribir.sh ruta/al/video.mp4 es     # forzar español
```

Genera junto al archivo de entrada `.txt` (texto plano), `.srt` y `.vtt` (subtítulos con tiempos).
