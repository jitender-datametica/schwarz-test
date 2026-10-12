CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_ek_infosatz_1 (
  mandant_id BIGNUMERIC(38, 0),
  ek_infosatz_id INT64,
  art_id BIGNUMERIC(38, 0),
  gp_id BIGNUMERIC(38, 0),
  crossdocking_id BIGNUMERIC(38, 0),
  einkaufsorganisation_id BIGNUMERIC(38, 0),
  dat_erstellung DATE,
  gp_art_id STRING(40),
  dat_von DATE,
  dat_bis DATE,
  lieferbar_fg STRING(1),
  regel_gp_fg STRING(1),
  loesch_fg STRING(1),
  max_ek_infosatz_fg STRING(1),
  gp_teilsortiment_id STRING(10),
  konditionsgruppe_id STRING(10),
  apollo_ian STRING(35)
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.ek_infosatz_id AS ek_infosatz_id,
  v01.art_id AS art_id,
  v01.gp_id AS gp_id,
  v01.crossdocking_id AS crossdocking_id,
  v01.einkaufsorganisation_id AS einkaufsorganisation_id,
  v01.dat_erstellung AS dat_erstellung,
  v01.gp_art_id AS gp_art_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  CASE
    WHEN DATE_SUB(CURRENT_DATE, INTERVAL '1' DAY) BETWEEN v01.dat_von AND v01.dat_bis
    THEN 'X'
    ELSE ' '
  END AS lieferbar_fg,
  CASE WHEN v01.regel_gp_fg = 1 THEN 'X' ELSE ' ' END AS regel_gp_fg,
  CASE WHEN v01.loesch_fg = 1 THEN 'X' ELSE ' ' END AS loesch_fg,
  CASE WHEN NOT v02.max_ek_infosatz_id IS NULL THEN 'X' ELSE ' ' END AS max_ek_infosatz_fg,
  COALESCE(v01.gp_teilsortiment_id, '999999') AS gp_teilsortiment_id,
  v01.konditionsgruppe_id AS konditionsgruppe_id,
  v01.apollo_ian AS apollo_ian
FROM kfl_production_dbp_view.v_ek_infosatz_1 AS v01
LEFT JOIN (
  SELECT
    mandant_id,
    art_id,
    MAX(ek_infosatz_id) AS max_ek_infosatz_id
  FROM kfl_production_dbp_view.v_ek_infosatz_1
  GROUP BY
    mandant_id,
    art_id
) AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v01.ek_infosatz_id = v02.max_ek_infosatz_id
QUALIFY
  (
    RANK() OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(v01.art_id AS STRING), CAST(v01.gp_id AS STRING)
      ORDER BY v01.ek_infosatz_id IS NULL, v01.ek_infosatz_id
    )
  ) = 1;
