This is a trivial image based on [https://github.com/GoogleContainerTools/distroless](distroless), specifically the `nonroot` variant which sets `USER 65532` and `WORKDIR /home/nonroot`, where the filesystem permission are as shown:

```
Permission     UID:GID       Size  Filetree
drwxr-xr-x 65532:65532        0 B  │   ├── home
drwx------ 65532:65532        0 B  │   │   └── nonroot
```

The issue arises when you try to run a container from this image _with a different user_:

```
$ docker run --rm -it -u 1337:1337 michaelbannister/distroless-permissions-test
docker: Error response from daemon: OCI runtime create failed: container_linux.go:346: starting container process caused "chdir to cwd (\"/home/nonroot\") set in config.json failed: permission denied": unknown.
```

You get the same behaviour in Kubernetes if you deploy [job.yaml].

But [kind](https://kind.sigs.k8s.io) will run the job successfully. It only fails if you also drop capabilities, as in [job-drop-caps.yaml]
