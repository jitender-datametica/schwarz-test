CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_gutschein_1 AS SELECT GSS.mandant_id,
 GSS.gutschein_id,
 GSS.zeitstempel,
 CAST(GSS.zeitstempel AS STRING) AS dat,
 CAST(GSS.zeitstempel AS TIME) AS uhrzeit,
 GSS.system_id,
 GSS.profil_id,
 GSS.ereignisquelle_id,
 GSS.transaktion_id,
 GSS.ausgeber_typ_id,
 CAST(CASE
   WHEN GSS.ausgeber_id IN ('', ' ')
   THEN '0'
   ELSE GSS.ausgeber_id
   END AS STRING) AS ausgeber_id,
 GSS.wrg_id,
 1 AS gutschein_anzahl,
 GSS.betrag_gutschein AS gutschein_betrag,
 kstl.wup_id,
 kstl.nb_id,
 kstl.buchungskreis_id,
 kstl.gs_kostenstelle_id,
 kstl.gs_kostenstelle_bez,
 GSS.kostenstelle_id AS kostl_gss,
 SUBSTR(CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS STRING), 1, 4) AS kostl_wup
FROM kfl_production_dbp_view.v_gutschein_1 AS GSS
 INNER JOIN (SELECT DISTINCT wp01.mandant_id,
    wp01.wup_id,
    wp01.nb_id,
    GSS.gutschein_id,
    wp01.buchungskreis_id,
    GSS.kostenstelle_id AS gs_kostenstelle_id,
    wp01.wup_standort AS gs_kostenstelle_bez,
     CASE
     WHEN SUBSTR(GSS.kostenstelle_id, 6, 3) = '200' AND SUBSTR(GSS.kostenstelle_id, 1, 1) NOT IN ('0', '9')
     THEN IFNULL(ROUND(SAFE_CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0) + 2, 2)
     ELSE IFNULL(ROUND(SAFE_CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0), 0)
     END AS gs_wup_id
   FROM kfl_production_dbp_view.v_gutschein_1 AS GSS
    INNER JOIN (SELECT mandant_id,
      nb_id,
      wup_id,
      wup_standort,
      buchungskreis_id
     FROM kfl_production_dbp_view.v_wup_1
     WHERE nb_id IN (- 2, - 1, 0, 2, 7)
      AND dat_eroeffnung > DATE '1900-01-01'
      AND dat_von > DATE '1900-01-01') AS wp01 ON GSS.mandant_id = wp01.mandant_id AND wp01.wup_id = CASE
       WHEN SUBSTR(GSS.kostenstelle_id, 6, 3) = '200' AND SUBSTR(GSS.kostenstelle_id, 1, 1) NOT IN ('0', '9')
       THEN IFNULL(ROUND(SAFE_CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0) + 2, 2)
       ELSE IFNULL(ROUND(SAFE_CAST(SUBSTR(GSS.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0), 0)
       END
   WHERE GSS.transaktion_id = 4
   UNION ALL
   SELECT DISTINCT GSS.mandant_id,
    0 AS wup_id,
    - 1 AS nb_id,
    GSS.gutschein_id,
     CASE
     WHEN GSS.mandant_id = 1 AND STRPOS(GSS.kostenstelle_id, '-800P') <> 0
     THEN 1
     WHEN GSS.mandant_id = 1 AND STRPOS(GSS.kostenstelle_id, '-800') <> 0
     THEN 100
     ELSE COALESCE(ikp.buchungskreis_id, 0)
     END AS buchungskreis_id,
    GSS.kostenstelle_id AS gs_kostenstelle_id,
    COALESCE(iksz.kostenstelle_bez, GSS.kostenstelle_id) AS gs_kostenstelle_bez,
    ROUND(CAST(IF(SUBSTR(GSS.kostenstelle_id, 1, 4) = '', SUBSTR(SAFE_CAST(0 as STRING), 1, 10), SUBSTR(GSS.kostenstelle_id, 1, 4)) AS BIGNUMERIC)
     , 0) AS gs_wup_id
   FROM kfl_production_dbp_view.v_gutschein_1 AS GSS
    LEFT JOIN (SELECT mandant_id,
      kostenstelle_id,
      buchungskreis_id
     FROM kfl_production_dbp_view.v_in_kostenstelle_per_1
     WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT (mandant_id, kostenstelle_id, MAX(dat_bis))
        FROM kfl_production_dbp_view.v_in_kostenstelle_per_1
        GROUP BY mandant_id,
         kostenstelle_id)) AS ikp ON GSS.mandant_id = ikp.mandant_id AND GSS.kostenstelle_id = ikp.kostenstelle_id
    LEFT JOIN (SELECT mandant_id,
      kostenstelle_id,
      kostenstelle_bez
     FROM kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_1
     WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT (mandant_id, kostenstelle_id, MAX(dat_bis))
        FROM kfl_production_dbp_view.v_in_kostenstelle_per_1
        GROUP BY mandant_id,
         kostenstelle_id)
      AND spr_id = 22) AS iksz ON GSS.mandant_id = iksz.mandant_id AND GSS.kostenstelle_id = iksz.kostenstelle_id
   WHERE GSS.transaktion_id = 4
    AND (GSS.mandant_id, ROUND(CAST(IF(SUBSTR(GSS.kostenstelle_id, 1, 4) = '', SUBSTR(SAFE_CAST(0 as STRING), 1, 10), SUBSTR(GSS.kostenstelle_id, 1, 4)) AS BIGNUMERIC)
       , 0)) NOT IN (SELECT (mandant_id, wup_id)
      FROM kfl_production_dbp_view.v_wup_1
      WHERE nb_id IN (- 2, - 1, 0, 2, 7)
       AND dat_eroeffnung > DATE '1900-01-01'
       AND dat_von > DATE '1900-01-01')) AS kstl ON GSS.mandant_id = kstl.mandant_id AND GSS.gutschein_id = kstl.gutschein_id;