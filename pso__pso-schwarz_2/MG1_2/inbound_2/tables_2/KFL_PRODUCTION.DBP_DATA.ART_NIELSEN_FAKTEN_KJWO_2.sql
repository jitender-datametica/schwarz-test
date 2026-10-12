create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_NIELSEN_FAKTEN_KJWO_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KJWO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	NIELSEN_MARKET_ID NUMBER(38,0) NOT NULL COMMENT 'ID des \"markets_2\" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag_2))',
	ART_NIELSEN_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2-ID aus Nielsen',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	UMSATZ_BRUTTO NUMBER(18,4) COMMENT 'Bruttoumsatz aus Nielsen',
	UMSATZ_BRUTTO_AF NUMBER(18,4) COMMENT 'Bruttoumsatz aktionsfrei aus Nielsen',
	UMSATZ_BRUTTO_SA NUMBER(18,4) COMMENT 'Bruttoumsatz Sonderaktion aus Nielsen',
	MENGE NUMBER(18,3) COMMENT 'Menge aus Nielsen',
	MENGE_AF NUMBER(18,3) COMMENT 'Menge aktionsfrei aus Nielsen',
	MENGE_SA NUMBER(18,3) COMMENT 'Menge Sonderaktion aus Nielsen',
	DISTR_NUM NUMBER(18,4) COMMENT 'Numerische Distribution.',
	DISTR_GEW NUMBER(18,4) COMMENT 'Gewichtete Distribution.',
	ANZ_MAERKTE NUMBER(38,0) COMMENT 'Anzahl der Märkte im Marktsegment',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	DISTR_NUM_4_WO NUMBER(38,4) COMMENT 'Numerische Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).',
	DISTR_GEW_4_WO NUMBER(38,4) COMMENT 'Gewichtete Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).',
	constraint PK_ART_NIELSEN_FAKTEN_KJWO primary key (MANDANT_ID, KJWO, NIELSEN_MARKET_ID, ART_NIELSEN_ID)
)COMMENT='EK-INT - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Wochenbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.'
;