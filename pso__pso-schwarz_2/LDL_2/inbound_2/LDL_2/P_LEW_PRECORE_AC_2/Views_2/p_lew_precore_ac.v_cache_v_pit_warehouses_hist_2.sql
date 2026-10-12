CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_warehouses_hist_2
(
  client_id
, srcinst_id
, srcinst_code
, cntry_id
, cntry_code
, warehs_id
, warehs_no
, warehs_code
, warehs_name
, warehs_valid_from
, warehs_valid_to
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
srcinst_id,
srcinst_code,
cntry_id,
cntry_code,
warehs_id,
warehs_no,
warehs_code,
warehs_name,
warehs_valid_from,
warehs_valid_to,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_warehouses_hist_2 ;




