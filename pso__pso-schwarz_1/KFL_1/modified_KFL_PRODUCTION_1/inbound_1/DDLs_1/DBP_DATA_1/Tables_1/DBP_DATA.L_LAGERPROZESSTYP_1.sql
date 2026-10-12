CREATE TABLE DBP_DATA.L_LAGERPROZESSTYP_1 (
	LAGERPROZESSTYP_ID VARCHAR(1) NOT NULL COMMENT 'Lagerprozesstyp',
	AKTIVITAET_FG VARCHAR(1) COMMENT 'Aktivität',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerprozesstyp'
;