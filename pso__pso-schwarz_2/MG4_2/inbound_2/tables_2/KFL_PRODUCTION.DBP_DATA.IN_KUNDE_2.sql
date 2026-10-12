create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_KUNDE_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	IN_KUNDE_ID NUMBER(38,0) NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
	KUNDE_NR VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Kundennummer aus SAP Industrie im Originalformat',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	KUNDE_NAME VARCHAR(40) COLLATE 'en-ci' COMMENT 'Name des Kunden aus name1_gp',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_KUNDE primary key (MANDANT_ID, IN_KUNDE_ID)
)COMMENT='BIS - Die Tabelle wird aus kna1_2 versorgt. Die kunde_id wird im Produkt IVS vverwendet'
;