# aws-cli bwrapped

Tooling to use aws-cli (v2) container images without the overhead of typical OCI stacks (docker, podman, etc.).

## The problem (aka Why?)

AWS CLI v2 does not offer musl-compatible binaries nor does it support the latest Python and dep versions.
It is also not distributed on PyPI.
All that makes it more painful to package on Linux distributions which are both musl-based and rolling (like Chimera Linux).

Thankfully, there is no need to package it because it offers container images.
However, running OCI container images in a typical way incurs observable runtime cost which may feel unpleasant on the CLI, especially with heavy use of shell completion.
After all, who does not like the shells to feel snappy? ;-)

## The solution (aka How?)

The solution is to use the container image but avoid the typical runtimes.
bubblewrap comes to the rescue by offering an easy way (especially compared to unshare) to set up a happily working mount namespace for AWS CLI to run in.

The container image itself is obtained using the [`crane`](https://github.com/google/go-containerregistry/tree/main/cmd/crane) utility and extracted using `tar`.
The resulting artifacts are stored in `~/.local/opt/aws-cli`.
They can be removed freely if no longer required. 

Both `aws` and `aws_completer` are included.

## How to use

Set the environment variable `AWS_CLI_VERSION` to the desired AWS CLI version and ensure `PATH` includes `~/.local/bin`.
Then, run `./install.sh` to install `aws` and `aws_completer` shims as well as `ensure-aws-cli` command in `~/.local/bin`.
Finally, run `ensure-aws-cli`.
Afterwards, you can use `aws` and `aws_completer` as if they were the actual implementations.

## Limitations

Bwrapped AWS CLI "sees" only the `/home` hierarchy.
The rest is mapped from the extracted container image.

## Security

Use of `bwrap` in here is not meant to add extra security.
All in all, the assumption is that the container is trusted as would be the binary distribution of AWS CLI (if only it worked).

## License

MPL-2.0
