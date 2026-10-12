CREATE OR REPLACE TABLE kfl_production_dbp_data.art_backshop_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bestell_art_id INTEGER NOT NULL
OPTIONS(description='Bestellartikel = ein Artikel_1 der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art_1'),
inhalt_menge NUMERIC(9,3) OPTIONS(description='Menge des Artkels in Stück'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestell_art_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek');