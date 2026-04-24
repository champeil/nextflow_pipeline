# DNAseq conda environment

This directory builds and publishes a relocatable `WXS_env` environment for the DNAseq pipeline as a Docker image.

The image contains:

- `/opt/conda/envs/WXS_env`: the built environment inside the container
- `/opt/artifacts/WXS_env.tar.gz`: a `conda-pack` archive for relocation
- `/usr/local/bin/export-env`: a helper that unpacks the archive into any mounted host directory

## Build locally

```bash
cd conda_environment/DNAseq
docker build -t wxs-env:latest .
```

## Export the environment directory from the image

```bash
mkdir -p ./WXS_env
docker run --rm -v "$PWD:/out" wxs-env:latest /out/WXS_env
```

After export:

```bash
./WXS_env/bin/python --version
./WXS_env/bin/fastqc --version
./WXS_env/bin/gistic2
```

## Pull from GHCR

After the GitHub Actions workflow publishes the image:

```bash
docker pull ghcr.io/champeil/nextflow_pipeline/wxs-env:latest
mkdir -p ./WXS_env
docker run --rm -v "$PWD:/out" ghcr.io/champeil/nextflow_pipeline/wxs-env:latest /out/WXS_env
```

## Notes

- `gistic2` is installed from the HCC conda artifacts because the original `hcc::gistic2` spec is sensitive to channel access during solve time.
- The exported directory is relocatable because it is unpacked from `conda-pack` and fixed up with `conda-unpack`.
- The Docker build adds a small `gistic2` wrapper plus `ncurses` compatibility symlinks so the exported directory can run `gistic2` directly.
