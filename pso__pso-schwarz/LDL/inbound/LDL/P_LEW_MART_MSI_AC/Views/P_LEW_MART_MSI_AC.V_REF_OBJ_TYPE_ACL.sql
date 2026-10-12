CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_OBJ_TYPE_ACL
(
    object_type_id
  , object_type_name
)
AS
   SELECT
       object_type_id,
   object_type_name
  FROM p_lew_mart_msi.v_ref_obj_type_acl
;