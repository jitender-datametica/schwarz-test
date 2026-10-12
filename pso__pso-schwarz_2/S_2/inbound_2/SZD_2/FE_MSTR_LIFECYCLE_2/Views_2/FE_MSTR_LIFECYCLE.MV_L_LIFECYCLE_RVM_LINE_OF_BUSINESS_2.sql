CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_LINE_OF_BUSINESS_2 
AS SELECT 
 core.t_dim_line_of_business.lob_cd
,core.t_dim_line_of_business.lob_name
FROM 
core.t_dim_line_of_business_2
;