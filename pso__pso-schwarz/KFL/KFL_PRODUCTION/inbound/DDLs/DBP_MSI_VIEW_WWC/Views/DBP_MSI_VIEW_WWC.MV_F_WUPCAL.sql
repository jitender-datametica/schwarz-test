CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_F_WUPCAL
-- 03.03.2014 twie: Neu, für Ermittlung Anzahl Kunden
-- 16.07.2014 twie: bonanzahl_imbiss ausgeben
-- 30.11.2017 srom: bonanzahl_sug ausgeben (AP0019147, SPEC0028392)
(
wup_id,
mandant_id,
nb_id,
dat,
offen,
werbewoche,
bonanzahl,
bonanzahl_imbiss,
datenlieferung,
bonanzahl_misvier,
datenlieferung_artbew,
datenlieferung_bonanzahl,
datenlieferung_misvier,
datenlieferung_qbm_status,
bonanzahl_sug
)
AS
   SELECT
 v01.wup_id,
   v01.mandant_id,
   v01.nb_id,
   v01.dat,
   v01.offen,
   v01.werbewoche,
   v01.bonanzahl,
   v01.bonanzahl_imbiss,
   CASE WHEN v01.datenlieferung_artbew_wg_sum = 2 THEN 0
   WHEN v01.datenlieferung_artbew_wg_sum=3 THEN 0
   ELSE v01.datenlieferung_artbew_wg_sum END,
   v01.bonanzahl_misvier,
   v01.datenlieferung_artbew,
   v01.datenlieferung_bonanzahl,
   v01.datenlieferung_misvier,
   v01.datenlieferung_qbm_status,
   v01.bonanzahl_sug
   FROM dbp_view.v_wupcal v01
;