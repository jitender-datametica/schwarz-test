CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_BACKSHOP (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BESTELL_ART_ID INTEGER NOT NULL
OPTIONS(description='Bestellartikel = ein Artikel der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art'),
INHALT_MENGE NUMERIC(9,3) OPTIONS(description='Menge des Artkels in Stück'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BESTELL_ART_ID) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Backshop Bestellartikel aus der Warengruppe 291. Quelle ist SAP Klassenbibliothek');