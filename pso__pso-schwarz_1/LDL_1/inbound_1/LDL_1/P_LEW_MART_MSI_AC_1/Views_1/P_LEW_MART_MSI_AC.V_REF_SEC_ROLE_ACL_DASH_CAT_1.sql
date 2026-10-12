CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_SEC_ROLE_ACL_DASH_CAT_1
(
  dashboard_cat_id
 ,dashboard_cat_name
 ,dashboard_subcat_id
)
AS
   SELECT
     dashboard_cat_id,
   dashboard_cat_name,
   dashboard_subcat_id
   FROM p_lew_mart_msi.v_ref_sec_role_acl_dash_cat_1
;