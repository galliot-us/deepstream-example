#!/bin/bash

if [ ! -f ssd_mobilenet_v2/1/model.graphdef ]; then
    cd ssd_mobilenet_v2 && mkdir -p 1
    echo "Couldn't find SSD MobileNet V2 frozen_inference graph, downloading from model zoo...!"
    wget http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v2_coco_2018_03_29.tar.gz
    tar -xvf ssd_mobilenet_v2_coco_2018_03_29.tar.gz
    cp ssd_mobilenet_v2_coco_2018_03_29/frozen_inference_graph.pb 1/model.graphdef
    rm -rf ssd_mobilenet_v2_coco_2018_03_29.tar.gz ssd_mobilenet_v2_coco_2018_03_29/
    cd ..
fi

if  [ ! -f yolo_v3/yolov3-spp.weights ]; then
    mkdir -p yolo_v3 && cd yolo_v3
    echo "Couldn't find YOLO model, downloading from model zoo...!"
    wget https://pjreddie.com/media/files/yolov3-spp.weights
    wget https://raw.githubusercontent.com/pjreddie/darknet/master/cfg/yolov3-spp.cfg
    cd ..
fi 
patch -f /opt/nvidia/deepstream/deepstream-5.1/sources/objectDetector_Yolo/nvdsinfer_custom_impl_Yolo/nvdsparsebbox_Yolo.cpp yolo_parser_patch
cd /opt/nvidia/deepstream/deepstream-5.1/sources/objectDetector_Yolo
CUDA_VER=11.1 make -C nvdsinfer_custom_impl_Yolo
cp /opt/nvidia/deepstream/deepstream-5.1/sources/objectDetector_Yolo/nvdsinfer_custom_impl_Yolo/libnvdsinfer_custom_impl_Yolo.so /repo/yolo_v3
