create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_NIELSEN_FAKTEN_KJMO_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
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
	MENGE_VERKAUFSEINHEITEN_NORMIERT NUMBER(38,4) COMMENT 'Aberverkaufsmenge Nielsen normiert auf angegebene Einheit.',
	constraint PK_ART_NIELSEN_FAKTEN_KJMO primary key (MANDANT_ID, KJMO, NIELSEN_MARKET_ID, ART_NIELSEN_ID)
)COMMENT='EK-INT - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Monatsbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.\n             Für Kroatien kommen Daten in Wochen statt im Monat_2, weshalb der PK nicht stimmt und es mehrere Zeilen pro mandant_id = 6, kjmo, nielsen_market_id und art_nielsen_id gibt. Dieser Sachverhalt wird für die weitere Aggregation zu tupel_mat_2(_quarantaene) berücksichtigt und dementsprechend kalkuliert.'
;