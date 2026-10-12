CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_apt_advert_theme_client (client_id, advert_theme_sid,
advert_theme, deleted_fg, excluded_fg, dwh_created) AS SELECT client_id,
 advert_theme_sid,
 advert_theme,
 deleted_fg,
 excluded_fg,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_theme_client AS APT;