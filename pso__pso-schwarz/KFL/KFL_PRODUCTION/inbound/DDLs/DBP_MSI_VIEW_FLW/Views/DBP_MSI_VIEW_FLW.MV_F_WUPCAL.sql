CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_WUPCAL
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 25.11.2014 twie: Datensaetze mit bonanzahl = 0 entfernt, damit keine 0-Zeilen im Bericht
-- 29.08.2019 twie: NSR0924862 bonanzahl durch bonanzahl_sug ersetzt, da bessere Datenqualitaet

(
wup_id,
mandant_id,
nb_id,
dat,
offen,
werbewoche,
bonanzahl,
datenlieferung,
bonanzahl_misvier,
datenlieferung_artbew,
datenlieferung_bonanzahl,
datenlieferung_misvier,
datenlieferung_qbm_status
)
AS
   SELECT
 v01.wup_id,
   v01.mandant_id,
   v01.nb_id,
   v01.dat,
   v01.offen,
   v01.werbewoche,
   v01.bonanzahl_sug AS bonanzahl,
   CASE WHEN v01.datenlieferung_artbew_wg_sum = 2 THEN 0
   WHEN v01.datenlieferung_artbew_wg_sum=3 THEN 0
   --WHEN v01.datenlieferung_artbew_wg_sum=' ' THEN 0
   ELSE v01.datenlieferung_artbew_wg_sum END,
   v01.bonanzahl_misvier,
   v01.datenlieferung_artbew,
   v01.datenlieferung_bonanzahl,
   v01.datenlieferung_misvier,
   v01.datenlieferung_qbm_status
   FROM dbp_view.v_wupcal v01

   WHERE v01.mandant_id IN (1,2)
   AND v01.bonanzahl_sug > 0
;