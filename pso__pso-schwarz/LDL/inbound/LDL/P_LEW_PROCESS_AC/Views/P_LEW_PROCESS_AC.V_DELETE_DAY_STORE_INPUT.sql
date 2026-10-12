CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_DELETE_DAY_STORE_INPUT
AS
SELECT
client_id,
orig_store_nr,
dat_dayend,
delete_area,
user_input,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_process.t_delete_day_store_input
;


