CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_bon_wup_2 (mandant_id, nb_id, wup_id, dat, bon_ref,
bon_ref_wvj, bon_ref_kvj, bon_ugs, bon_ugs_wvj, bon_ugs_kvj, kundenfaktor) AS SELECT COALESCE(wc01.mandant_id, wc02.mandant_id
  , wc03.mandant_id) AS mandant_id,
 COALESCE(wc01.nb_id, wc02.nb_id, wc03.nb_id) AS nb_id,
 WUP.aktuell_wup_id AS wup_id,
 COALESCE(wc01.dat, DATE_ADD(wc02.dat, INTERVAL 364 DAY), IF(wc03.dat = LAST_DAY(wc03.dat), LAST_DAY(DATE_ADD(wc03.dat,
     INTERVAL 12 MONTH)), DATE_ADD(wc03.dat, INTERVAL 12 MONTH))) AS dat,
 SUM(COALESCE(wc01.bonanzahl, 0)) AS bon_ref,
 SUM(COALESCE(wc02.bonanzahl, 0)) AS bon_ref_wvj,
 SUM(COALESCE(wc03.bonanzahl, 0)) AS bon_ref_kvj,
 SUM(CASE
   WHEN wc01.nb_id = 0
   THEN wc01.bonanzahl_sug
   ELSE wc01.bonanzahl
   END) AS bon_ugs,
 SUM(CASE
   WHEN wc02.nb_id = 0
   THEN wc02.bonanzahl_sug
   ELSE wc02.bonanzahl
   END) AS bon_ugs_wvj,
 SUM(CASE
   WHEN wc03.nb_id = 0
   THEN wc03.bonanzahl_sug
   ELSE wc03.bonanzahl
   END) AS bon_ugs_kvj,
 AVG(COALESCE(WUP.kundenfaktor, 1)) AS kundenfaktor
FROM (SELECT WC.mandant_id,
   WC.nb_id,
   WC.wup_id,
   ZEIT.dat,
   ZEIT.kjmo,
   SUM(WC.bonanzahl) AS bonanzahl,
   SUM(WC.bonanzahl_sug) AS bonanzahl_sug
  FROM kfl_production_dbp_view.v_wupcal_2 AS WC
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS ZEIT_2 ON WC.dat = ZEIT.dat AND ZEIT.akt_gj BETWEEN - 1 AND 0 AND WC.nb_id
     IN (0, 2, 7)
  GROUP BY WC.mandant_id,
   WC.nb_id,
   WC.wup_id,
   ZEIT.dat,
   ZEIT.kjmo) AS wc01
 FULL JOIN (SELECT WC0.mandant_id,
   WC0.nb_id,
   WC0.wup_id,
   ZEIT0.dat,
   ZEIT0.kjmo,
   SUM(WC0.bonanzahl) AS bonanzahl,
   SUM(CASE
     WHEN ZEIT0.kjmo > 201502
     THEN WC0.bonanzahl_sug
     ELSE 0
     END) AS bonanzahl_sug
  FROM kfl_production_dbp_view.v_wupcal_2 AS WC0
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS ZEIT0 ON WC0.dat = ZEIT0.dat AND ZEIT0.akt_gj BETWEEN - 2 AND (- 1) AND
     WC0.nb_id IN (0, 2, 7)
  GROUP BY WC0.mandant_id,
   WC0.nb_id,
   WC0.wup_id,
   ZEIT0.dat,
   ZEIT0.kjmo) AS wc02 ON wc01.mandant_id = wc02.mandant_id AND wc01.wup_id = wc02.wup_id AND wc02.dat = DATE_SUB(wc01.dat
    ,INTERVAL 364 DAY)
 FULL JOIN (SELECT WC1.mandant_id,
   WC1.nb_id,
   WC1.wup_id,
   ZEIT1.dat,
   ZEIT1.kjmo,
   SUM(WC1.bonanzahl) AS bonanzahl,
   SUM(CASE
     WHEN ZEIT1.kjmo > 201502
     THEN WC1.bonanzahl_sug
     ELSE 0
     END) AS bonanzahl_sug
  FROM kfl_production_dbp_view.v_wupcal_2 AS WC1
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS ZEIT1 ON WC1.dat = ZEIT1.dat AND ZEIT1.akt_gj BETWEEN - 2 AND (- 1) AND
     WC1.nb_id IN (0, 2, 7)
  GROUP BY WC1.mandant_id,
   WC1.nb_id,
   WC1.wup_id,
   ZEIT1.dat,
   ZEIT1.kjmo) AS wc03 ON wc01.mandant_id = wc03.mandant_id AND wc01.wup_id = wc03.wup_id AND wc03.dat = IF(wc01.dat =
     LAST_DAY(wc01.dat), LAST_DAY(DATE_ADD(wc01.dat, INTERVAL - 12 MONTH)), DATE_ADD(wc01.dat, INTERVAL - 12 MONTH))
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WUP.mandant_id = COALESCE(wc01.mandant_id, wc02.mandant_id, wc03.mandant_id
    ) AND WUP.wup_id = COALESCE(wc01.wup_id, wc02.wup_id, wc03.wup_id)
GROUP BY mandant_id,
 nb_id,
 wup_id,
 dat;