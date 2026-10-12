CREATE OR REPLACE TABLE kfl_production_dbp_data.art_per (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
dat_von DATE NOT NULL
OPTIONS(description='Datum, von dem an der Zustand gilt. Initial wird das dat_von aus der Tabelle art eingetragen'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, bis zu dem der Zustand gueltig war/ist. Bei aktuellen Eintraegen der 31.12.9999'),
mutter_wb_id INTEGER
OPTIONS(description='Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des fuehrenden Artikels (auch: Mutterartikel) hinterlegt'),
posten_id STRING(2) COLLATE 'und:ci' OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN'),
ipn_id INTEGER OPTIONS(description='Internationale Produktnummer zum Artikel (MAW1.ZZEK_IPN)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
mwst_id INTEGER OPTIONS(description='Mehrwertsteuer-Kennzeichen historisiert'),
oug_id INTEGER OPTIONS(description='Kennzeichen Obst und Gemuese'),
iwt_id STRING(1) DEFAULT ''
OPTIONS(description='IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country for its own use (\'\'/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country (I)'),
PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Einzelne Attribute der Tabelle art werden im DWH historisiert');