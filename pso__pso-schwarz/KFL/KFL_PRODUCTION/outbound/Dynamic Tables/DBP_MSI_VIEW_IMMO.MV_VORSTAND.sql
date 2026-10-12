CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_vorstand
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  o.mandant_id AS mandant_id,
  o.zustaendig_id AS mitarbeiter_id,
  MAX(z.vorname) AS vorname,
  MAX(z.nachname) AS nachname,
  MAX(z.anrede) AS anrede
FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per AS o
INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig AS z
  ON o.zustaendig_id = z.zustaendig_id AND o.mandant_id = z.mandant_id
WHERE
  o.zustaendig_typ_id = 1 AND o.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
  o.mandant_id,
  mitarbeiter_id;
