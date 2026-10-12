create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_WG_WUP(
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
	AUSLIEFERUNGSGRUPPE_ID
) as
-- 15.02.2018 srom0404: AP0012522, SPEC0027715 hu_status_id hinzugefügt
-- 26.02.2018 srom0404: AP0006750, SPEC0027714 bestellart_id, wg_verkett_lief hinzugefügt
-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
-- 31.08.2018 srom0404: intern. join auf wup Tabelle lt. Email Anforderung (N. Wagner, S. Panzer)
-- Kennzahlen egal ob man das Attribut ""Kunde"" im Objekt Prompt vom neuen 05.03.02 auswählt oder nicht, die Kennzahlen in Summe gleich bleiben
-- Für andere Berichte darf das ruhig genauso sein -> Lösung in der View
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 09.02.2021 nwag2310: EWM-Lagerorte herausfiltern
-- AP0128635, SPEC0151986, dknop, adding aulieferungsgruppe_id
-- 20220804;