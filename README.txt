Description
This is the source code for the OWL model, which is applicable for people of
European ancestry aged 40 years and older who have not been diagnosed lung cancer.

File list:
'OWL.R' file
'data' folder
"example_data.rdata"  file
'dictionary.xlsx' file.

Usage
The following are the step for using the code.
Step 1: First, you should use the 'source' function to load the 'OWL' function.
Step 2: Second, you should use the 'OWL' function to predict individuals' lung cancer risk by providing
            two parameters.

Arguments.
data: the personal information must be a data frame. The description of 'data' is detailed in the 'dictionary.xlsx' file. 
wd: path to the owl model 'data' folder.

Output.
The output of the OWL function is a list, named 'prediction', containing two objects:
risk_score: the OWL score for lung cancer, which has the interpretation of relative risk, i.e, HR = exp( risk_score)
absolute_risk: the absolute risk for lung cancer, i.e, the probability of lung cancer, within 8-years follow-up.

Example
setwd('H:/Lungcancer model2/系统开发/GitHub')
load('example_data.rdata')
source('OWL.R',encoding ='UTF-8')
OWL_pred = OWL(data =example_data,
                             wd = 'H:/Lungcancer model2/系统开发/GitHub/data')
print(OWL_pred)
                            
