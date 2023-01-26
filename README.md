# How to use AWS Glue Interactive Session to run the the Notebook DemoGlueISNotebook.ipynb
### Common instructions : 
*These are the instructions you should complete whatever the AWS Services you choose to run your notebook.*

1 - Create an s3-bucket to write the output of your job (example : demo-glue-legislators + Your account number).   
2 - Create an iam policy in a JSON format with the content of the file DemoGlueStudioPolicy.   

### Instructions specific to Glue Studio : 
*Compelete these instructions if you want to run the notebook with AWS Glue Studio.*

3 - Create a role with Glue as Use case and a name starting with "AWSGlueServiceRole" (for example "AWSGlueServiceRole-legislators-demo") and attach the newly created policy to the role.   
4 - Create a new Job >> Choose notebook >> Upload existing one : Select the DemoGlueISNotebook.ipynb file.    
5 - Replace your bucket name in the first cell of the notebook and make sure you save the job otherwise you'll loose all the notebook content after closing the window.    

### Instructions specific to AWS SageMaker Notebook Instances : 
*Compelete these instructions if you want to run the notebook with AWS SageMaker Notebook Instance. The role creation can be useful also for SageMaker Studio and Local Jupyter parts.*

3 - Create a Policy in a Json format with the content of the file DemoISNotebookInstancePassRole.   
4 - Create a Role with SageMaker as Use case and and attach the newly created policy (DemoISNotebookInstancePassRole), the DemoGlueStudioPolicy created in the Common Instructions part, and the Managed Policy AmazonSageMakerFullAccess. You need to add glue.amazonaws.com in the Trust Relationships Tab of the role along with sagemaker.amazonaws.com   
5 - Follow the instructions of [this documentation](https://docs.aws.amazon.com/glue/latest/dg/interactive-sessions-sagemaker.html) to install the lifecycle configuration enabling glue_pyspark kernel in SageMaker Notebook Instances. **Make sure to select the Amazon Linux 2, JupyterLab 1 base image. For the creation-script, please use the lcc-glue-pyspark-on-create.sh script that I attached to this mail instead of the one provided in the documentation (it freezes the version of jupyter_client preventing some compatibility issues.)**     
6 - After completing all the steps, you can create the instance, open it and upload the DemoGlueISNotebook.ipynb notebook. Make sure to replace your bucket name in the first cell of the notebook.    

### Instructions specific to SageMaker Studio : 
*Compelete these instructions if you want to run the notebook with AWS SageMaker Studio.*

3 - You'll first need to have access to a SageMaker Domain. For the Studio execution role, you can use the same role as the one created above for SageMaker Notebook instances (as it provides SageMakerFullAcess). 
4 - Once an app created in your domain, you can launch a new instance with a **SparkAnalytics2.0** base image and a **Glue PySpark kernel**. 
5 - Then, you just have to upload the DemoGlueISNotebook.ipynb notebook. Make sure to replace your bucket name in the first cell of the notebook.

### Instructions specific to local jupyter for Interactive Sessions: 
*Compelete these instructions if you want to run the notebook with a local Jupyter.*

3 - Make sure your AWS credentials are correctly set up locally. Also, make sure that your assume by default the role created in the SageMaker Notebook Instance part above. You can also assume this role in your notebook at the end of the 5th steps below by running 
```
%iam_role <your-role-arn>
```  
4 - With your command line go in the directory you want to develop in, run the script script-launch.sh (This script works fine on macOs. If you use Windows, you would need to adapt it).   
5 - Activate the environment your script has just created (source .venv/bin/activate on macOs) and run 'jupyter-notebook'. The command will open jupyter UI in your web browser. Upload the DemoGlueISNotebook.ipynb notebook in there and open it. Make sure to replace your bucket name in the first cell of the notebook.   
```
source .venv/bin/activate  
jupyter-notebook
```  

