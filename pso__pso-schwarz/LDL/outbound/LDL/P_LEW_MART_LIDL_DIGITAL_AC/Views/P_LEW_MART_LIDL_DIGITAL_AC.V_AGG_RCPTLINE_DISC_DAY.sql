CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_rcptline_disc_day (client_id, loc_sid, dwh_cal_dt,
lidlplus_disc_fg, discount_val, load_id, dwh_inserted, dwh_updated) AS SELECT client_id,
 loc_sid,
 dwh_cal_dt,
 lidlplus_disc_fg,
 discount_val,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcptline_disc_day;