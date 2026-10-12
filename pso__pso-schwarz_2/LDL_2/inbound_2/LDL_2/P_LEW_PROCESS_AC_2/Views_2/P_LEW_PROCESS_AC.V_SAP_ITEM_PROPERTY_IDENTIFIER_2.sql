CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_SAP_ITEM_PROPERTY_IDENTIFIER_2
(
  client_id,
  identifier_id,
  identifier_name,
  dwh_load_id,
  dwh_created,
  dwh_updated
)
AS
   SELECT
     client_id,
   identifier_id,
   identifier_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
 FROM p_lew_process.t_sap_item_property_identifier_2
;