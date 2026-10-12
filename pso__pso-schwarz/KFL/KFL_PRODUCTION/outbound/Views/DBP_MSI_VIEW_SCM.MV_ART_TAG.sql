CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_tag AS SELECT MARC.mandant_id,
 MARC.art_id,
 CAL.dat,
 COUNT(DISTINCT CASE
   WHEN MARC.kdis = 0
   THEN MARC.wup_id
   ELSE NULL
   END) AS anz_maerkte_dis,
 COUNT(DISTINCT CASE
   WHEN MARC.kdis = 1
   THEN MARC.wup_id
   ELSE NULL
   END) AS anz_maerkte_kdis
FROM kfl_production_dbp_view.v_tag AS CAL
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS MARC ON CAL.dat BETWEEN MARC.dat_von AND MARC.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_list_wup_zu_per AS WLK1 ON MARC.mandant_id = WLK1.mandant_id AND MARC.wup_id =
      WLK1.wup_id AND MARC.nb_id = WLK1.nb_id AND MARC.art_id = WLK1.art_id AND CAL.dat BETWEEN WLK1.dat_von AND WLK1.dat_bis
   
 INNER JOIN kfl_production_dbp_view.v_wup AS W ON WLK1.mandant_id = W.mandant_id AND WLK1.wup_id = W.wup_id AND WLK1.nb_id
      = W.nb_id AND W.nb_id = 0 AND CAL.dat BETWEEN W.dat_von AND W.dat_bis
WHERE CAL.dat < CURRENT_DATE
 AND CAL.akt_kj >= - 2
GROUP BY MARC.mandant_id,
 MARC.art_id,
 CAL.dat;