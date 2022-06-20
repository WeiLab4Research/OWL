# get result of owl_system.
OWL = function(data, # The personal information must be a data frame. 
               wd # Path to the owl model 'data' folder. 
               ){
  setwd(wd)

  # Load two packages.
  if(!require(Matrix)){
    install.packages('Matrix')
  }else{
    library(Matrix)
  }
  
  if(!require(xgboost)){
    install.packages('xgboost')
  }else{
    library(xgboost)
  }
  
  # Load OWL model and extra data for OWL model.
  load('extra_data_for_OWL_model.rdata')
  owl = xgb.load('OWL_model')
  
  vindependets = extra_data$vindependents
  beta = extra_data$beta
  baseline_hazard = extra_data$baseline_hazard
  
  # check and clean your data.
  if(!is.data.frame(data)){
    cat("The data is not a 'data.frame', and calculate is stopped.\n")
    return(NULL)
  }
  
  ds = data
  # Never smoker, the age_begin_smoke define as 99.
  ds$age_begin_smoke[which(ds$smoke_status==0)] = 99
  
  # Feature-engineer.
  ds$age_trans = (ds$age/100)^-2
  ds$bmi_trans = (ds$bmi)^-1
  ds$ncig_trans = ifelse(ds$ncig==0,100,(ds$ncig/10)^-1)
  
  xgb_ds = list(data = Matrix(data.matrix(ds[, vindependets]),
                              sparse = TRUE))
  
  risk = predict(owl, 
                 newdata = xgb.DMatrix(data = xgb_ds$data))
  
  # Calculate the OWL risk score
  riskscore =  beta * log(risk)
  
  # Calculate the OWL absolute risk within 8-years follow-up.
  surv_prob = exp(exp(riskscore) %*% -matrix(baseline_hazard[,1],nrow = 1))
  absolute_risk_t = 1 - surv_prob[, findInterval(1:8, baseline_hazard[,2])]
  
  if(nrow(surv_prob)==1){
    names(absolute_risk_t) = paste0('Year_',1:8)
  }else{
    colnames(absolute_risk_t) = paste0('Year_',1:8)
  }
  
  return(prediction = list(risk_score = riskscore,
                           absolute_risk = absolute_risk_t))
  
}




