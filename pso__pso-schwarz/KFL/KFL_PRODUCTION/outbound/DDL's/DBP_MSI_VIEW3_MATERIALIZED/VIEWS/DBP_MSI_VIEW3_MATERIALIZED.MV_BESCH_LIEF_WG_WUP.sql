
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf STRING(2)

-- Für andere Berichte darf das ruhig genauso sein -> Lösung in der View

-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST

-- 09.02.2021 nwag2310: EWM-Lagerorte herausfiltern

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

-- 31.08.2018 srom0404: intern. join auf wup Tabelle lt. Email Anforderung (N. Wagner, S. Panzer)

-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt

-- AP0128635, SPEC0151986, dknop, adding aulieferungsgruppe_id

-- 2023-09-13, dknop, INC7247056, adding coalesce for bestellart_id

-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt

-- Kennzahlen egal ob man das Attribut ""Kunde"" im Objekt Prompt vom neuen 05.03.02 auswählt oder nicht, die Kennzahlen in Summe gleich bleiben

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_besch_lief_wg_wup (USERID STRING) AS SELECT V01.mandant_id
 ,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
 V01.diff_id,
 V01.dat_lief_soll,
 V01.lief_typ_id,
 V01.vertr_beleg_typ_id,
 V01.wg_id,
 V01.arthiertyp_id,
 V01.kunde_id,
 V01.wg_verkett_lief,
 V01.menge_lief_soll_bme,
 V01.menge_lief_soll_kolli,
 V01.betrag_lief_soll,
 V01.menge_lief_ist_bme,
 V01.menge_lief_ist_kolli,
 V01.betrag_lief_ist,
 V01.lief_pal_typ_id,
 V01.anzahl_position,
 V01.wrg_id,
 V01.mandant_id_kunde,
 V01.vk_netto_lief_soll,
 V01.vk_netto_lief_ist,
 V01.werbeware_id,
 COALESCE(CASE
   WHEN V01.bestellart_id = ''
   THEN NULL
   ELSE V01.bestellart_id
   END, '-1') AS bestellart_id,
 V01.hu_status_id,
 V01.anzahl_packstueck,
 V01.brtvol_ladung_liter,
 V01.brtvol_ladung_liter_gedeckelt,
 V01.menge_lief_fehl_bme,
 V01.menge_lief_fehl_kolli,
 V01.betrag_lief_fehl,
 V01.vk_netto_lief_fehl,
 V01.wrg_typ_id,
 V01.auslieferungsgruppe_id
 -- Das tbl Objekt ersetzt die bisherige Logik und materialisiert einen Join über mehrere Tabellen.

FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_besch_lief_wg_wup AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS V04 ON V01.wrg_typ_id = V04.wrg_typ_id;

