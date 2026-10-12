create or replace TABLE KFL_PRODUCTION.DBP_DATA.COI_UMP_HWG_SUM_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datumswert des Umsatzes',
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_COI_UMP_HWG_SUM primary key (MANDANT_ID, WUP_ID, NB_ID, DAT, HWG_ID)
)COMMENT='WWC - COI Umsatzplanung - Aggregat für BE'
;