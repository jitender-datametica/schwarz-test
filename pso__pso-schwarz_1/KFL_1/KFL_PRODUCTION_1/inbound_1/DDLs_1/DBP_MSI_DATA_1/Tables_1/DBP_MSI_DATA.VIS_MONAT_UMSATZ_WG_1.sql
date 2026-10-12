create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ABT_ID NUMBER(38,0) NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	GJ NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahr',
	UMS_NETTO NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto',
	UMS_NETTO_KVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
	UMS_NETTO_KVVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
	UMS_NETTO_PLAN NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Planwert',
	UMS_BRUTTO NUMBER(38,2) NOT NULL COMMENT 'Umsatz brutto',
	UMS_BRUTTO_KVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz brutto Kalendertag im Vorjahr',
	MENGE_ABSATZ NUMBER(38,3) NOT NULL DEFAULT 0 COMMENT 'Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
	MENGE_ABSATZ_KVJ NUMBER(38,3) NOT NULL DEFAULT 0 COMMENT 'Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
	MENGE_ABSATZ_KVVJ NUMBER(38,3) NOT NULL DEFAULT 0 COMMENT 'Menge Kalendertag im Vor-Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_VIS_MONAT_UMSATZ_WG primary key (MANDANT_ID, WUP_ID, NB_ID, WRG_ID, KJMO, ARTHIERTYP_ID, WG_ID)
)COMMENT='VIS - Aggregat auf Monatsebene - MULTISET'
;
