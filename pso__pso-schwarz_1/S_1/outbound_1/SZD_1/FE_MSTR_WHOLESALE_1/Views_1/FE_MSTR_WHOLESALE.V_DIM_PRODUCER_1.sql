CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_producer_1 (producer_party_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp
, dwh_valid_fg, status_cd, producer_name, email_txt, producer_name_txt) AS SELECT party_sid AS producer_party_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 status_cd,
 producer_name,
 email_txt,
 source_producer_name_address_city_txt AS producer_name_txt
FROM szd_core.t_dim_producer_1
WHERE dwh_valid_fg;