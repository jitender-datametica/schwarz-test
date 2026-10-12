CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wg_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_1 -> Counter +1'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode'),
wug_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenuntergruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Artikel_1 Warengruppe Zuordnung');