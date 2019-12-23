FROM redis:5.0.7
ENTRYPOINT ["redis-cli", "--cluster"]
