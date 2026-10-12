CREATE TABLE DBP_DATA.L_LAGERPROZESSART_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	LAGERPROZESSART_ID VARCHAR(4) NOT NULL COMMENT 'Lagerprozessart',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerprozessart'
;