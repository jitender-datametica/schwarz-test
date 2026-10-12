CREATE TABLE DBP_DATA.LGNUM_VSTEL_SORTIMENT_ZU_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	VERSANDSTELLE_ID VARCHAR(4) NOT NULL COMMENT 'versandstelle_id',
	LAGERSORTIMENT_ID VARCHAR(1) NOT NULL COMMENT 'Lagersortiment ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagernummer / Versandstelle / Lagersortiment Zuordnung'
;