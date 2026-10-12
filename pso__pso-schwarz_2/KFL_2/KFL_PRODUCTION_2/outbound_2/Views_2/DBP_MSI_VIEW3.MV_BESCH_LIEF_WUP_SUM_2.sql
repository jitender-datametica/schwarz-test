-- , anzahl_palette_gp
 -- , menge_lief_ist_kolli_gp

-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

-- 22.01.2018 HMue2308: AP0012522, SPEC0027715 vol_ladung_liter Bezeichnung umgeändert in brtvol_ladung_liter und Feld ' brtvol_ladung_liter_gedeckelt'  hinzugefügt

-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt
 -- , anzahl_position_gp

-- , anzahl_palette_mp
 -- Anforderung 595645 Splittung bei Palettentyp 6

-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt

-- #613296 Splitt Palettentyp 6 in 61 und 64, dadurch Entfernen der Felder menge_lief_ist_kolli, anzahl_position_gp, anzahl_palette_gp und anzahl_palette_mp - sschuecke 11.06.2015

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_besch_lief_wup_sum_2(USERID STRING) AS SELECT V01.dat_lief_soll,
 V01.kunde_id,
 V01.lagerort_id,
 V01.lief_pal_typ_id,
 V01.lief_typ_id,
 V01.mandant_id,
 V01.nb_id,
 V01.vertr_beleg_typ_id,
 V01.wup_id,
 V01.wg_verkett_lief,
 V01.menge_lief_ist_kolli,
 V01.anzahl_packstueck,
 V01.anzahl_position,
 V01.menge_lief_ist_bme,
 V01.betrag_lief_ist,
 V01.menge_lief_soll_bme,
 V01.menge_lief_soll_kolli,
 V01.werbeware_id,
 V01.betrag_lief_soll,
 V01.wrg_id,
 V01.mandant_id_kunde,
 V01.vk_netto_lief_soll,
 V01.vk_netto_lief_ist,
 V01.brtvol_ladung_liter,
 V01.bestellart_id,
 V01.hu_status_id,
 V01.brtvol_ladung_liter_gedeckelt,
 -- die dazugehörige netvol_ladung_liter wird mit FrontEnd Metriken gedeckelt
 V01.menge_lief_fehl_bme,
 V01.menge_lief_fehl_kolli,
 V01.betrag_lief_fehl,
 V01.vk_netto_lief_fehl,
 V01.wrg_typ_id -- ,v01.anzahl_palette_gp
 -- ,v01.anzahl_position_gp
 -- ,v01.anzahl_palette_mp

 -- ,v01.menge_lief_ist_kolli_gp

FROM kfl_production_dbp_msi_view3.tbl_mv_besch_lief_wup_sum_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V04 ON V01.wrg_typ_id = V04.wrg_typ_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.kurstyp_id = 3;