CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_bonuskauf_mandant_kondition_2 (
  mandant_id BIGNUMERIC(38, 0),
  bonuskauf_id STRING(20),
  konditionsart_id STRING(4),
  geschaeftsvorfall_id STRING(2),
  dat_von DATE,
  dat_bis DATE,
  zeit_von TIME,
  zeit_bis TIME,
  dat DATE
) AS
SELECT
  *
FROM (
  SELECT
    v01.mandant_id,
    v01.bonuskauf_id,
    v01.konditionsart_id,
    v01.geschaeftsvorfall_id,
    v01.dat_von,
    v01.dat_bis,
    v01.zeit_von,
    v01.zeit_bis,
    v02.dat
  FROM kfl_production_dbp_view.v_l_bonuskauf_2 AS v01
  INNER JOIN kfl_production_dbp_view.v_tag_2 AS v02
    ON v01.dat_von <= v02.dat AND v01.dat_bis >= v02.dat
  WHERE
    v01.mandant_id <> 1
) AS alles
WHERE
  DATE_ADD(dat, INTERVAL '730' DAY) > CURRENT_DATE
  AND dat < DATE_ADD(CURRENT_DATE, INTERVAL '730' DAY);