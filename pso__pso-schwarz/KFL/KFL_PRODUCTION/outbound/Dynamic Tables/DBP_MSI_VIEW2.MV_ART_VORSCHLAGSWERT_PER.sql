CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_vorschlagswert_per
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id AS art_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  mandant_id AS mandant_id,
  sortimentslistenart_id AS sortimentslistenart_id,
  paletten_faktor_einh_id AS paletten_faktor_einh_id
FROM kfl_production_dbp_view.v_art_vorschlagswert_per
WHERE
  dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id = 1;
