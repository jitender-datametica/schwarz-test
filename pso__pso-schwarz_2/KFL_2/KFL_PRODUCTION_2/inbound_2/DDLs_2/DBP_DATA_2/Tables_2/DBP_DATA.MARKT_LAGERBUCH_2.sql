create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.MARKT_LAGERBUCH_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_2 verkauft wird.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
	STELLPLATZ_NR VARCHAR(20) NOT NULL COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
	MARKT_LAGERBEREICH_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Lagerbereichs in der Filiale.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
	DAT_MHD DATE NOT NULL COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
	BETRAG_VK_BRUTTO NUMBER(38,4) NOT NULL COMMENT 'VK_2 Brutto Einzelpreis des Artikels.',
	DAT_LAGERBUCH DATE NOT NULL COMMENT 'Datum der Lagerbuchdaten.',
	MENGE_LAGERBESTAND_STELLPLATZ NUMBER(38,3) COMMENT 'Lagerbestand auf dem Stellplatz.',
	MENGE_LAGERBESTAND_GESAMT NUMBER(38,3) COMMENT 'Gesamter Bestand im Filiallager.',
	MENGE_FILIALBESTAND NUMBER(38,3) COMMENT 'Gesamter Filialbestand. Enthält die Summe des aktuellen Lagerbestands und des Bestands im Verkaufsregal für die zugehörige Filiale.',
	MENGE_OPT_BESTAND NUMBER(38,3) COMMENT 'Maximaler oder optischer Bestand des Artikels im Regal.',
	RATE_VERRAEUMUNG NUMBER(38,2) COMMENT 'Für jeden Artikel_2 im Lager wird geprüft wieviel % des Bestandes ins Verkaufsregal verräumt werden können. Hierfür wird aus dem Filialbestand minus Lagerbestand minus Wareneingangs-Bestand der Regalbestand ermittelt. ',
	DAT_AENDERUNG DATE NOT NULL COMMENT 'letzte Änderung auf dem Stellplatz.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_MARKT_LAGERBUCH primary key (MANDANT_ID, WUP_ID, NB_ID, STELLPLATZ_NR, MARKT_LAGERBEREICH_ID, ART_ID, DAT_MHD, BETRAG_VK_BRUTTO, DAT_LAGERBUCH)
)COMMENT='Die Tabelle enthält einen Überblick über die Bestandsituation in einer Filiale (Lager, Verkaufsfläche). Sie wird aus dem System Couchbase versorgt.'
;
