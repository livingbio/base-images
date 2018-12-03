# docker build -f 4_ko.dockerfile -t asia.gcr.io/living-bio/base_images:python3_7_1_zh_ja_en_ko .
FROM asia.gcr.io/living-bio/base_images:python3_7_1_zh_ja_en

# has been set in python3_7_1_zh
# - EXPOSE 8080
# - ENV STANFORD_NLP localhost:8080/nlp
# - ENV PIP_EXTRA_INDEX_URL https://gliacloud:cookiebank@pypi-dot-living-bio.appspot.com/pypi
# - pip install zhconvert
# has been set in python3_7_1_zh_ja
# - pip install pyknp
# has been set in python3_7_1_zh_ja_en
# - ENV OPENBLAS_NUM_THREADS 1
# - pip install flashtext nltk spacy==2.0.5 Pillow

RUN apt update && apt install -y automake && \
    curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz && \
    tar zxfv mecab-0.996-ko-0.9.2.tar.gz && \
    cd mecab-0.996-ko-0.9.2 && \
    ./configure && \
    make -j4 && \
    make check && \
    make install && \
    cd .. && \
    ldconfig && \
    curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz && \
    tar zxfv mecab-ko-dic-2.1.1-20180720.tar.gz && \
    cd mecab-ko-dic-2.1.1-20180720 && \
    ./autogen.sh && \
    ./configure && \
    make -j4 && \
    echo "dicdir=/usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc && \
    make install && \
    cd .. && \
    git clone https://bitbucket.org/eunjeon/mecab-python-0.996.git && \
    cd mecab-python-0.996 && \
    python setup.py build && \
    python setup.py install && \
    cd .. && \
    rm -rf mecab*

RUN pip install konlpy
