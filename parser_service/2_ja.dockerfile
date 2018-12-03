# docker build -f 2_ja.dockerfile -t asia.gcr.io/living-bio/base_images:python3_7_1_zh_ja .
FROM asia.gcr.io/living-bio/base_images:python3_7_1_zh

# has been set in python3_7_1_zh
# - EXPOSE 8080
# - ENV STANFORD_NLP localhost:8080/nlp
# - ENV PIP_EXTRA_INDEX_URL https://gliacloud:cookiebank@pypi-dot-living-bio.appspot.com/pypi
# - pip install zhconvert

RUN wget -q https://storage.googleapis.com/gliacloud-package/pyknp/juman_7.01.deb && \
    dpkg -i juman_7.01.deb && \
    wget -q https://storage.googleapis.com/gliacloud-package/pyknp/jumanpp_1.02.deb && \
    dpkg -i jumanpp_1.02.deb && \
    wget -q https://storage.googleapis.com/gliacloud-package/pyknp/knp_4.17.deb && \
    dpkg -i knp_4.17.deb && \
    rm -rf /root/*.deb && \
    pip install pyknp
