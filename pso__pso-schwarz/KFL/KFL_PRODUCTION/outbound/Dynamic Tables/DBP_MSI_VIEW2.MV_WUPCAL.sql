CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_wupcal AS
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
      WHEN v03.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v03.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_vj,
    CASE
      WHEN v04.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v04.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_vj_wo
  FROM kfl_production_dbp_view.v_tag AS v010
  INNER JOIN kfl_production_dbp_view.v_wup AS v02
    ON v010.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
  INNER JOIN kfl_production_dbp_view.v_tag AS v03
    ON v010.dat = v03.dat_vj_kt
  INNER JOIN kfl_production_dbp_view.v_tag AS v04
    ON v010.dat = v04.dat_vj
  WHERE
    v010.dat BETWEEN CAST('2019-01-01' AS DATE) AND (
      DATE_ADD(CURRENT_DATE, INTERVAL '7' DAY)
    )
    AND v02.nb_id = 0
    AND v02.mandant_id = 1
)
(
  SELECT
    v01.wup_id AS wup_id,
    v01.mandant_id AS mandant_id,
    v01.nb_id AS nb_id,
    v01.dat AS dat,
    v01.offen AS offen,
    v01.werbewoche AS werbewoche,
    v01.bonanzahl AS bonanzahl,
    v01.bonanzahl_sug AS bonanzahl_sug,
    CASE
      WHEN v01.datenlieferung_artbew_wg_sum IS NULL
      OR v01.datenlieferung_artbew_wg_sum IN (2, 3)
      THEN 0
      ELSE v01.datenlieferung_artbew_wg_sum
    END AS datenlieferung,
    v01.bonanzahl_misvier AS bonanzahl_misvier,
    v01.datenlieferung_artbew AS datenlieferung_artbew,
    v01.datenlieferung_bonanzahl AS datenlieferung_bonanzahl,
    v01.datenlieferung_misvier AS datenlieferung_misvier,
    v01.datenlieferung_qbm_status AS datenlieferung_qbm_status,
    v01.dat_extrakt_umsatz AS dat_extrakt_umsatz,
    v02.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    v02.wup_bereinigt_fg_vj AS wup_bereinigt_fg_vj,
    v02.wup_bereinigt_fg_vj_wo AS wup_bereinigt_fg_vj_wo
  FROM kfl_production_dbp_view.v_wupcal AS v01
  LEFT JOIN t_wup_bereinigt AS v02
    ON v01.dat = v02.dat AND v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
  WHERE
    v01.mandant_id = 1 AND NOT v01.nb_id IN (2, 6, 7)
);
