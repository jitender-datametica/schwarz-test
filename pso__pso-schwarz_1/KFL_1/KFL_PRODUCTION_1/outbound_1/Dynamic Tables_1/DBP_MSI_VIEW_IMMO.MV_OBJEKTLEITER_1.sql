CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_objektleiter_1 (
  mandant_id BIGNUMERIC(38, 0),
  mitarbeiter_id BIGNUMERIC(38, 0),
  vorname STRING(40),
  nachname STRING(40),
  anrede STRING(10)
) AS
SELECT
  o.mandant_id AS mandant_id,
  o.zustaendig_id AS mitarbeiter_id,
  MAX(kfl_production_dbp_process.transcriptc(z.vorname)) AS vorname,
  MAX(kfl_production_dbp_process.transcriptc(z.nachname)) AS nachname,
  MAX(z.anrede) AS anrede
FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_1 AS o
INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_1 AS z
  ON o.zustaendig_id = z.zustaendig_id AND o.mandant_id = z.mandant_id
WHERE
  o.zustaendig_typ_id = 2 AND o.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
  o.mandant_id,
  mitarbeiter_id;
