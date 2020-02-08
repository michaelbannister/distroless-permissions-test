FROM tianon/true as source

FROM gcr.io/distroless/static:nonroot
COPY --from=source /true /true

ENTRYPOINT ["/true"]
