create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel verkauft wird.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
	STELLPLATZ_NR VARCHAR(20) NOT NULL COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
	MARKT_LAGERBEREICH_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Lagerbereichs in der Filiale.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	DAT_MHD DATE NOT NULL COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
	BETRAG_VK_BRUTTO NUMBER(38,4) NOT NULL COMMENT 'VK Brutto Einzelpreis des Artikels.',
	DAT_LAGERBUCH DATE NOT NULL COMMENT 'Datum der Lagerbuchdaten.',
	VERRAEUMUNG_PRIO_GRUND_ID VARCHAR(2) NOT NULL COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU primary key (MANDANT_ID, WUP_ID, NB_ID, STELLPLATZ_NR, MARKT_LAGERBEREICH_ID, ART_ID, DAT_MHD, BETRAG_VK_BRUTTO, DAT_LAGERBUCH, VERRAEUMUNG_PRIO_GRUND_ID)
)COMMENT='Zuordnungstabelle für Lagerbuch in der Filiale zu Verräumungs-Prioritätsgründen. Quellsystem: Couchbase. Diese Tabelle stellt die Verbindung zwischen den Artikeln im Lagerbuch der Filiale und den Gründen her, die diese Artikel als \""kritisch\"" für die Verräumung auf die Verkaufsfläche einstufen. Es ist möglich, dass ein bestimmter Artikel im Lagerbuch mehrere Prioritätsgründe aufweist.'
;
