CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_LAGERNUMMER_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
LAGERNUMMER_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
OUG_FG INTEGER NOT NULL
OPTIONS(description='Flag zur Kennzeichnung von Obst- und Gemüselägern. Kommt nicht aus SAP. Wird direkt im DWH gepflegt.'),
DUMMY_TOR_ID INTEGER OPTIONS(description='Dummy_1 Tor aus ZLV_BSF_GLOBAL '),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
SCU_ID STRING(20) OPTIONS(description='Supply-Chain-Unit_1'),
SCU_GUID STRING(32) OPTIONS(description='GUID für Supply-Chain-Unit_1'),
SORT_ID STRING(3)
OPTIONS(description='ID für Gruppierung und Sortierung im Frontend, wird im DWH gepflegt - 1. Stelle=Sortiment, 2. Stelle=Land_1, 3. Stelle = Lfd. Nr.'),
EWM_FG INTEGER DEFAULT 0 OPTIONS(description='Indicates if the LGNUM is an SAP EWM-run warehouse'),
PERS_TEILBEREICH_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Lookuptabelle der Lagernummern aus der SAP Tabelle lagp');