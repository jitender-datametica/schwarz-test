CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_f_vz_bestand_erp_monat
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id AS art_id,
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  gjmo AS gjmo,
  lagerort_id AS lagerort_id,
  menge_lgbest_erp_frei_bme AS menge_vzbest_erp_frei_bme,
  menge_lgbest_erp_umlag_bme AS menge_vzbest_erp_umlag_bme,
  menge_lgbest_erp_qual_bme AS menge_vzbest_erp_qual_bme,
  menge_lgbest_erp_nf_charge_bme AS menge_vzbest_erp_nf_charge_bme,
  menge_lgbest_erp_gesp_bme AS menge_vzbest_erp_gesp_bme,
  menge_lgbest_erp_ret_gesp_bme AS menge_vzbest_erp_ret_gesp_bme
FROM kfl_production_dbp_view.v_bestand_erp_monat AS t1
WHERE
  nb_id = -111 AND mandant_id = 1;
