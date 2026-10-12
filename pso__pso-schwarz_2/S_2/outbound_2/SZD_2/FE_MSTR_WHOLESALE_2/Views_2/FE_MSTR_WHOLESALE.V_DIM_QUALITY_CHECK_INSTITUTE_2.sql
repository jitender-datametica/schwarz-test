CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_quality_check_institute_2 (qci_party_sid, dwh_valid_from_tmsp,
dwh_valid_to_tmsp, dwh_valid_fg, qci_name, qci_name_txt, status_cd) AS SELECT party_sid AS qci_party_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 qci_name,
 source_qci_name_address_city_txt AS qci_name_txt,
 status_cd
FROM szd_core.t_dim_quality_check_institute_2
WHERE dwh_valid_fg;