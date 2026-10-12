--==============================================================
-- Table: art_wup_vk_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_vk_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_vk_per_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode            '),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
vk_brutto NUMERIC(9,2) NOT NULL OPTIONS(description='Verkaufspreis brutto'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2_AIS - Verkaufspreise pro Markt. SAP-Quelle ist die Tabelle ZVKP_1');