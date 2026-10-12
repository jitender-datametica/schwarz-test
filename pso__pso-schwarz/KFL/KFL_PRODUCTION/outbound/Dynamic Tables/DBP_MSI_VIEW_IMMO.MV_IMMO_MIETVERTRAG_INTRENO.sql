CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  v3.mandant_id AS mandant_id,
  v3.mv_intreno AS mv_intreno,
  v3.mietvertrag_nr AS mietvertrag_nr,
  v3.partner_id AS partner_id,
  v3.partner_id AS konzessionaer_id,
  v2.dat_von AS dat_von,
  v2.dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS v3
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per AS v2
  ON v3.mandant_id = v2.mandant_id AND v3.mv_intreno = v2.mv_intreno;
