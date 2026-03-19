FROM redis_ctf_fix:1.0

USER root

EXPOSE 7681

COPY entrypoint.sh /entrypoint.sh
COPY check.sh /check.sh

RUN chmod +x /entrypoint.sh /check.sh

ENTRYPOINT ["/entrypoint.sh"]
