FROM scratch
COPY main /main
EXPOSE 8080
ENTRYPOINT ["/main"]
