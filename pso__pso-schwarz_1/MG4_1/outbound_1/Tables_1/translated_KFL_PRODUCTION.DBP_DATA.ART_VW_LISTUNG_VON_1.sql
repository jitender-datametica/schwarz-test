CREATE OR REPLACE TABLE kfl_production_dbp_data.art_vw_listung_von_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vw_id INTEGER NOT NULL OPTIONS(description='ID des Vertriebsweges'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
dat_von DATE NOT NULL
OPTIONS(description='Datum der letzten Listungsänderung. Pro Schlüssel ist nur das letzte Datum gespeichert'),
sm_id INTEGER DEFAULT - 9 NOT NULL OPTIONS(description='Hier: groesste sm_id mit einer durchgaengigen Listung'),
dat_erst_listung DATE NOT NULL OPTIONS(description='Datum der ersten Listung'),
ksm_id STRING(4) COLLATE 'und:ci' DEFAULT '-9' NOT NULL
OPTIONS(description='Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vw_id, art_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Pro Artikel_1 und Vertriebsweg wird die Durchgängigkeit der Listung angezeigt');