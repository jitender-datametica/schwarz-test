CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_anlage_klasse_spr_zu_cz
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  anlage_klasse_id AS anlage_klasse_id,
  anlage_klasse_bez_kurz AS anlage_klasse_bez_kurz,
  anlage_klasse_bez AS anlage_klasse_bez
FROM kfl_production_dbp_view.v_anlage_klasse_spr_zu
WHERE
  spr_id = 124 AND anlage_klasse_bez_kurz <> 'inaktiv';
