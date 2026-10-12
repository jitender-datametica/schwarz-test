CREATE OR REPLACE TABLE IMS_MAMO_ARTBEW_WO_SUM_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetriebs ID, bei Märkten immer = 0',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	KJWO_KL NUMBER(38,0) NOT NULL COMMENT 'Kaufland - Kalenderjahreswoche. Beginnt am 01.01. eines Jahres und endet am 31.12. unabhängig vom Wochentag. Die erste und die letzte Kalenderjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW',
	MENGE NUMBER(18,3) NOT NULL COMMENT 'Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)',
	UMSATZ_NETTO NUMBER(18,4) NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
	EK_MEP NUMBER(18,4) NOT NULL COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='WWC - Redundanz zu artbew_wo_sum_1 aufgrund Performance'
;