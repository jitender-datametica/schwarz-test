CREATE TABLE DBP_DATA.L_LAGERPROZESS_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	LAGERPROZESS_ID VARCHAR(4) NOT NULL COMMENT 'Lagerungsprozess',
	RICHTUNG_ID VARCHAR(1) COMMENT 'Richtung (Lagerungsprozesstyp T333A)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerprozess'
;