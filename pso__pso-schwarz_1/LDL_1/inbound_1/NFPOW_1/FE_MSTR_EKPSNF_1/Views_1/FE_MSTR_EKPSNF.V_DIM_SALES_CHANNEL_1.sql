CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_SALES_CHANNEL_1(
	 sales_channel_cd
	,sales_channel_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS 
(SELECT
	 sales_channel_cd
	,sales_channel_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_SALES_CHANNEL_1
);