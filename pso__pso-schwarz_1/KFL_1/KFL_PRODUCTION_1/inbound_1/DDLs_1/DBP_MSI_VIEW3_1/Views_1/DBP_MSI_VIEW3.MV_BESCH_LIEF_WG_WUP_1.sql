CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_WG_WUP_1
(
 mandant_id
,wup_id
,nb_id
,lagerort_id
,diff_id
,dat_lief_soll
,lief_typ_id
,vertr_beleg_typ_id
,wg_id
,arthiertyp_id
,kunde_id
,wg_verkett_lief
,menge_lief_soll_bme
,menge_lief_soll_kolli
,betrag_lief_soll
,menge_lief_ist_bme
,menge_lief_ist_kolli
,betrag_lief_ist
,lief_pal_typ_id
,anzahl_position
,wrg_id
,mandant_id_kunde
,vk_netto_lief_soll
,vk_netto_lief_ist
,werbeware_id
,bestellart_id
,hu_status_id
,anzahl_packstueck
,brtvol_ladung_liter
,brtvol_ladung_liter_gedeckelt
,menge_lief_fehl_bme
,menge_lief_fehl_kolli
,betrag_lief_fehl
,vk_netto_lief_fehl
,wrg_typ_id
,auslieferungsgruppe_id

)
AS
-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt
-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt
-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
-- 31.08.2018 srom0404: intern. join auf wup_1 Tabelle lt. Email Anforderung (N. Wagner, S. Panzer)
-- Kennzahlen egal ob man das Attribut "Kunde" im Objekt Prompt vom neuen 05.03.02 auswählt oder nicht, die Kennzahlen in Summe gleich bleiben
-- Für andere Berichte darf das ruhig genauso sein -> Lösung in der View
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 09.02.2021 nwag2310: EWM-Lagerorte herausfiltern
-- AP0128635, SPEC0151986, dknop, adding aulieferungsgruppe_id
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_1 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)
--2023-09-13, dknop, INC7247056, adding coalesce for bestellart_id
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.lagerort_id
,v01.diff_id
,v01.dat_lief_soll
,v01.lief_typ_id
,v01.vertr_beleg_typ_id
,v01.wg_id
,v01.arthiertyp_id
,v01.kunde_id
,v01.wg_verkett_lief
,v01.menge_lief_soll_bme
,v01.menge_lief_soll_kolli
,v01.betrag_lief_soll
,v01.menge_lief_ist_bme
,v01.menge_lief_ist_kolli
,v01.betrag_lief_ist
,v01.lief_pal_typ_id
,v01.anzahl_position
,v01.wrg_id
,v01.mandant_id_kunde
,v01.vk_netto_lief_soll
,v01.vk_netto_lief_ist
,v01.werbeware_id
,COALESCE(CASE WHEN v01.bestellart_id='' THEN NULL ELSE v01.bestellart_id END, '-1') AS bestellart_id
,v01.hu_status_id
,v01.anzahl_packstueck
,v01.brtvol_ladung_liter
,v01.brtvol_ladung_liter_gedeckelt 
,v01.menge_lief_fehl_bme
,v01.menge_lief_fehl_kolli
,v01.betrag_lief_fehl
,v01.vk_netto_lief_fehl
,v01.wrg_typ_id
,auslieferungsgruppe_id
-- Das tbl Objekt ersetzt die bisherige Logik und materialisiert einen Join über mehrere Tabellen.
FROM DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_WG_WUP_1 v01
INNER JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v04
   ON v01.wrg_typ_id = v04.wrg_typ_id
   ;
    