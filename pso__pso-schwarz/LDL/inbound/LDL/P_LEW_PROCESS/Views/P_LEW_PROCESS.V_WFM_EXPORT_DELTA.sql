CREATE OR REPLACE VIEW P_LEW_PROCESS.V_WFM_EXPORT_DELTA
AS
   SELECT
       tbl_upd.core_table_name,
   last_exp.process_name,
   last_exp.process_specification,
   last_exp.export_specification,
   last_exp.last_export_tmsp,
   last_exp.last_export_load_id,
   tbl_upd.client_id,
   tbl_upd.dwh_cal_dt,
   tbl_upd.create_timestamp
   FROM p_lew_process.t_agc_core_table_update tbl_upd
   INNER JOIN p_lew_process.v_wfm_last_export last_exp
   ON tbl_upd.create_timestamp > last_exp.last_export_tmsp
   INNER JOIN p_lew_process.v_wfm_export_specification expo_spec
   ON last_exp.export_specification = expo_spec.export_specification
   AND tbl_upd.client_id = expo_spec.client_id
WHERE tbl_upd.recalc_fg = 0
;