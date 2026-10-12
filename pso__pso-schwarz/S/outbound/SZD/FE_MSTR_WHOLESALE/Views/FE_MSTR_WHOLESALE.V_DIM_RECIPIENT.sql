CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_recipient (recipient_party_sid, recipient_nr, recipient_name,
country_location_sid, country_iso_cd) AS SELECT party_sid AS recipient_party_sid,
 recipient_nr,
 recipient_name,
 country_location_sid,
 country_iso_cd
FROM szd_core.t_dim_recipient
WHERE dwh_valid_fg;