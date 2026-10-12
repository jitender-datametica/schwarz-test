CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_SEC_ROLE_ACL
(
     security_role_id
   , security_role_desc
   , nav_rel_fg
)
AS
   SELECT
        security_role_id,
   security_role_desc,
   nav_rel_fg
   FROM p_lew_mart_msi.v_ref_sec_role_acl
;