CREATE TABLE CORE_REL.T_ORDER_QUANTITY_FOOD_2 (
	MANDANT_2 VARCHAR(100) NOT NULL COMMENT 'Mandant_2 oder Mieterkennung',
	ARTIKEL_2 VARCHAR(100) NOT NULL COMMENT 'Artikelnummer',
	KALENDERWOCHE NUMBER(38,0) NOT NULL COMMENT 'Kalenderwoche',
	LAND_2 VARCHAR(100) COMMENT 'Ländercode',
	BEZEICHNUNG VARCHAR(100) COMMENT 'Artikelbeschreibung',
	VERPACKUNGSINHALT NUMBER(38,0) COMMENT 'Größe der Verpackung (Menge)',
	SUMMIERUNG_LAND_KRT NUMBER(38,0) COMMENT 'Summe für Land_2 Karton',
	SUMMIERUNG_LAND_STUECK NUMBER(38,0) COMMENT 'Summe für Land_2 in Stück',
	DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH.',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH.',
	PALLET_FACTOR NUMBER(38,0) COMMENT 'A numeric value representing how many cases of a product fit onto a single pallet.',
	CONSTRAINT PK_T_ORDER_QUANTITY_FOOD PRIMARY KEY (MANDANT_2, ARTIKEL_2, KALENDERWOCHE)
)COMMENT='Loaded from Export_VK_Mengen_GHFood_.xlsx'
;