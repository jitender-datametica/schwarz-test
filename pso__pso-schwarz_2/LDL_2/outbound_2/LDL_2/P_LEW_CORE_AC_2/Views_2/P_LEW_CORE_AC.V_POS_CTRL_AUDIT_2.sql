CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pos_ctrl_audit_2 (client_id, loc_sid, register_id, cashier_id,
cashier_status_id, audit_type_id, audit_nr, audit_cnt, audit_val, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 loc_sid,
 register_id,
 cashier_id,
 cashier_status_id,
 audit_type_id,
 audit_nr,
 audit_cnt,
 audit_val,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pos_ctrl_audit_2;