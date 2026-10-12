--==============================================================
-- Table: sperrgrund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sperrgrund_spr_zu
   generated from Powerdesigner on Montag, 14. März 2022 14:12:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sperrgrund_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der "WUP" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache'),
sperrgrund_id STRING(1) NOT NULL OPTIONS(description='LVS Sperrgrund'),
sperrgrund_bez STRING(20) OPTIONS(description='LVS Sperrgrund Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, spr_id, sperrgrund_id) NOT ENFORCED
) OPTIONS(description='Lookup Sperrgrund LVS');