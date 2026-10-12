CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.tbl_wup_bereinigt (
  dat DATE,
  mandant_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  wup_bereinigt_fg_akt INT64,
  wup_bereinigt_fg_vj_wo INT64,
  wup_bereinigt_fg_vj INT64
) AS
SELECT
  v01.dat AS dat,
  v02.mandant_id AS mandant_id,
  v02.wup_id AS wup_id,
  CASE
    WHEN v01.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
    AND (
      v01.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
    )
    THEN 1
    ELSE 0
  END AS wup_bereinigt_fg_akt,
  CASE
    WHEN v04.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
    AND (
      v04.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
    )
    THEN 1
    ELSE 0
  END AS wup_bereinigt_fg_vj_wo,
  CASE
    WHEN CAST(v01.dat AS STRING) LIKE '%-02-29'
    THEN CASE
      WHEN v04.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v04.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END
    WHEN v03.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
    AND (
      v03.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
    )
    THEN 1
    ELSE 0
  END AS wup_bereinigt_fg_vj
FROM kfl_production_dbp_view.v_tag AS v01
INNER JOIN kfl_production_dbp_view.v_wup AS v02
  ON v01.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
LEFT JOIN kfl_production_dbp_view.v_tag AS v03
  ON v01.dat = v03.dat_vj_kt
LEFT JOIN kfl_production_dbp_view.v_tag AS v04
  ON v01.dat = v04.dat_vj
WHERE
  v01.dat BETWEEN CAST('2019-01-01' AS DATE) AND (
    DATE_ADD(CURRENT_DATE, INTERVAL '7' DAY)
  )
  AND v02.nb_id = 0;
