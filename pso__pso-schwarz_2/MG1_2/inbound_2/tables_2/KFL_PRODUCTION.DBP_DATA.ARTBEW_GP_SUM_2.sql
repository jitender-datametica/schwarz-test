create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTBEW_GP_SUM_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)\n            ',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte\n            1 = Ost\n            2 = West\n            3 = Nord',
	WRG_2 VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Währung, z.Bsp. EUR',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	DIFF_UMSATZ_NETTO_KONZ NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'von der Konzernwährung abweichender Umsatz netto',
	EK_MEP NUMBER(18,4) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)',
	DIFF_EK_MEP_KONZ NUMBER(18,4) NOT NULL DEFAULT 0 WITH MASKING POLICY #unknown_policy COMMENT 'von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	UMRECHNUNGSKURS_HIST NUMBER(38,5) NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 ',
	constraint PK_ARTBEW_GP_SUM primary key (MANDANT_ID, DAT, GP_ID, VW_ID)
)COMMENT='TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag_2 - MULTISET'
;