--==============================================================
-- Table: art_wup_listung_kjwo_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_listung_kjwo_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_listung_kjwo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
kreistyp_gruppe_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Region_1 / Gruppierung Kreistypen'),
listung_id BIGNUMERIC(38,0)
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_1 eigentlich obsolet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wg_id, wup_id, nb_id, kjwo) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo
OPTIONS(description='AIS - Artikellistung pro Markt / Kalenderwoche');