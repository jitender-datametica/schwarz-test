CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_WUP_SUM_2 -- #613296 Splitt Palettentyp 6 in 61 und 64, dadurch Entfernen der Felder menge_lief_ist_kolli, anzahl_position_gp, anzahl_palette_gp und anzahl_palette_mp - sschuecke 11.06.2015
(
    dat_lief_soll,
    kunde_id,
    lagerort_id,
    lief_pal_typ_id,
    lief_typ_id,
    mandant_id,
    nb_id,
    vertr_beleg_typ_id,
    wup_id,
    wg_verkett_lief,
    menge_lief_ist_kolli,
    anzahl_packstueck,
    anzahl_position,
    menge_lief_ist_bme,
    betrag_lief_ist,
    menge_lief_soll_bme,
    menge_lief_soll_kolli,
    werbeware_id,
    betrag_lief_soll,
    wrg_id,
    mandant_id_kunde,
    vk_netto_lief_soll,
    vk_netto_lief_ist,
    brtvol_ladung_liter,
    bestellart_id,
    hu_status_id,
    brtvol_ladung_liter_gedeckelt,
    menge_lief_fehl_bme,
    menge_lief_fehl_kolli,
    betrag_lief_fehl,
    vk_netto_lief_fehl,
    wrg_typ_id -- Anforderung 595645 Splittung bei Palettentyp 6
    --, menge_lief_ist_kolli_gp
    --, anzahl_position_gp
    --, anzahl_palette_gp
    --, anzahl_palette_mp
) AS
-- 22.01.2018 HMue2308: AP0012522, SPEC0027715 vol_ladung_liter Bezeichnung umgeändert in brtvol_ladung_liter und Feld ' brtvol_ladung_liter_gedeckelt'  hinzugefügt
-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt
-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt
-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
    v01.dat_lief_soll,
v01.kunde_id,
    v01.lagerort_id,
    v01.lief_pal_typ_id,
    v01.lief_typ_id,
    v01.mandant_id,
    v01.nb_id,
    v01.vertr_beleg_typ_id,
    v01.wup_id,
    v01.wg_verkett_lief,
    v01.menge_lief_ist_kolli,
    v01.anzahl_packstueck,
    v01.anzahl_position,
    v01.menge_lief_ist_bme,
v01.betrag_lief_ist,
v01.menge_lief_soll_bme,
v01.menge_lief_soll_kolli,
    v01.werbeware_id,
v01.betrag_lief_soll,
    v01.wrg_id,
v01.mandant_id_kunde,
v01.vk_netto_lief_soll,
v01.vk_netto_lief_ist,
    v01.brtvol_ladung_liter,
    v01.bestellart_id,
    v01.hu_status_id,
    v01.brtvol_ladung_liter_gedeckelt, -- die dazugehörige netvol_ladung_liter wird mit FrontEnd Metriken gedeckelt
v01.menge_lief_fehl_bme,
v01.menge_lief_fehl_kolli,
v01.betrag_lief_fehl,
v01.vk_netto_lief_fehl,
    v01.wrg_typ_id --,v01.menge_lief_ist_kolli_gp
    --,v01.anzahl_position_gp
    --,v01.anzahl_palette_gp
    --,v01.anzahl_palette_mp
FROM
    DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_WUP_SUM_2 v01 
       INNER JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v04
       ON v01.wrg_typ_id = v04.wrg_typ_id
WHERE
    v01.dat_bis = '9999-12-31'
    AND v01.kurstyp_id = 3;