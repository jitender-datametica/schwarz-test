create or replace TABLE KFL_PRODUCTION.DBP_DATA.BSCH_RECH_DET_GP_SUM_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte',
	EK_N NUMBER(18,4) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	constraint PK_BSCH_RECH_DET_GP_SUM primary key (MANDANT_ID, DAT, GP_ID, VW_ID)
)COMMENT='TP2_AIS - Aggregat über Wareneingänge pro Lieferant, Tag_2 und Vertriebsweg - MULTISET'
;