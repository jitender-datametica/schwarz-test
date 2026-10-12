CREATE TABLE DBP_DATA.L_LAGERPROZESS_EXTERN_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERPROZESS_EXTERN_ID VARCHAR(4) NOT NULL COMMENT 'Externer Lagerungsprozessschritt',
	LAGERPROZESS_INTERN_ID VARCHAR(4) COMMENT 'Interner Lagerungsprozessschritt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Extern Lagerprozess'
;