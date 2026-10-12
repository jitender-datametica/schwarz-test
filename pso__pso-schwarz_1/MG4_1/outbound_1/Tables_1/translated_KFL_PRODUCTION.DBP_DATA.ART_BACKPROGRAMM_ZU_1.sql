CREATE OR REPLACE TABLE kfl_production_dbp_data.art_backprogramm_zu_1 (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
back_programm_id INTEGER NOT NULL OPTIONS(description='ID des Backprogramms aus bake_program. Numerischer Wert'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, back_programm_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Diese Tabelle ordnet den Artikeln die Backprogramme zu. Quelle ist die SAP-Klassenbibliothek');