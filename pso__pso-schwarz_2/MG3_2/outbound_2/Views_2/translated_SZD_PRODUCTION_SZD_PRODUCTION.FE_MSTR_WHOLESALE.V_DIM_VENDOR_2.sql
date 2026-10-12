CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_vendor_2 (vendor_party_sid, dwh_valid_from_tmsp,
dwh_valid_to_tmsp, dwh_valid_fg, status_cd, vendor_name, email_txt, vendor_name_txt) AS SELECT party_sid AS
 vendor_party_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 status_cd,
 vendor_name,
 email_txt,
 source_vendor_name_address_city_txt AS vendor_name_txt
FROM szd_production_core.t_dim_vendor_2
WHERE dwh_valid_fg;