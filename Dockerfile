# Use Caffe2 image as parent image
FROM caffe2/caffe2:snapshot-py2-cuda9.0-cudnn7-ubuntu16.04

RUN mv /usr/local/caffe2 /usr/local/caffe2_build
ENV Caffe2_DIR /usr/local/caffe2_build

ENV PYTHONPATH /usr/local/caffe2_build:${PYTHONPATH}
ENV LD_LIBRARY_PATH /usr/local/caffe2_build/lib:${LD_LIBRARY_PATH}

RUN sudo apt-get update -y

# Clone the Detectron repository needs Linux
RUN git clone https://github.com/facebookresearch/detectron /detectron

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install Cython

# Install python packages
RUN sudo apt-get update -y
RUN sudo apt-get install -y cmake
RUN sudo apt-get install -y gcc g++
RUN sudo apt-get install -y python-dev python-numpy
RUN sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
RUN sudo apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
RUN sudo apt-get install -y libgtk2.0-dev
RUN sudo apt-get install -y pyqt5-dev-tools pyqt5-dev

# Install packages to support image formats
RUN sudo apt-get install -y libpng-dev
RUN sudo apt-get install -y libjpeg-dev
RUN sudo apt-get install -y libopenexr-dev
RUN sudo apt-get install -y libtiff-dev
RUN sudo apt-get install -y libwebp-dev
RUN sudo apt-get install -y libjasper-dev

# Build opencv from source
RUN sudo apt-get -y install git
RUN git clone https://github.com/opencv/opencv.git 
RUN cd opencv

RUN mkdir build 
RUN cd build

RUN cmake ../
RUN make

# Install the COCO API
RUN git clone https://github.com/cocodataset/cocoapi.git /cocoapi
WORKDIR /cocoapi/PythonAPI
RUN make install

# Go to Detectron root
WORKDIR /detectron

# Set up Python modules
RUN make

# Clone local Repository
# Create working directory
# RUN mkdir -p /usr/src/publaynet
WORKDIR /publaynet

# Copy contents
COPY . . /publaynet

# Set environment variables
# ENV HOME=/usr/src/publaynet

# EXPOSE 80

# CMD ["main:publaynet", "--port", "80"]

#---------------------------------------------------------------------------------------------------    
# build conainer: docker build -t docker-ml-model-v1 .
# run container: docker run -dit docker-ml-model-v1
# run interactive mode: docker run -it docker-ml-model-v1 /bin/bash
# inference: docker run docker-ml-model-v1 python3 ./inference/infer_simple.py --cfg ./configs/Mask-RCNN/e2e_mask_rcnn_X-101-64x4d-FPN_1x.yaml --output-dir ./tmp/detectron-visualizations --image-ext png --always-out --im_or_folder image --wts https://dax-cdn.cdn.appdomain.cloud/dax-publaynet/1.0.0/pre-trained-models/Mask-RCNN/model_final.pkl