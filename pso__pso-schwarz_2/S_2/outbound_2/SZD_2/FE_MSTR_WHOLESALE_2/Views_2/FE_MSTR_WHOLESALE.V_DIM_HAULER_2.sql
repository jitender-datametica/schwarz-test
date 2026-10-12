CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_hauler_2 (hauler_party_sid, status_cd, hauler_name, hauler_cd,
hauler_nr, dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg) AS SELECT party_sid AS hauler_party_sid,
 status_cd,
 hauler_name,
 hauler_cd,
 hauler_nr,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg
FROM szd_core.t_dim_hauler_2
WHERE dwh_valid_fg;