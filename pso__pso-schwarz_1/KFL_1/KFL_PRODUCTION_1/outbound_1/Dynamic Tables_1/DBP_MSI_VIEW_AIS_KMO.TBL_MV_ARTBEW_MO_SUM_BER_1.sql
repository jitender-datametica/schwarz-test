CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_mo_sum_ber_1 AS
WITH t_wup_bereinigt AS (
  SELECT
    v010.dat,
    v02.mandant_id,
    v02.wup_id,
    CASE
      WHEN v010.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v010.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
      WHEN v040.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v040.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
      WHEN CAST(v010.dat AS STRING) LIKE '%-02-29'
      THEN CASE
        WHEN v040.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
        AND (
          v040.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
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
  FROM kfl_production_dbp_view.v_tag_1 AS v010
  INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02
    ON v010.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
  LEFT JOIN kfl_production_dbp_view.v_tag_1 AS v03
    ON v010.dat = v03.dat_vj_kt
  LEFT JOIN kfl_production_dbp_view.v_tag_1 AS v040
    ON v010.dat = v040.dat_vj
  WHERE
    v010.dat BETWEEN CAST('2019-01-01' AS DATE) AND (
      DATE_ADD(CURRENT_DATE, INTERVAL '7' DAY)
    )
    AND v02.nb_id = 0
    AND v02.mandant_id <> 1
)
(
  SELECT
    v06.kjmo AS kjmo,
    v01.art_id AS art_id,
    v01.mandant_id AS mandant_id,
    v01.gp_id AS gp_id,
    v01.nb_id AS nb_id,
    v01.wup_id AS wup_id,
    v01.bewart_id AS bewart_id,
    v01.bewart_det_id AS bewart_det_id,
    v01.bq_findung_id AS bq_findung_id,
    v01.bezugsweg_id AS bezugsweg_id,
    SUBSTR(
      CASE
        WHEN v01.bewart_id = 1001 AND NOT v01.posten_id IN ('1')
        THEN 'SO'
        ELSE 'PN'
      END,
      1,
      2
    ) AS posten_id,
    SUBSTR(CASE WHEN NOT v01.posten_id IN ('1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz,
    SUBSTR(
      CASE
        WHEN v01.bewart_id = 1001 AND NOT v04.posten_id IN ('1')
        THEN 'SO'
        ELSE 'PN'
      END,
      1,
      2
    ) AS posten_id_per,
    SUBSTR(CASE WHEN NOT v04.posten_id IN ('1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
    v05.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    v05.wup_bereinigt_fg_vj AS wup_bereinigt_fg_vj,
    CASE
      WHEN v01.ean_kasse BETWEEN 100000 AND 999999
      THEN v01.ean_kasse * 10000000
      ELSE v01.ean_kasse
    END AS ean_kasse,
    v01.umrechnungskurs_hist AS umrechnungskurs_hist,
    SUM(v01.umsatz_netto) AS umsatz_netto,
    SUM(v01.diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
    SUM(CAST(v01.menge AS BIGNUMERIC)) AS menge
  FROM kfl_production_dbp_view.v_artbew_1 AS v01
  LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS v04
    ON v01.art_id = v04.art_id
    AND v01.mandant_id = v04.mandant_id
    AND v01.dat BETWEEN DATE_SUB(v04.dat_von, INTERVAL '1' DAY) AND (
      DATE_SUB(v04.dat_bis, INTERVAL '1' DAY)
    )
  LEFT JOIN t_wup_bereinigt AS v05
    ON v01.dat = v05.dat AND v01.mandant_id = v05.mandant_id AND v01.wup_id = v05.wup_id
  INNER JOIN kfl_production_dbp_view.v_tag_1 AS v06
    ON v01.dat = v06.dat
  WHERE
    v01.mandant_id > 1
    AND v01.dat >= CAST('2022-01-01' AS DATE)
    AND (
      v01.mandant_id <> 5 OR v01.art_id <> 206731500
    )
    AND (
      v01.mandant_id <> 2 OR v01.art_id <> 20812450
    )
    AND (
      v01.mandant_id <> 3 OR v01.art_id <> 20811369
    )
    AND (
      v01.mandant_id <> 6 OR v01.art_id <> 20813157
    )
    AND (
      NOT v01.mandant_id IN (4, 7) OR v01.art_id <> 20811474
    )
    AND (
      v01.mandant_id <> 8 OR v01.art_id <> 20813164
    )
  GROUP BY
    v06.kjmo,
    v01.art_id,
    v01.mandant_id,
    v01.gp_id,
    v01.nb_id,
    v01.wup_id,
    v01.bewart_id,
    v01.bewart_det_id,
    v01.bq_findung_id,
    v01.bezugsweg_id,
    v01.posten_id,
    posten_kz,
    posten_id_per,
    posten_kz_per,
    v05.wup_bereinigt_fg_akt,
    v05.wup_bereinigt_fg_vj,
    v01.ean_kasse,
    v01.umrechnungskurs_hist
);
