# OWL-lung-cancer-risk-prediction-model

Description
This is the source code for the OWL model, which is applicable for people of
European ancestry aged 40 years and older who have not been diagnosed lung cancer.

File list:
'OWL.R'
'data.zip'
"example_data.rdata"
'dictionary.xlsx'

Usage
The following are the step for using the code.
Step 1: First, decompress the 'data.zip' file.
Step 2: Second, Start the R software and use the 'source' function to load the 'OWL' function.
Step 3: Finally, you could use the 'OWL' function to predict individuals' lung cancer risk by providing
            two parameters.

Arguments
data: the personal information must be a data frame. The description of 'data' is detailed in the 'dictionary.xlsx' file. 
wd: path to the owl model 'data' folder.

Output
The output of the OWL function is a list, named 'prediction', containing two objects:
risk_score: the OWL score for lung cancer, which has the interpretation of relative risk, i.e, HR = exp( risk_score)
absolute_risk: the absolute risk for lung cancer, i.e, the probability of lung cancer, within 8-years follow-up.

Example
setwd('C:/Users/NX/Desktop/OWL')
load('example_data.rdata')
source('OWL.R',encoding ='UTF-8')
OWL_pred = OWL(data =example_data,
                             wd = 'C:/Users/NX/Desktop/OWL/data')
print(OWL_pred)
                            
