--==============================================================
-- Table: baustein_art_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_art_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.baustein_art_zu_per_2 (
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT            '),
stueckliste_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel_2 zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH'),
dat_von DATE OPTIONS(description='Beginn der Gültigkeitsperiode            '),
akz_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Artikelkennzeichen in der Form\'A\' = Artikel_2 über sich selbst gelistet\'D\' = Artikel_2 über Display (Stückliste Display) gelistet\'K\' = Artikel_2 als Komponente über Display gelistet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (baustein_id, mandant_id, art_id, dat_bis, stueckliste_id) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Zuordnung Baustein zu Artikel_2 - MULTISET - SAP RET Tabelle WSOP_2');