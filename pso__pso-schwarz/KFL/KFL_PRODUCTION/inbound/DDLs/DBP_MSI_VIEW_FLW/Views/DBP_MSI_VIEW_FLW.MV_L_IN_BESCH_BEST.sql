CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_BESCH_BEST
-- 26.10.2011 system_id entfernt
-- 03.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014
(
mandant_id
--, system_id
, best_beleg_id
, in_lief_id
, bestellart_id
, bestell_typ_id
, artikelart_id
, abweichung_fg
, einkaufsorganisation_id
)
AS
   SELECT
   v01.mandant_id, v01.best_beleg_id, v01.flw_lief_id AS in_lief_id, v01.bestellart_id, v01.bestell_typ_id, v01.artikelart_id, v01.abweichung_fg, v01.einkaufsorganisation_id

   FROM dbp_view.v_flw_besch_best v01

   WHERE v01.einkaufsorganisation_id IN (5000,5013,5014);