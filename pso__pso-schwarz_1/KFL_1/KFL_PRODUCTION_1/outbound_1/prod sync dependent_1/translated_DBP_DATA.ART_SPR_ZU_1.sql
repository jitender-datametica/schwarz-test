CREATE OR REPLACE TABLE kfl_production_dbp_data.art_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache '),
art_bez STRING(200) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung aus SAP Retail.'),
int_art_bez STRING(200) COLLATE 'und:ci'
OPTIONS(description='Artikelbezeichnung aus ZSM, Diese können von SAP Retail Bezeichnungen abweichen.(ZSM:Zentrale Stammdaten Management, das verteilt die Bezeichnungen an SAP Retail, das diese überschreiben kann.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhaengige Bezeichnungen der Artikel_1');