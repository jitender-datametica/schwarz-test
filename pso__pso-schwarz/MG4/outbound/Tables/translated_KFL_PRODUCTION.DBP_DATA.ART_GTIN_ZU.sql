CREATE OR REPLACE TABLE kfl_production_dbp_data.art_gtin_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
altnv_menge_einh_id STRING(3) NOT NULL OPTIONS(description='Mengeneinheit für Anzeige'),
lfd_nr INTEGER NOT NULL OPTIONS(description='Laufende Nummer'),
gtin_id INTEGER NOT NULL OPTIONS(description='Global Trade Item Number (GTIN)'),
gtin_typ_kz STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Nummerntyp der Global Trade Item Number (z.B. G1 = Hersteller GTIN)'),
haupt_gtin_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Haupt-GTIN (x=1)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, altnv_menge_einh_id, lfd_nr) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Zuordnungstabelle GTIN (Global Trade Item Number) zum Artikel in SAP PR1 - MEAN');