CREATE TABLE DBP_DATA.TS_SORTIMENT_PREISKLASSE_WUG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID. Kennzeichnet',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	WUG_ID NUMBER(38,0) NOT NULL,
	WRG_ID VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	PREISLAGE_1 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 1. Preislage',
	PREISLAGE_2 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 2. Preislage',
	PREISLAGE_3 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 3. Preislage',
	PREISLAGE_4 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 4. Preislage',
	PREISLAGE_5 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 5. Preislage',
	PREISLAGE_6 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 6. Preislage',
	PREISLAGE_7 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 7. Preislage',
	PREISLAGE_8 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 8. Preislage',
	PREISLAGE_9 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 9. Preislage',
	PREISLAGE_10 NUMBER(9,2) NOT NULL COMMENT 'Obergrenze der 10. Preislage',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Preisklassen zur Darstellung der Preislagen pro Warenuntergruppe (WGI) (manueller Upload der Daten durch MSI-Transaktionservice)'
;