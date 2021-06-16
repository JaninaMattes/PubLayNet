
#!/bin/bash

python2 -c 'python3 inference/infer_simple.py \
    --cfg configs/Mask-RCNN/e2e_mask_rcnn_X-101-64x4d-FPN_1x.yaml \
    --output-dir /tmp/detectron-visualizations \
    --image-ext png \
    --always-out \
    --im_or_folder image \
    --wts https://dax-cdn.cdn.appdomain.cloud/dax-publaynet/1.0.0/pre-trained-models/Mask-RCNN/model_final.pkl'