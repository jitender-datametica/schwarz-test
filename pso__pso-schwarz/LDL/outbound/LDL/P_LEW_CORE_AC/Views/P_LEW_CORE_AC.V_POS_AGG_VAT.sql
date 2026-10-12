CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_pos_agg_vat (client_id, aggr_nr, aggr_rec_nr, curr_sid, tax_type_cd, tax_val
, curr_cd, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 aggr_nr,
 aggr_rec_nr,
 curr_sid,
 tax_type_cd,
 tax_val,
 curr_cd,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_pos_agg_vat;