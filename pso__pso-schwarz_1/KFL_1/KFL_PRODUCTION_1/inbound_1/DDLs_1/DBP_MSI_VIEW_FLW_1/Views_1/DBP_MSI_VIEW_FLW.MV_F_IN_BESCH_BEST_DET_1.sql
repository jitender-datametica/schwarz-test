CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_BESCH_BEST_DET_1
-- 26.10.2011 system_id entfernt
-- 08.10.2012 twie: nettopreis hinzu
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO_1 beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014

(
mandant_id
--,system_id
,best_beleg_id
,best_beleg_pos_id
,in_art_id
,loesch_id
,werk_id
,menge_best_bme
,best_menge_einh_id
,retourenpos_fg
,dupli_fg
,besch_pos_typ_id
,nettopreis
)
AS
   SELECT v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id, v01.flw_art_id AS in_art_id, v01.loesch_id, v01.werk_id, v01.menge_best_bme, v01.best_menge_einh_id, v01.retourenpos_fg, v01.dupli_fg, v01.besch_pos_typ_id, v01.nettopreis

   FROM dbp_view.v_flw_besch_best_det_1 v01

   JOIN dbp_view.v_flw_besch_best_1 v02
   ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v02.einkaufsorganisation_id IN (5000,5013,5014);