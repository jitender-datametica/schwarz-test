CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_supplier (party_sid, supplier_party_sid, supplier_name,
source_supplier_name_address_city_txt, supplier_nr, sort_txt, email_txt, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, status_cd, supplier_name_txt) AS SELECT party_sid,
 party_sid AS supplier_party_sid,
 supplier_name,
 source_supplier_name_address_city_txt,
 supplier_nr,
 sort_txt,
 email_txt,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 status_cd,
 source_supplier_name_address_city_txt AS supplier_name_txt
FROM szd_core.t_dim_supplier
WHERE dwh_valid_fg;