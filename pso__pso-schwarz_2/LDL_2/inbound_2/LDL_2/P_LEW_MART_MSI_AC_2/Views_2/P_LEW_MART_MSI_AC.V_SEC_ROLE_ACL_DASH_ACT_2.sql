CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SEC_ROLE_ACL_DASH_ACT_2
(
      dashboard_name
      ,dashboard_disp_name
      ,dashboard_cat_id
      ,dashboard_subcat_id
      ,dashboard_active_fg
      ,load_id
 )
AS
   SELECT
         dashboard_name,
   dashboard_disp_name,
   dashboard_cat_id,
   dashboard_subcat_id,
   dashboard_active_fg,
   load_id
   FROM p_lew_mart_msi.v_sec_role_acl_dash_act_2
;