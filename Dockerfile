FROM steamcmd/steamcmd

COPY start_server.sh .
RUN chmod 777 start_server.sh

# the steamcmd image uses ENTRYPOINT, so we need to override it so it doesn't ignore our CMD.
ENTRYPOINT [""]
CMD ./start_server.sh
