CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_SIZE_2

/*
#DescStart#
#$Revision: 8419 $, $LastChangedBy: dklinck $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , mdm_item_size_sid
    , src_item_doc_ref
    , src_size_cd
    , size_name
    , mdm_item_sid
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   mdm_item_size_sid,
   src_item_doc_ref,
   src_size_cd,
   size_name,
   mdm_item_sid,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_item_size_2 ;