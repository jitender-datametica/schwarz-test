create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.VIS_TAG_UMSATZ_ABT_1 cluster by (
     MANDANT_ID,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT DATE NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	ABT_ID NUMBER(38,0) NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
	KJWO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
	UMS_NETTO NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto',
	UMS_NETTO_WVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Wochentag im Vorjahr',
	UMS_NETTO_WVVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Wochentag im Vorvorjahr',
	UMS_NETTO_KVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
	UMS_NETTO_KVVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_VIS_TAG_UMSATZ_ABT primary key (MANDANT_ID, DAT, NB_ID, WUP_ID, ARTHIERTYP_ID, WRG_ID, ABT_ID)
)COMMENT='VIS - Aggregat auf Tagesebene - MULTISET'
;