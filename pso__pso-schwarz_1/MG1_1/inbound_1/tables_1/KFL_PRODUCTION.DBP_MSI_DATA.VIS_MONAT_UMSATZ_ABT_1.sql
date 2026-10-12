create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.VIS_MONAT_UMSATZ_ABT_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
	ABT_ID NUMBER(38,0) NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	GJ NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahr',
	AKT_GJ NUMBER(38,0) NOT NULL COMMENT 'Zähler auf Basis des aktuellen Geschäftsjahres',
	AKT_MO NUMBER(38,0) NOT NULL COMMENT 'Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1',
	MO_KJ NUMBER(38,0) NOT NULL COMMENT 'Laufender Monat_1 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12',
	UMS_NETTO NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto',
	UMS_NETTO_KVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vorjahr',
	UMS_NETTO_KVVJ NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Kalendertag im Vor-Vorjahr',
	UMS_NETTO_PLAN NUMBER(38,2) NOT NULL COMMENT 'Umsatz netto Planwert',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_VIS_MONAT_UMSATZ_ABT primary key (MANDANT_ID, WUP_ID, NB_ID, WRG_ID, KJMO, ABT_ID, ARTHIERTYP_ID)
)COMMENT='VIS - Aggregat auf Monatsebene - MULTISET'
;