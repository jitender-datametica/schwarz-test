CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mo_art_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v0.mo_art_kz AS mo_art_kz,
  v1.mo_art_bez AS mo_art_bez
FROM kfl_production_dbp_view.v_immo_l_mo_art_2 AS v0
INNER JOIN kfl_production_dbp_view.v_immo_mo_art_spr_zu_2 AS v1
  ON v0.mandant_id = v1.mandant_id AND v0.mo_art_kz = v1.mo_art_kz AND v1.spr_id = 22
WHERE
  v0.mandant_id = 1;
