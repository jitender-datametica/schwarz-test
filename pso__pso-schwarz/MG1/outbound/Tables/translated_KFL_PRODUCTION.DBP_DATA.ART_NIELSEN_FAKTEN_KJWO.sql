CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_NIELSEN_FAKTEN_KJWO (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
NIELSEN_MARKET_ID INTEGER NOT NULL
OPTIONS(description='ID des\"markets\" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag))'),
ART_NIELSEN_ID INTEGER NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
UMSATZ_BRUTTO NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aus Nielsen'),
UMSATZ_BRUTTO_AF NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aktionsfrei aus Nielsen'),
UMSATZ_BRUTTO_SA NUMERIC(18,4) OPTIONS(description='Bruttoumsatz Sonderaktion aus Nielsen'),
MENGE NUMERIC(18,3) OPTIONS(description='Menge aus Nielsen'),
MENGE_AF NUMERIC(18,3) OPTIONS(description='Menge aktionsfrei aus Nielsen'),
MENGE_SA NUMERIC(18,3) OPTIONS(description='Menge Sonderaktion aus Nielsen'),
DISTR_NUM NUMERIC(18,4) OPTIONS(description='Numerische Distribution.'),
DISTR_GEW NUMERIC(18,4) OPTIONS(description='Gewichtete Distribution.'),
ANZ_MAERKTE INTEGER OPTIONS(description='Anzahl der Märkte im Marktsegment'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
DISTR_NUM_4_WO NUMERIC(29,4)
OPTIONS(description='Numerische Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).'),
DISTR_GEW_4_WO NUMERIC(29,4)
OPTIONS(description='Gewichtete Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).'),
PRIMARY KEY (MANDANT_ID, KJWO, NIELSEN_MARKET_ID, ART_NIELSEN_ID) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Wochenbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.');