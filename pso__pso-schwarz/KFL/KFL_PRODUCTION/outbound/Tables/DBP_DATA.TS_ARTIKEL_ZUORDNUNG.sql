CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_artikel_zuordnung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ean_id NUMERIC(26,0) NOT NULL OPTIONS(description='Enthält die Haupt-GTIN für KMO'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='EK-SORT - TS Zuordnung Artikel zu Artikelhierarchie');