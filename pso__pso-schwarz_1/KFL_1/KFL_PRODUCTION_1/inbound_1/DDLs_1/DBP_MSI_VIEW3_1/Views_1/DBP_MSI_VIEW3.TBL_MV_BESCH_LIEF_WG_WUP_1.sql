CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_WG_WUP_1 (
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	DIFF_ID,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	VERTR_BELEG_TYP_ID,
	WG_ID,
	ARTHIERTYP_ID,
	KUNDE_ID,
	WG_VERKETT_LIEF,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_SOLL_KOLLI,
	BETRAG_LIEF_SOLL,
	MENGE_LIEF_IST_BME,
	MENGE_LIEF_IST_KOLLI,
	BETRAG_LIEF_IST,
	LIEF_PAL_TYP_ID,
	ANZAHL_POSITION,
	WRG_ID,
	MANDANT_ID_KUNDE,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	WERBEWARE_ID,
	BESTELLART_ID,
	HU_STATUS_ID,
	ANZAHL_PACKSTUECK,
	BRTVOL_LADUNG_LITER,
	BRTVOL_LADUNG_LITER_GEDECKELT,
	MENGE_LIEF_FEHL_BME,
	MENGE_LIEF_FEHL_KOLLI,
	BETRAG_LIEF_FEHL,
	VK_NETTO_LIEF_FEHL,
	WRG_TYP_ID,
	DAT_BIS,
	KURSTYP_ID,
	AUSLIEFERUNGSGRUPPE_ID
)
-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt
-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt
-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
-- 31.08.2018 srom0404: intern. join auf wup_1 Tabelle lt. Email Anforderung (N. Wagner, S. Panzer)
-- Kennzahlen egal ob man das Attribut "Kunde" im Objekt Prompt vom neuen 05.03.02 auswählt oder nicht, die Kennzahlen in Summe gleich bleiben
-- Für andere Berichte darf das ruhig genauso sein -> Lösung in der View
-- 09.02.2021 nwag2310: EWM-Lagerorte herausfiltern
-- 02.03.2021 nwag2310: EWM-Lagerorte erweitert
-- 12.05.2022, AP0128635, SPEC0151986, dknop, adding aulieferungsgruppe_id
-- 2022-07-14, AP0125093, SPEC0155049, dknop, adding join to dbp_msi_data.ts_lagerort_ewm_dat_1 and filter on dat_lief_soll instead of hardcoded DC/Dates
-- 2022-08-02, AP0125093, SPEC0155049, dknop, filter correction
--2024-01-31, INC7963291, dknop, change kunde_id 
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-09, dknop, change to left join with dbp_view.v_wup_1
--2024-10-15, nwag, bugfix kunde ID

 AS
    SELECT
   v01.mandant_id
  , v01.wup_id
  , v01.nb_id
  , v01.lagerort_id
  , v01.diff_id
  , v01.dat_lief_soll
  , v01.lief_typ_id
  , v01.vertr_beleg_typ_id
  , v01.wg_id
  , v01.arthiertyp_id
  --, CASE WHEN TRY_CAST(kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(kunde_id AS INTEGER) END AS kunde_id
  , CASE WHEN TRY_CAST(kunde_id AS INTEGER) IS NULL THEN -3 ELSE COALESCE(TRY_CAST(kunde_id AS INTEGER), v05.aktuell_wup_id) END kunde_id
  , v01.wg_verkett_lief
  , CASE WHEN v01.dat_lief_soll < '2005-04-12'
   THEN 0   ELSE v01.menge_lief_soll_bme   END AS menge_lief_soll_bme
   , CASE WHEN v01.dat_lief_soll < '2005-04-12'
   THEN 0
   ELSE v01.menge_lief_soll_kolli
   END AS menge_lief_soll_kolli
   , CASE WHEN v01.dat_lief_soll < '2005-04-12'
   THEN 0
   ELSE v01.betrag_lief_soll
   END AS betrag_lief_soll
   , v01.menge_lief_ist_bme
   , v01.menge_lief_ist_kolli
   , CASE WHEN v03.wrg_typ_id = 0
   THEN v01.betrag_lief_ist * v02.umrechnungskurs
   ELSE v01.betrag_lief_ist
   END AS betrag_lief_ist
   , CAST(v01.lief_pal_typ_id AS CHAR(2)) AS lief_pal_typ_id
   , v01.anzahl_position
   , v01.wrg_id
   , CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0
   THEN v01.mandant_id
   ELSE v01.mandant_id_kunde
   END AS mandant_id_kunde
   , CASE WHEN v03.wrg_typ_id = 0
   THEN v01.vk_netto_lief_soll * v02.umrechnungskurs
   ELSE v01.vk_netto_lief_soll
   END AS vk_netto_lief_soll, CASE WHEN v03.wrg_typ_id = 0
   THEN v01.vk_netto_lief_ist * v02.umrechnungskurs
   ELSE v01.vk_netto_lief_ist
   END AS vk_netto_lief_ist
   , v01.werbeware_id
   , v01.bestellart_id
   , v01.hu_status_id
   , v01.anzahl_packstueck
   , v01.brtvol_ladung_liter
   , v01.brtvol_ladung_liter_gedeckelt -- die dazugehörige netvol_ladung_liter wird mit FrontEnd Metriken gedeckelt
   , CASE WHEN v01.dat_lief_soll < '2005-04-12'   THEN 0
   ELSE (v01.menge_lief_soll_bme - v01.menge_lief_ist_bme)
   END AS menge_lief_fehl_bme
   , CASE WHEN v01.dat_lief_soll < '2005-04-12'   THEN 0
   ELSE (v01.menge_lief_soll_kolli - v01.menge_lief_ist_kolli)
   END AS menge_lief_fehl_kolli
   , CASE WHEN v01.dat_lief_soll < '2005-04-12'   THEN 0
   ELSE CASE WHEN v03.wrg_typ_id = 0
   THEN ((v01.betrag_lief_soll - v01.betrag_lief_ist) * v02.umrechnungskurs)
   ELSE (v01.betrag_lief_soll - v01.betrag_lief_ist)
   END
   END AS betrag_lief_fehl, CASE WHEN v03.wrg_typ_id = 0
   THEN ((v01.vk_netto_lief_soll - v01.vk_netto_lief_ist) * v02.umrechnungskurs)
   ELSE (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist)
   END AS vk_netto_lief_fehl
   , v03.wrg_typ_id
   , v02.dat_bis
   , v02.kurstyp_id
   , v01.auslieferungsgruppe_id
   FROM dbp_view.v_besch_lief_wg_wup_1 v01
   
   INNER JOIN dbp_view.v_kurs_1 v02
   ON v01.wrg_id=v02.von_wrg_id
  
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
   ON v01.mandant_id=v03.mandant_id

   LEFT JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id  ELSE v01.mandant_id_kunde END
   AND v05.wup_id = TRY_CAST(kunde_id AS INTEGER) 
   
   LEFT JOIN dbp_msi_data.ts_lagerort_ewm_dat_1 v06
   ON v01.mandant_id=v06.mandant_id
   AND v01.wup_id=v06.wup_id
   AND v01.lagerort_id=v06.lagerort_id
 

   WHERE v02.dat_bis = '9999-12-31'
   AND v02.kurstyp_id = 3 
   -- EWM Lagerorte ausfiltern! - Erweiterung mit jedem Go-Live erforderlich!
AND
  ( v06.mandant_id IS NULL OR NOT  v01.dat_lief_soll >= v06.dat)  ;