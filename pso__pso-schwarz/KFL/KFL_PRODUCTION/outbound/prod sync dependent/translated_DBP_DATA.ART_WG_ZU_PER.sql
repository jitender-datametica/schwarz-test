CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wg_zu_per (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel -> Counter +1'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id INTEGER NOT NULL OPTIONS(description='Warengruppe'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode'),
wug_id INTEGER NOT NULL OPTIONS(description='Warenuntergruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Artikel Warengruppe Zuordnung');