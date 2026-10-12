CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_client (client_id, country_iso_cd, client_desc, client_desc_en,
client_short_desc, client_long_desc, client_long_desc_en, client_srt_cd, qr_srt_cd, cc_srt_cd, client_lvl,
currency_iso_cd, sd_chld_below_12, sd_chld_below_12_en, sd_chld_over_12, sd_chld_over_12_en) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_client;