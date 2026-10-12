CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_STOREVAT_WVEH_PROCESSED
AS
   SELECT
         client_id,
   loc_sid_store,
   vat_exception,
   item_sid,
   vat_pct,
   dwh_valid_from,
   dwh_valid_to,
   dwh_created
   FROM p_lew_process.t_storevat_wveh_processed
;