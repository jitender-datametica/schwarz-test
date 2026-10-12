--==============================================================
-- Table: art_ipn_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_ipn_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_ipn_zu (
ipn_id INTEGER NOT NULL OPTIONS(description='Internationale Produktnummer'),
gtin_id NUMERIC(26,0) NOT NULL
OPTIONS(description='Die Global Trade Item Number (GTIN) ist eine aus dem GS1-System (vormals EAN-System) stammende Identifikationsnummer, mit der Handelseinheiten ausgezeichnet werden können'),
gtin_typ_kz STRING(2) COLLATE 'und:ci' OPTIONS(description='Nummerntyp der GTIN(Global Trade Item Number)'),
loesch_fg BIGNUMERIC(38,0) OPTIONS(description='Löschvermerk'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ipn_id, gtin_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zuordnungstabelle IPN (Internationale Produkt Nummer) zu GTIN');