#!/bin/bash
set -ex
sudo -u ec2-user -i <<'EOF'
 
ANACONDA_DIR=/home/ec2-user/anaconda3
 
# Create and Activate Conda Env
echo "Creating glue_pyspark conda enviornment"
conda create --name glue_pyspark python=3.7 ipykernel jupyter jupyter_client==7.4.8  nb_conda -y
pip install --upgrade jupyter_client

echo "Activating glue_pyspark"
source activate glue_pyspark
 
# Install Glue Sessions to Env
echo "Installing AWS Glue Sessions with pip"
pip install aws-glue-sessions
 
# Clone glue_pyspark to glue_scala. This is required because I had to match kernel naming conventions to their environments and couldn't have two kernels in one conda env. 
echo "Cloning glue_pyspark to glue_scala"
conda create --name glue_scala --clone glue_pyspark
 
# Remove python3 kernel from glue_pyspark
rm -r ${ANACONDA_DIR}/envs/glue_pyspark/share/jupyter/kernels/python3
rm -r ${ANACONDA_DIR}/envs/glue_scala/share/jupyter/kernels/python3
 
# Copy kernels to Jupyter kernel env (Discoverable by conda_nb_kernel)
echo "Copying Glue PySpark Kernel"
cp -r ${ANACONDA_DIR}/envs/glue_pyspark/lib/python3.7/site-packages/aws_glue_interactive_sessions_kernel/glue_pyspark/ ${ANACONDA_DIR}/envs/glue_pyspark/share/jupyter/kernels/glue_pyspark/
 
echo "Copying Glue Spark Kernel"
mkdir ${ANACONDA_DIR}/envs/glue_scala/share/jupyter/kernels
cp -r ${ANACONDA_DIR}/envs/glue_scala/lib/python3.7/site-packages/aws_glue_interactive_sessions_kernel/glue_spark/ ${ANACONDA_DIR}/envs/glue_scala/share/jupyter/kernels/glue_spark/
 
echo "Changing Jupyter kernel manager from EnvironmentKernelSpecManager to CondaKernelSpecManager"
JUPYTER_CONFIG=/home/ec2-user/.jupyter/jupyter_notebook_config.py
 
sed -i '/EnvironmentKernelSpecManager/ s/^/#/' ${JUPYTER_CONFIG}
echo "c.CondaKernelSpecManager.name_format='conda_{environment}'" >> ${JUPYTER_CONFIG}
echo "c.CondaKernelSpecManager.env_filter='anaconda3$|JupyterSystemEnv$|/R$'" >> ${JUPYTER_CONFIG}
 
EOF
systemctl restart jupyter-server  