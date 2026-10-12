CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_MARKET_HIST_1
(
    client_id
    , mdm_item_sid
    , market_sid
    , mdm_incoterm_cd
    , mdm_completion_type_cd
    , invoice_curr_cd
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
    , market_sid
    , mdm_incoterm_cd
    , mdm_completion_type_cd
    , invoice_curr_cd
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
  FROM p_lew_core.t_mdm_item_market_hist_1 ;