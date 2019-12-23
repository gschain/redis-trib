FROM redis:5.0.7
RUN set -eux; \
    apt-get update; \
    apt-get install -y dnsutils; \
    rm -rf /var/lib/apt/lists/*;
CMD ["sh"]
