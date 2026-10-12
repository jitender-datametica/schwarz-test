--==============================================================
-- Table: art_backshop_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_backshop_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bestell_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bestellartikel = ein Artikel_2 der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art_2'),
inhalt_menge NUMERIC(9,3) OPTIONS(description='Menge des Artkels in Stück'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestell_art_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek');