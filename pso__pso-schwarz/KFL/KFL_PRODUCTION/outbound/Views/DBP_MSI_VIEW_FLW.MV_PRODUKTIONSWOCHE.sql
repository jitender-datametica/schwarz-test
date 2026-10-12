-- 23.04.12: twie Neue Berechnungslogik
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_produktionswoche (pjwo
, akt_pjwo, pjwo_vw) AS -- alle Datensaetze des heutigen Wochentages ausgeben, somit ein Datensatz pro Woche
 SELECT T1
 .pjwo,
 T1.akt_wo AS akt_pjwo,
 T3.pjwo AS pjwo_vw
FROM kfl_production_dbp_view.v_tag AS T1
 INNER JOIN kfl_production_dbp_view.v_tag AS T2 ON T1.wtag_id = T2.wtag_id AND T2.akt_tag = 0
 INNER JOIN kfl_production_dbp_view.v_tag AS T3 ON T1.dat = DATE_ADD(T3.dat, INTERVAL 7 DAY);