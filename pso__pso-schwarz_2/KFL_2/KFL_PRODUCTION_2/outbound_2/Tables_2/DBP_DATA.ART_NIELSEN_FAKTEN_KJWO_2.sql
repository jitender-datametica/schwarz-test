--==============================================================
-- Table: art_nielsen_fakten_kjwo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_fakten_kjwo_2
   generated from Powerdesigner on Donnerstag, 15. September 2022 14:51:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_fakten_kjwo_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
nielsen_market_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des "markets_2" (wird im DWH vergeben abgeleitet aus Nielsen (markets.tag_2))'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2-ID aus Nielsen'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_brutto NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aus Nielsen'),
umsatz_brutto_af NUMERIC(18,4) OPTIONS(description='Bruttoumsatz aktionsfrei aus Nielsen'),
umsatz_brutto_sa NUMERIC(18,4) OPTIONS(description='Bruttoumsatz Sonderaktion aus Nielsen'),
menge NUMERIC(18,3) OPTIONS(description='Menge aus Nielsen'),
menge_af NUMERIC(18,3) OPTIONS(description='Menge aktionsfrei aus Nielsen'),
menge_sa NUMERIC(18,3) OPTIONS(description='Menge Sonderaktion aus Nielsen'),
distr_num NUMERIC(18,4) OPTIONS(description='Numerische Distribution.'),
distr_gew NUMERIC(18,4) OPTIONS(description='Gewichtete Distribution.'),
anz_maerkte BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Märkte im Marktsegment'),
distr_num_4_wo BIGNUMERIC(38,4)
OPTIONS(description='Numerische Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).'),
distr_gew_4_wo BIGNUMERIC(38,4)
OPTIONS(description='Gewichtete Distribution gerechnet auf 4 Wochen (genauer als wöchentlich bei Langsamdrehern).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo, nielsen_market_id, art_nielsen_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Integration der Rohdaten aus Nielsen zur Nachvollziehbarkeit auf Wochenbasis - aufgrund der Datenquellenbeschaffenheit keine ETL-Lösung möglich, um Daten integriert im Core-DWH abzulegen - keine Integritätsgarantie.');