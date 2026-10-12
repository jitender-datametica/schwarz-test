CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagernummer_tor_bsf_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
tor_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagertor   '),
bsf_gruppe_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bereitstellungszonengruppe          '),
bsf_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bereitstellungszone'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);