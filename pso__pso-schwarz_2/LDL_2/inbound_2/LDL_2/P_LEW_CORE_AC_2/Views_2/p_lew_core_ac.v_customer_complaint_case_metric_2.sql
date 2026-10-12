CREATE OR REPLACE VIEW p_lew_core_ac.v_customer_complaint_case_metric_2 (
	client_id                            
   ,cust_complaint_sid                  
   ,cust_complaint_metric_type_cd     
   ,cust_complaint_metric_measure     
   ,deleted_fg                        
   ,dwh_valid_from                      
   ,dwh_valid_to                       
   ,dwh_load_id                         
   ,dwh_created                        
   ,dwh_updated     
) AS SELECT
	client_id                            
   ,cust_complaint_sid                  
   ,cust_complaint_metric_type_cd     
   ,cust_complaint_metric_measure     
   ,deleted_fg                        
   ,dwh_valid_from                      
   ,dwh_valid_to                       
   ,dwh_load_id                         
   ,dwh_created                        
   ,dwh_updated     
FROM p_lew_core.t_customer_complaint_case_metric_2;