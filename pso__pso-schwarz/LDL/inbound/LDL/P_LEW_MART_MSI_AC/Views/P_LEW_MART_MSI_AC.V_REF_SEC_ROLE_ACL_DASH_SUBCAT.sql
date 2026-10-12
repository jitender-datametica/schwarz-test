CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_SEC_ROLE_ACL_DASH_SUBCAT
(
  dashboard_subcat_id
 ,dashboard_subcat_name
 ,dashboard_cat_id
)
AS
   SELECT
     dashboard_subcat_id,
   dashboard_subcat_name,
   dashboard_cat_id
   FROM p_lew_mart_msi.v_ref_sec_role_acl_dash_subcat
;