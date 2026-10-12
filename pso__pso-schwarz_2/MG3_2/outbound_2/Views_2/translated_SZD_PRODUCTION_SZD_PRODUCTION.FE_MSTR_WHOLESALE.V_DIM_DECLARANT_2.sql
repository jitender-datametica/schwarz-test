CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_declarant_2 (party_sid, declarant_type_cd,
declarant_type_name, declarant_nr, declarant_name, declarant_auth_status_cd, declarant_auth_status_name,
declarant_authorized_fg) AS SELECT party_sid,
 declarant_type_cd,
 declarant_type_name,
 declarant_nr,
 declarant_name,
 declarant_auth_status_cd,
 declarant_auth_status_name,
 declarant_authorized_fg
FROM szd_production_core.t_dim_declarant_2
WHERE dwh_valid_fg;