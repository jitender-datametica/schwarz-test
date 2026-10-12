CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIFT_DM_RETAILER_GD_SORT_2
(
 client_id
,rtl_grp_id
,rtl_grp_desc
,rtl_grp_desc_EN
,rtl_grp_tp
,clnt_rtl_grp_sort
,prot_fg
) AS
SELECT
 client_id
,rtl_grp_id
,rtl_grp_desc
,rtl_grp_desc_EN
,rtl_grp_tp
,clnt_rtl_grp_sort
,prot_fg
FROM P_LEW_MART_CM.V_LIL_LIFT_DM_RETAILER_GD_SORT_2 ;
