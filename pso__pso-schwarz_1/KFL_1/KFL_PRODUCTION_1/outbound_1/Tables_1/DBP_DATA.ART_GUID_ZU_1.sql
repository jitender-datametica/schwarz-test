CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_guid_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_guid_c22 STRING(22) NOT NULL OPTIONS(description='Materialnummer STRING 22'),
art_guid STRING(32) OPTIONS(description='Materialnummer RAW 16'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Zuordnung Artikel_1 GUID zu Artikelnummer');