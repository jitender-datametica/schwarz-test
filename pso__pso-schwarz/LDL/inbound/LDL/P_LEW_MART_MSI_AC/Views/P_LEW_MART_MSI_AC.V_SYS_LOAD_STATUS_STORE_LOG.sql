CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SYS_LOAD_STATUS_STORE_LOG
(
run_id
, client_id
, st_loc_sid
, kpi_id
, dat_dayend
, rec_cnt
, run_tmsp
 )
AS
SELECT
run_id,
client_id,
st_loc_sid,
kpi_id,
dat_dayend,
rec_cnt,
run_tmsp
FROM p_lew_mart_msi.t_sys_load_status_store_log;


