--==============================================================
-- Table: art_backshop_fruehstart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_fruehstart
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_backshop_fruehstart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
fruehstart_menge NUMERIC(18,3) OPTIONS(description='Frühstartmenge des Backartikels (vermutlich  Stückzahl).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='Backplan. Vorgabe der Frühstartmenge je Land-Markt-Artikel.');