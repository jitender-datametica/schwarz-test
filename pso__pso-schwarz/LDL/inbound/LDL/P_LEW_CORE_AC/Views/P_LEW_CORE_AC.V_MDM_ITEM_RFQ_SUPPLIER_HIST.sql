CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_RFQ_SUPPLIER_HIST
(
    client_id
    , mdm_item_sid
    , mdm_rfq_sup_sid
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
   , mdm_item_sid
   , mdm_rfq_sup_sid
   , deleted_fg
   , dwh_valid_from
   , dwh_valid_to
   , dwh_load_id
   , dwh_created
   , dwh_updated
  FROM P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST ;