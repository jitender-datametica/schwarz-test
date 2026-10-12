CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_VARIANT_CLIENT_HIST_1

/*
#DescStart#
#$Revision: 8756 $, $LastChangedBy: aketley $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , mdm_item_variant_sid
    , client_id_recipient
    , int_org_sid
    , client_block_id
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
    client_id
  , mdm_item_variant_sid
  , client_id_recipient
  , int_org_sid
  , client_block_id
  , deleted_fg
  , dwh_valid_from
  , dwh_valid_to
  , dwh_load_id
  , dwh_created
  , dwh_updated
  FROM p_lew_core.t_mdm_item_variant_client_hist_1 ;