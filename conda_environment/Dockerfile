FROM mambaorg/micromamba:2.3.2

ARG ENV_NAME=WXS_env
ARG HCC_MCR_URL=https://conda.anaconda.org/hcc/linux-64/mcr-8.3-0.tar.bz2
ARG HCC_GISTIC2_URL=https://conda.anaconda.org/hcc/linux-64/gistic2-2.0.23-h8fb1749_1.tar.bz2

WORKDIR /tmp/build

COPY environment.yaml /tmp/build/environment.yaml
COPY export-env.sh /usr/local/bin/export-env
COPY gistic2-wrapper.sh /usr/local/bin/gistic2-wrapper.sh

RUN chmod +x /usr/local/bin/export-env /usr/local/bin/gistic2-wrapper.sh && \
    micromamba create -y -n "${ENV_NAME}" --strict-channel-priority -f /tmp/build/environment.yaml && \
    micromamba install -y -n "${ENV_NAME}" "${HCC_MCR_URL}" "${HCC_GISTIC2_URL}" && \
    ln -sf libncurses.so.6 /opt/conda/envs/${ENV_NAME}/lib/libncurses.so.5 && \
    ln -sf libncursesw.so.6 /opt/conda/envs/${ENV_NAME}/lib/libncursesw.so.5 && \
    mv /opt/conda/envs/${ENV_NAME}/bin/gistic2 /opt/conda/envs/${ENV_NAME}/bin/gistic2.real && \
    cp /usr/local/bin/gistic2-wrapper.sh /opt/conda/envs/${ENV_NAME}/bin/gistic2 && \
    chmod +x /opt/conda/envs/${ENV_NAME}/bin/gistic2 && \
    mkdir -p /opt/artifacts && \
    micromamba run -n "${ENV_NAME}" conda-pack -n "${ENV_NAME}" -o /opt/artifacts/${ENV_NAME}.tar.gz && \
    micromamba clean --all --yes

ENV ENV_NAME=${ENV_NAME}
ENV ENV_ARCHIVE=/opt/artifacts/${ENV_NAME}.tar.gz
ENV ENV_PREFIX=/opt/conda/envs/${ENV_NAME}

ENTRYPOINT ["/usr/local/bin/export-env"]
CMD ["/out/WXS_env"]
