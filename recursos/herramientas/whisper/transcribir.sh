#!/usr/bin/env bash
# Transcribe un vídeo o audio con whisper.cpp (Metal, local).
# Uso: transcribir.sh <archivo> [idioma]   (idioma por defecto: auto)
# Genera junto al archivo: <nombre>.txt, <nombre>.srt y <nombre>.vtt
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
MODELO="$DIR/modelos/ggml-large-v3-turbo-q5_0.bin"

if [[ $# -lt 1 ]]; then
  echo "Uso: $0 <video_o_audio> [idioma: es|en|auto]" >&2
  exit 1
fi

ENTRADA="$1"
IDIOMA="${2:-auto}"
SALIDA="${ENTRADA%.*}"

if [[ ! -f "$MODELO" ]]; then
  echo "Falta el modelo. Descárgalo con:" >&2
  echo "  curl -L -o \"$MODELO\" https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q5_0.bin" >&2
  exit 1
fi

TMP_WAV="$(mktemp -t whisper).wav"
trap 'rm -f "$TMP_WAV"' EXIT

# whisper.cpp necesita WAV mono a 16 kHz
ffmpeg -loglevel error -y -i "$ENTRADA" -ar 16000 -ac 1 -c:a pcm_s16le "$TMP_WAV"

whisper-cli -m "$MODELO" -f "$TMP_WAV" -l "$IDIOMA" -otxt -osrt -ovtt -of "$SALIDA" -np

echo "Listo: $SALIDA.txt / .srt / .vtt"
