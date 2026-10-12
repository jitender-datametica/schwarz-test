--==============================================================
-- Table: transportation_unit_tor_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_tor_zu_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:35:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_tor_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='transportation_unit_sr_act_id'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
tor_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagertor   '),
tor_sr_act_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Tor     '),
datzeit_start_ist TIMESTAMP OPTIONS(description='Ist-Startzeitstempel TE/Tor-Zuordnung       '),
datzeit_ende_ist TIMESTAMP OPTIONS(description='Ist-Endezeitstempel TE/Tor-Zuordnung   '),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
konsolidierungsgruppe_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Consolidation Group'),
spur_kapazitaet NUMERIC(11,3) OPTIONS(description='Kapazität vom Platz'),
spur_voll_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Bereitstellungsplatz ist voll'),
spur_planung_quittiert_fg BIGNUMERIC(38,0) OPTIONS(description='Lane Planning Quittiert'),
spurgruppe_id BIGNUMERIC(38,0) OPTIONS(description='Spurgruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, tor_sr_act_id)
NOT ENFORCED
) OPTIONS(description='Zuordnung EWM-Tour_1 zu Tor (/SCWM/TU_DOOR).');