CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_psa_report_items (env_cd, report_id, country_iso_cd, nat_item_nr) AS
SELECT env_cd,
 report_id,
 country_iso_cd,
 nat_item_nr
FROM ldl_p_lew_process.t_psa_report_items;