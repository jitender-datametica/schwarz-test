CREATE TABLE DBP_DATA.L_LAGERPROZESS_EXTERN (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	LAGERPROZESS_EXTERN_ID VARCHAR(4) NOT NULL COMMENT 'Externer Lagerungsprozessschritt',
	LAGERPROZESS_INTERN_ID VARCHAR(4) COMMENT 'Interner Lagerungsprozessschritt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Extern Lagerprozess'
;