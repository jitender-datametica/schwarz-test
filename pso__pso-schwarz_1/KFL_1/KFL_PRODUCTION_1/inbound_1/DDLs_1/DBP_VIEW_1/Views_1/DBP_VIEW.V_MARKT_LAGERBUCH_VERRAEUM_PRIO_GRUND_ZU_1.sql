create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	WUP_ID COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_1 verkauft wird.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
	STELLPLATZ_NR COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
	MARKT_LAGERBEREICH_ID COMMENT 'ID des Lagerbereichs in der Filiale.',
	ART_ID COMMENT 'Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	DAT_MHD COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
	BETRAG_VK_BRUTTO COMMENT 'VK_1 Brutto Einzelpreis des Artikels.',
	DAT_LAGERBUCH COMMENT 'Datum der Lagerbuchdaten.',
	VERRAEUMUNG_PRIO_GRUND_ID COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02',
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
        verraeumung_prio_grund_id,
        wrg_id

FROM DBP_DATA.MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU_1 ;
