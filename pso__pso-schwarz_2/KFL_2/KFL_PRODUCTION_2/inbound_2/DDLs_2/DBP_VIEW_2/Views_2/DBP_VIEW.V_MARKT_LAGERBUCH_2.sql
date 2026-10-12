create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_MARKT_LAGERBUCH_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	WUP_ID COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_2 verkauft wird.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
	STELLPLATZ_NR COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
	MARKT_LAGERBEREICH_ID COMMENT 'ID des Lagerbereichs in der Filiale.',
	ART_ID COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
	DAT_MHD COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
	BETRAG_VK_BRUTTO COMMENT 'VK_2 Brutto Einzelpreis des Artikels.',
	DAT_LAGERBUCH COMMENT 'Datum der Lagerbuchdaten.',
	MENGE_LAGERBESTAND_STELLPLATZ COMMENT 'Lagerbestand auf dem Stellplatz.',
	MENGE_LAGERBESTAND_GESAMT COMMENT 'Gesamter Bestand im Filiallager.',
	MENGE_FILIALBESTAND COMMENT 'Gesamter Filialbestand. Enthält die Summe des aktuellen Lagerbestands und des Bestands im Verkaufsregal für die zugehörige Filiale.',
	MENGE_OPT_BESTAND COMMENT 'Maximaler oder optischer Bestand des Artikels im Regal.',
	RATE_VERRAEUMUNG COMMENT 'Für jeden Artikel_2 im Lager wird geprüft wieviel % des Bestandes ins Verkaufsregal verräumt werden können. Hierfür wird aus dem Filialbestand minus Lagerbestand minus Wareneingangs-Bestand der Regalbestand ermittelt. ',
	DAT_AENDERUNG COMMENT 'letzte Änderung auf dem Stellplatz.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
) as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        stellplatz_nr,
        markt_lagerbereich_id,
        art_id,
        dat_mhd,
        betrag_vk_brutto,
        dat_lagerbuch,
        menge_lagerbestand_stellplatz,
        menge_lagerbestand_gesamt,
        menge_filialbestand,
        menge_opt_bestand,
        rate_verraeumung,
        dat_aenderung,
        wrg_id

FROM DBP_DATA.MARKT_LAGERBUCH_2 ;
