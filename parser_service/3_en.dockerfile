# docker build -f 3_en.dockerfile -t asia.gcr.io/living-bio/base_images:python3_7_1_zh_ja_en .
FROM asia.gcr.io/living-bio/base_images:python3_7_1_zh_ja

# has been set in python3_7_1_zh
# - EXPOSE 8080
# - ENV STANFORD_NLP localhost:8080/nlp
# - ENV PIP_EXTRA_INDEX_URL https://gliacloud:cookiebank@pypi-dot-living-bio.appspot.com/pypi
# - pip install zhconvert
# has been set in python3_7_1_zh_ja
# - pip install pyknp

ENV OPENBLAS_NUM_THREADS 1

RUN pip install flashtext nltk spacy==2.0.5 Pillow && \
    python -m spacy download en_core_web_md && \
    rm -rf /root/.cache && \
    python -c 'import nltk; nltk.download("punkt")'
