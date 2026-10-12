CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_kostenstelle_2 AS SELECT mandant_id,
 nb_id,
 wup_id,
 buchungskreis_id,
 gs_kostenstelle_id,
 gs_kostenstelle_bez
FROM (SELECT DISTINCT wp01.mandant_id,
    wp01.wup_id,
    wp01.nb_id,
    wp01.buchungskreis_id,
    GSS.kostenstelle_id AS gs_kostenstelle_id,
    wp01.wup_standort AS gs_kostenstelle_bez,
    ROUND(CAST(CASE
       WHEN SUBSTR(GSS.kostenstelle_id, 6, 3) = '200' AND SUBSTR(GSS.kostenstelle_id, 1, 1) NOT IN ('0', '9')
       THEN SUBSTR(CAST(CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS FLOAT64) + 2 AS STRING), 1, 10)
       ELSE SUBSTR(GSS.kostenstelle_id, 1, 4)
       END AS BIGNUMERIC), 0) AS gs_wup_id
   FROM kfl_production_dbp_view.v_gutschein_2 AS GSS
    INNER JOIN (SELECT mandant_id,
      nb_id,
      wup_id,
      wup_standort,
      buchungskreis_id
     FROM kfl_production_dbp_view.v_wup_2
     WHERE nb_id IN (- 2, - 1, 0, 2, 7)
      AND dat_eroeffnung > DATE('1900-01-01')
      AND dat_von > DATE('1900-01-01')) AS wp01 ON GSS.mandant_id = wp01.mandant_id AND wp01.wup_id = CAST(CASE
        WHEN SUBSTR(GSS.kostenstelle_id, 6, 3) = '200' AND SUBSTR(GSS.kostenstelle_id, 1, 1) NOT IN ('0', '9')
        THEN SUBSTR(CAST(CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS FLOAT64) + 2 AS STRING), 1, 10)
        ELSE SUBSTR(GSS.kostenstelle_id, 1, 4)
        END AS FLOAT64)
   WHERE GSS.transaktion_id = 4
   UNION ALL
   SELECT DISTINCT GSS.mandant_id,
    0 AS wup_id,
    - 1 AS nb_id,
     CASE
     WHEN GSS.mandant_id = 1 AND STRPOS(GSS.kostenstelle_id, '-800P') <> 0
     THEN 1
     WHEN GSS.mandant_id = 1 AND STRPOS(GSS.kostenstelle_id, '-800') <> 0
     THEN 100
     ELSE COALESCE(ikp.buchungskreis_id, 0)
     END AS buchungskreis_id,
    GSS.kostenstelle_id AS gs_kostenstelle_id,
    COALESCE(iksz.kostenstelle_bez, GSS.kostenstelle_id) AS gs_kostenstelle_bez,
    ROUND(CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0) AS gs_wup_id
   FROM kfl_production_dbp_view.v_gutschein_2 AS GSS
    LEFT JOIN (SELECT mandant_id,
      kostenstelle_id,
      buchungskreis_id
     FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
     WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT (mandant_id, kostenstelle_id, MAX(dat_bis))
        FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
        GROUP BY mandant_id,
         kostenstelle_id)) AS ikp ON GSS.mandant_id = ikp.mandant_id AND GSS.kostenstelle_id = ikp.kostenstelle_id
    LEFT JOIN (SELECT mandant_id,
      kostenstelle_id,
      kostenstelle_bez
     FROM kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_2
     WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT (mandant_id, kostenstelle_id, MAX(dat_bis))
        FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
        GROUP BY mandant_id,
         kostenstelle_id)
      AND spr_id = 22) AS iksz ON GSS.mandant_id = iksz.mandant_id AND GSS.kostenstelle_id = iksz.kostenstelle_id
   WHERE GSS.transaktion_id = 4
    AND (GSS.mandant_id, ROUND(CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0)) NOT IN (SELECT (mandant_id,
        wup_id)
      FROM kfl_production_dbp_view.v_wup_2
      WHERE nb_id IN (- 2, - 1, 0, 2, 7)
       AND dat_eroeffnung > DATE('1900-01-01')
       AND dat_von > DATE('1900-01-01'))) AS sub01;