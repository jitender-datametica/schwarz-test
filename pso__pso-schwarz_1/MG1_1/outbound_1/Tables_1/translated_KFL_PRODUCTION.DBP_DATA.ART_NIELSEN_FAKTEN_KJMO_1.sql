CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_NIELSEN_FAKTEN_KJMO_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
NIELSEN_MARKET_ID INTEGER NOT NULL
OPTIONS(description='ID des\"markets_1\" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag_1))'),
ART_NIELSEN_ID INTEGER NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
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
MENGE_VERKAUFSEINHEITEN_NORMIERT NUMERIC(29,4)
OPTIONS(description='Aberverkaufsmenge Nielsen normiert auf angegebene Einheit.'),
PRIMARY KEY (MANDANT_ID, KJMO, NIELSEN_MARKET_ID, ART_NIELSEN_ID) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Monatsbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.\n             Für Kroatien kommen Daten in Wochen statt im Monat_1, weshalb der PK nicht stimmt und es mehrere Zeilen pro mandant_id = 6, kjmo, nielsen_market_id und art_nielsen_id gibt. Dieser Sachverhalt wird für die weitere Aggregation zu tupel_mat_1(_quarantaene) berücksichtigt und dementsprechend kalkuliert.');