# Common instructions : 
1 - Create an s3-bucket to write the output of your job (example : demo-glue-legislators + Your account number) 
2 - Create a policy in a Json format with the content of the file DemoGlueStudioPolicy

# Instructions specific to Glue Studio : 
3 - Create a role with Glue as Use case and a name starting with "AWSGlueServiceRole" (for example "AWSGlueServiceRole-legislators-demo")and attach the newly created policy to the role. 
4 - Create a new Job >> Choose notebook >> Upload existing one : Select the DemoGlueISNotebook.ipynb file. 
5 - Replace your bucket name in the first cell of the notebook and make sure you save the job otherwise you'll loose all the notebook content after closing the window. 

# Instruction specific to SageMaker Notebook Instances : 
3 - Create a Policy in a Json format with the content of the file DemoISNotebookInstancePassRole
4 - Create a role with SageMaker as Use case and and attach the newly created policy (DemoISNotebookInstancePassRole), the DemoGlueStudioPolicy created in the Common Instructions part, and the managed Policy AmazonSageMakerFullAccess.
5 - Follow the instructions of this documentation to install the lifecycle configuration enabling glue_pyspark kernel in SageMaker Notebook Instances. Make sure to select the Amazon Linux 2, JupyterLab 1 base image. For the creation-script, 
please use the lcc-glue-pyspark-on-create.sh script that I attached to this mail instead of the one provided in the documentation (it freezes the version of jupyter_client preventing some compatibility issues.)
6 - After completing all the steps, you can create the instance, open it and upload the DemoGlueISNotebook.ipynb notebook. 
https://docs.aws.amazon.com/glue/latest/dg/interactive-sessions-sagemaker.html

# Instruction Specific to SageMaker Studio : 
3 - As mentionned in the slide deck, you'll first need to have access to a SageMaker Domain. You can use the same role as the one created above for SageMaker Notebook instances. 
4 - Once an app created in your domain, you can launch a new instance with a SparkAnalytics2.0 Base image and a Glue PySpark kernel. 
5 - Then, you just have to upload the DemoGlueISNotebook.ipynb notebook. 

# Instructions specific to local jupyter for Interactive Sessions: 
3 - Make sure your AWS credentials are correctly set up locally. Also make sure that your assume by default the role created in the SageMaker Notebook Instance part above. (You can also assume this role in your notebook at the end of the 6th steps by running "%iam_role <your-role-arn>")
4 - With your command line go in the directory you want to develop in, run the script script-launch.sh (This script works fine on mac working station. If you use Windows, you would need to adapt it)
5 - Activate the environment your script has just created (source .venv/bin/activate on mac)
6 - run 'jupyter-notebook'. The command will open jupyter UI in your web browser. Upload the DemoGlueISNotebook.ipynb notebook in there and open it. 