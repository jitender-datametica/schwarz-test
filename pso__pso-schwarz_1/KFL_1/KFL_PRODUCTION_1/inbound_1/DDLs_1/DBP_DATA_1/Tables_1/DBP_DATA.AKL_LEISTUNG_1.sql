CREATE TABLE DBP_DATA.AKL_LEISTUNG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERNUMMER_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Lagernummer/Lagerkomplex',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
	STUNDE NUMBER(38,0) COMMENT 'Stunde         ',
	LAGERTYP_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Lagertyp',
	MELDEPUNKT VARCHAR(6) COMMENT 'Meldepunkt',
	WARENBEWEGUNGSTYP_ID VARCHAR(1) COLLATE 'en-ci' COMMENT 'Warenbewegungstyp',
	LAGER_EINHEITEN_TYP VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Lagereinheittyp: Der Lager-Einheiten_Typ betrifft die Höhe einer Palette (z.Bsp. P3 = Palette Höhe 3 (165)). Aus letyp',
	MENGE_LBS_LVS_PALETTE NUMBER(38,0) COMMENT 'Anzahl Behälter',
	MENGE_LBS_LVS_KOLLI NUMBER(38,0) COMMENT 'Anzahl Kolli',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Leistungsdaten AKL'
;