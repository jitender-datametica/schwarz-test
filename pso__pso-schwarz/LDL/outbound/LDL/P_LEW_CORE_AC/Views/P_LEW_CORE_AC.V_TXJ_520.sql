CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_txj_520 (client_id, loc_sid, item_sid, item_nr, record_cd, snapshot_tmsp,
sales_qty, sales_val, returns_qty, returns_val, voids_qty, voids_val, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated
) AS SELECT client_id,
 loc_sid,
 item_sid,
 item_nr,
 record_cd,
 snapshot_tmsp,
 sales_qty,
 sales_val,
 returns_qty,
 returns_val,
 voids_qty,
 voids_val,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_txj_520;