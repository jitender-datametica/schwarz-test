CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_art_wup_zu_per_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 wup_id,
 dat_von,
 nb_id,
 art_id,
 bezugsweg_id,
 listung_id,
 vk_brutto,
 dat_bis,
 kdis
FROM kfl_production_dbp_view.v_art_wup_zu_per_2
WHERE dat_bis = DATE '9999-12-31'
 AND mandant_id = 1;