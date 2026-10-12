CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_STC_ITEM_LOAD_STATUS_1
AS
   SELECT
       tabname,
   last_loaded_id

   FROM p_lew_process.t_stc_item_load_status_1;