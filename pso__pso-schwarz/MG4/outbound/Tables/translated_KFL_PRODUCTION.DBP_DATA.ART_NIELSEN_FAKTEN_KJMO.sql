CREATE OR REPLACE TABLE kfl_production_dbp_data.art_nielsen_fakten_kjmo (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kjmo INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
nielsen_market_id INTEGER NOT NULL
OPTIONS(description='ID des\"markets\" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag))'),
art_nielsen_id INTEGER NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_brutto NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aus Nielsen'),
umsatz_brutto_af NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aktionsfrei aus Nielsen'),
umsatz_brutto_sa NUMERIC(18,4) OPTIONS(description='Bruttoumsatz Sonderaktion aus Nielsen'),
menge NUMERIC(18,3) OPTIONS(description='Menge aus Nielsen'),
menge_af NUMERIC(18,3) OPTIONS(description='Menge aktionsfrei aus Nielsen'),
menge_sa NUMERIC(18,3) OPTIONS(description='Menge Sonderaktion aus Nielsen'),
distr_num NUMERIC(18,4) OPTIONS(description='Numerische Distribution.'),
distr_gew NUMERIC(18,4) OPTIONS(description='Gewichtete Distribution.'),
anz_maerkte INTEGER OPTIONS(description='Anzahl der Märkte im Marktsegment'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
menge_verkaufseinheiten_normiert NUMERIC(29,4)
OPTIONS(description='Aberverkaufsmenge Nielsen normiert auf angegebene Einheit.'),
PRIMARY KEY (mandant_id, kjmo, nielsen_market_id, art_nielsen_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Monatsbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.\n             Für Kroatien kommen Daten in Wochen statt im Monat, weshalb der PK nicht stimmt und es mehrere Zeilen pro mandant_id = 6, kjmo, nielsen_market_id und art_nielsen_id gibt. Dieser Sachverhalt wird für die weitere Aggregation zu tupel_mat(_quarantaene) berücksichtigt und dementsprechend kalkuliert.');