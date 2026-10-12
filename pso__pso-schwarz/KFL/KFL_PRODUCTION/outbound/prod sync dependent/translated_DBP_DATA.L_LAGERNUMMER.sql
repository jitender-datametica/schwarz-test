CREATE OR REPLACE TABLE kfl_production_dbp_data.l_lagernummer (
mandant_id INTEGER NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
oug_fg INTEGER NOT NULL
OPTIONS(description='Flag zur Kennzeichnung von Obst- und Gemüselägern. Kommt nicht aus SAP. Wird direkt im DWH gepflegt.'),
dummy_tor_id INTEGER OPTIONS(description='Dummy Tor aus ZLV_BSF_GLOBAL '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
scu_id STRING(20) OPTIONS(description='Supply-Chain-Unit'),
scu_guid STRING(32) OPTIONS(description='GUID für Supply-Chain-Unit'),
sort_id STRING(3)
OPTIONS(description='ID für Gruppierung und Sortierung im Frontend, wird im DWH gepflegt - 1. Stelle=Sortiment, 2. Stelle=Land, 3. Stelle = Lfd. Nr.'),
ewm_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates if the LGNUM is an SAP EWM-run warehouse'),
pers_teilbereich_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Lookuptabelle der Lagernummern aus der SAP Tabelle lagp');