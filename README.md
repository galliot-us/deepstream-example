# Neuralet Face Anonymizer with DeepStream
This repository contains the codebase related to our article on creating a face anonymizer application with [Nvidia DeepStream](https://developer.nvidia.com/deepstream-sdk).
Neuralet have published two other articles which walk you through the features of Nvidia DeepStream and its python Bindings.
[Part 1](https://neuralet.com/article/deploying-neuralet-adaptive-learning-models-using-nvidia-deepstream)
[Part 2](https://neuralet.com/article/nvidia-deepstream-python-bindings-customize-your-applications)


## Prerequisites
1. X86 device with a Nvidia GPU
2. CUDA 11.1+
3. [Docker](https://docs.docker.com/get-docker/) and [Nvidia Docker Toolkit](https://github.com/NVIDIA/nvidia-docker)

## Getting Started
1. Clone The repository:
```
git clone https://github.com/neuralet/deepstream-example.git

cd deepstream-example
```
 1. build the docker image:
```
docker build -f face_annonymizer_ds_51_x86.Dockerfile -t "neuralet/face_anonymizer_ds:x86" .
```
 2. Run the docker image:
```
docker run -it  --runtime nvidia --gpus all -v "$PWD/":/repo neuralet/face_anonymizer_ds:x86
``` 
 3. Run the `prepare_models.bash` to download the object detectors and build the required modules:
```
bash ./prepare_models.bash
```
 4. run one of runner scripts based on the chosen object detector:

For SSD MobileNet V2 Detector:
    
```
python3 deepstream_face_anonymizer_ssd.py --config config_infer_primary_ssd_mobilenet.txt --label_path labels.txt  --input_video [PATH OF THE INPUT VIDEO] --out_dir [PATH OF THE OUTPUT VIDEO FILE]
``` 


For YOLO V3 SPP Detector:
```
python3 deepstream_face_anonymizer_yolo.py --config config_infer_primary_yolo_mobilenet.txt --label_path labels.txt  --input_video [PATH OF THE INPUT VIDEO] --out_dir [PATH OF THE OUTPUT VIDEO FILE]
```
