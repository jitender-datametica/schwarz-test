CREATE TABLE CORE_REL.T_ORDER_QUANTITY_FOOD (
	MANDANT VARCHAR(100) NOT NULL COMMENT 'Mandant oder Mieterkennung',
	ARTIKEL VARCHAR(100) NOT NULL COMMENT 'Artikelnummer',
	KALENDERWOCHE NUMBER(38,0) NOT NULL COMMENT 'Kalenderwoche',
	LAND VARCHAR(100) COMMENT 'Ländercode',
	BEZEICHNUNG VARCHAR(100) COMMENT 'Artikelbeschreibung',
	VERPACKUNGSINHALT NUMBER(38,0) COMMENT 'Größe der Verpackung (Menge)',
	SUMMIERUNG_LAND_KRT NUMBER(38,0) COMMENT 'Summe für Land Karton',
	SUMMIERUNG_LAND_STUECK NUMBER(38,0) COMMENT 'Summe für Land in Stück',
	DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH.',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH.',
	PALLET_FACTOR NUMBER(38,0) COMMENT 'A numeric value representing how many cases of a product fit onto a single pallet.',
	CONSTRAINT PK_T_ORDER_QUANTITY_FOOD PRIMARY KEY (MANDANT, ARTIKEL, KALENDERWOCHE)
)COMMENT='Loaded from Export_VK_Mengen_GHFood_.xlsx'
;