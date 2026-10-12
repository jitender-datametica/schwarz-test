CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_country_political_1 (client_id, country_pol_sid, src_land1, country_pol_name,
curr_sid, lang_sid, curr_cd, lang_cd, iso_code2, iso_code3, member_eu_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 country_pol_sid,
 src_land1,
 country_pol_name,
 curr_sid,
 lang_sid,
 curr_cd,
 lang_cd,
 iso_code2,
 iso_code3,
 member_eu_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_country_political_1;