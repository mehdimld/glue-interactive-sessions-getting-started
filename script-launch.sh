#!/bin/bash
read -p "Python version: (python3.6, python3.7, python3.8, python3.9): " python_version
echo "Python version selected: $python_version"
$python_version -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install --upgrade jupyter boto3 aws-glue-sessions aws-cdk-lib
pip freeze > requirements.txt
sudo jupyter kernelspec install .venv/lib/$python_version/site-packages/aws_glue_interactive_sessions_kernel/glue_pyspark
sudo jupyter kernelspec install .venv/lib/$python_version/site-packages/aws_glue_interactive_sessions_kernel/glue_spark