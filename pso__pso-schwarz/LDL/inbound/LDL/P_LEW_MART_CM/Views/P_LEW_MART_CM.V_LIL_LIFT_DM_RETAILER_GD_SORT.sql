CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_LIFT_DM_RETAILER_GD_SORT
(
 client_id
,rtl_grp_id
,rtl_grp_desc
,rtl_grp_desc_EN
,rtl_grp_tp
,clnt_rtl_grp_sort
,prot_fg
)
AS 
 SELECT 
 CAST(client_id AS SMALLINT) AS client_id
 ,rtl_id AS rtl_grp_id 
 ,CAST(rtl_desc AS VARCHAR(128)) AS rtl_grp_desc
 ,CAST(rtl_desc_EN AS VARCHAR(128)) AS rtl_grp_desc 
 ,rtl_tp_id AS rtl_grp_tp
 ,clnt_rtl_srt_cd AS clnt_rtl_grp_sort
 ,CAST(0 AS BYTEINT) AS prot_fg
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_lift_dm_retailer_gd_sort;
