CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ITEM_WORKFLOW_STATUS_1

(
    client_id
    , workflow_status_id
    , workflow_status
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   workflow_status_id,
   workflow_status,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_mdm_item_workflow_status_1 ;