CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_umsatzmietvereinbarung_2 (
  mv_intreno STRING(20),
  miete_umsatz_prozent BIGNUMERIC(38, 0),
  flag_grey INT64
) AS
SELECT
  mv_intreno AS mv_intreno,
  MAX(miete_umsatz_prozent) AS miete_umsatz_prozent,
  flag_grey AS flag_grey
FROM (
  SELECT
    mv_intreno,
    CASE
      WHEN (
        COUNT(mv_intreno) OVER (PARTITION BY mv_intreno RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      ) > 1
      THEN 1
      ELSE 0
    END AS flag_grey,
    CASE
      WHEN ROUND(
        CAST(miete_umsatz_prozent - (
          AVG(miete_umsatz_prozent) OVER (PARTITION BY mv_intreno RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        ) AS NUMERIC),
        2
      ) = 0
      THEN miete_umsatz_prozent
      ELSE NULL
    END AS miete_umsatz_prozent
  FROM kfl_production_dbp_view.v_immo_umsatzmietvereinbarung_2
  WHERE
    CURRENT_DATE BETWEEN dat_von AND dat_bis
) AS v5
GROUP BY
  mv_intreno,
  flag_grey;
