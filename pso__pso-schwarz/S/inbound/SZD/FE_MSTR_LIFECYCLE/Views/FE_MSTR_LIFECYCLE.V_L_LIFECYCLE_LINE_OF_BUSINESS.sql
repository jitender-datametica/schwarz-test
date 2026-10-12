CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_LINE_OF_BUSINESS 
AS SELECT 
 core.t_dim_line_of_business.lob_cd
,core.t_dim_line_of_business.lob_name
FROM 
core.t_dim_line_of_business
WHERE 
LOB_CD = 'K'
OR 
LOB_CD = 'L'
;