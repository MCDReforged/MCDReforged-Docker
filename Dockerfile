# 1. Python
FROM python:3.11

# 2. Get Java
RUN wget --quiet https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz \
&& tar -xf jdk-19_linux-x64_bin.tar.gz \
&& update-alternatives --install /usr/bin/java java /jdk-19.0.2/bin/java 1

# 3. Copy files
COPY ./requirements.txt /requirements.txt

# 4. Initialization
WORKDIR /mcdreforged
VOLUME /mcdreforged
RUN python -m venv venv \
&& /mcdreforged/venv/bin/pip install -r /requirements.txt \
&& /mcdreforged/venv/bin/python -m mcdreforged init \
&& cp -r /mcdreforged /mcdreforged_init

# 5. Set env
ENV PATH="/mcdreforged/venv/bin:$PATH"
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 0

CMD ["python", "-m", "mcdreforged"]
