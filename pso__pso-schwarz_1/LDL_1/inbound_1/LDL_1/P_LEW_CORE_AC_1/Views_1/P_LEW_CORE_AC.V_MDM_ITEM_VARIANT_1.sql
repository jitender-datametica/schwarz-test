CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_VARIANT_1

/*
#DescStart#
#$Revision: 8756 $, $LastChangedBy: aketley $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , mdm_item_variant_sid
    , src_item_doc_ref
    , src_variant_cd
    , variant_name
    , mdm_item_sid
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   mdm_item_variant_sid,
   src_item_doc_ref,
   src_variant_cd,
   variant_name,
   mdm_item_sid,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_item_variant_1 ;