create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_LINE_OF_BUSINESS_2(
	LOB_CD,
	LOB_NAME
) as SELECT 
 core.t_dim_line_of_business.lob_cd
,core.t_dim_line_of_business.lob_name
FROM 
core.t_dim_line_of_business_2
WHERE 
LOB_CD = 'K'
OR 
LOB_CD = 'L'
;