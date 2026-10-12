CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_VARIANT_HIST_2

/*
#DescStart#
#$Revision: 8757 $, $LastChangedBy: aketley $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , mdm_item_variant_sid
    , variant_name
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   mdm_item_variant_sid,
   variant_name,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_item_variant_hist_2 ;