CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_psa_item_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.env_cd,
 A.report_id AS psa_report_id,
 C.client_id,
 A.nat_item_nr AS orig_item_nr
FROM ldl_p_lew_process_ac.v_psa_report_items_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS B ON A.country_iso_cd = B.country_iso_cd
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS C ON B.country_id = C.country_id;