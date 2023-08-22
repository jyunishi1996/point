FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-runtime
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libxrender-dev \
    libgl1 libgomp1 build-essential wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install open3d
RUN pip install openmim
RUN mim install mmcv-full mmdet mmsegmentation
WORKDIR /workspace
RUN git clone https://github.com/open-mmlab/mmdetection3d.git
WORKDIR /workspace/mmdetection3d
RUN mkdir checkpoints
# デモプログラム用の学習済みモデルをダウンロード
RUN wget -P ./checkpoints/ https://download.openmmlab.com/mmdetection3d/v0.1.0_models/second/hv_second_secfpn_6x8_80e_kitti-3d-car/hv_second_secfpn_6x8_80e_kitti-3d-car_20200620_230238-393f000c.pth
# CenterPoint用の学習済みモデルをダウンロードしておく
RUN wget -P ./checkpoints/ https://download.openmmlab.com/mmdetection3d/v1.0.0_models/centerpoint/centerpoint_01voxel_second_secfpn_circlenms_4x8_cyclic_20e_nus/centerpoint_01voxel_second_secfpn_circlenms_4x8_cyclic_20e_nus_20220810_030004-9061688e.pth
RUN pip install -e .