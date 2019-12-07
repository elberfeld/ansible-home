FROM golang:1.13.5

RUN go get github.com/ThoreKr/syncrepl_exporter 

EXPOSE 9328
CMD ["/go/bin/syncrepl_exporter","--path.config=/syncrepl_exporter.yml"]
