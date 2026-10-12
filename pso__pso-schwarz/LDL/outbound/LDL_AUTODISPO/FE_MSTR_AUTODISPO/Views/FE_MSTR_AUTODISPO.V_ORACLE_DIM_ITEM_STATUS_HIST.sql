CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item_status_hist (country, dis_wh, dis_item_nr,
dis_packagecapacity, dis_status, dis_status_date, active_fg, mod_date, source_extraction_tmsp, dwh_valid_from_date,
dwh_valid_to_date) AS SELECT country,
 dis_wh,
 dis_item_nr,
 dis_packagecapacity,
 dis_status,
 dis_status_date,
 active_fg,
 mod_date,
 source_extraction_tmsp,
 DATE(dwh_valid_from_tmsp) AS dwh_valid_from_date,
 DATE(dwh_valid_to_tmsp) AS dwh_valid_to_date
FROM ldl_autodispo_core.t_oracle_v_dim_item_status
WHERE active_fg = 1;