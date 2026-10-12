CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_bon_wup_1 (mandant_id, nb_id, wup_id, kjmo, bon_ref,
bon_ref_kvj, bon_ugs, bon_ugs_kvj, kundenfaktor) AS SELECT COALESCE(wc01.mandant_id, wc02.mandant_id) AS mandant_id,
 COALESCE(wc01.nb_id, wc02.nb_id) AS nb_id,
 WUP.aktuell_wup_id AS wup_id,
 COALESCE(wc01.kjmo, wc02.kjmo + 100) AS kjmo,
 wc01.bonanzahl AS bon_ref,
 wc02.bonanzahl AS bon_ref_kvj,
  CASE
  WHEN wc01.nb_id = 0
  THEN wc01.bonanzahl_sug
  ELSE wc01.bonanzahl
  END AS bon_ugs,
  CASE
  WHEN wc02.nb_id = 0
  THEN wc02.bonanzahl_sug
  ELSE wc02.bonanzahl
  END AS bon_ugs_kvj,
 COALESCE(WUP.kundenfaktor, 1) AS kundenfaktor
FROM (SELECT WC.mandant_id,
   WC.nb_id,
   WC.wup_id,
   ZEIT.kjmo,
   SUM(WC.bonanzahl) AS bonanzahl,
   SUM(WC.bonanzahl_sug) AS bonanzahl_sug
  FROM kfl_production_dbp_view.v_wupcal_1 AS WC
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT_1 ON WC.dat = ZEIT.dat AND ZEIT.akt_gj BETWEEN - 1 AND 0 AND WC.nb_id
     IN (0, 2, 7)
  GROUP BY WC.mandant_id,
   WC.wup_id,
   WC.nb_id,
   ZEIT.kjmo) AS wc01
 FULL JOIN (SELECT WC0.mandant_id,
   WC0.nb_id,
   WC0.wup_id,
   ZEIT0.kjmo,
   SUM(WC0.bonanzahl) AS bonanzahl,
   SUM(CASE
     WHEN ZEIT0.kjmo > 201502
     THEN WC0.bonanzahl_sug
     ELSE 0
     END) AS bonanzahl_sug
  FROM kfl_production_dbp_view.v_wupcal_1 AS WC0
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT0 ON WC0.dat = ZEIT0.dat AND ZEIT0.akt_gj BETWEEN - 2 AND (- 1) AND
     WC0.nb_id IN (0, 2, 7)
  GROUP BY WC0.mandant_id,
   WC0.wup_id,
   WC0.nb_id,
   ZEIT0.kjmo) AS wc02 ON wc01.mandant_id = wc02.mandant_id AND wc01.wup_id = wc02.wup_id AND wc02.kjmo = wc01.kjmo -
    100
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON WUP.mandant_id = COALESCE(wc01.mandant_id, wc02.mandant_id) AND WUP_1
   .wup_id = COALESCE(wc01.wup_id, wc02.wup_id);