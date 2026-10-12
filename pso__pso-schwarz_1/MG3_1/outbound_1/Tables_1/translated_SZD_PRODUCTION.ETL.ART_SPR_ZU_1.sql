CREATE OR REPLACE TABLE szd_production_etl.art_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_1 -> Counter +1'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
art_bez STRING(200) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);