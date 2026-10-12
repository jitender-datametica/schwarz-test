CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item_status_all (country, dis_wh, dis_item_nr,
dis_packagecapacity, dis_status, dis_status_date, active_fg, mod_date, source_extraction_tmsp) AS SELECT country,
 dis_wh,
 dis_item_nr,
 dis_packagecapacity,
 dis_status,
 dis_status_date,
 active_fg,
 mod_date,
 source_extraction_tmsp
FROM ldl_autodispo_core.t_oracle_v_dim_item_status
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;