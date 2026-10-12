CREATE TABLE DBP_DATA.LAGERNUMMER_TOR_BSF_ZU (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
	WUP_ID INTEGER COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	TOR_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Lagertor   ',
	BSF_GRUPPE_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Bereitstellungszonengruppe          ',
	BSF_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Bereitstellungszone',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);