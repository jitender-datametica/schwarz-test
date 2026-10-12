CREATE TABLE DBP_DATA.LGNUM_VSTEL_SORTIMENT_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	VERSANDSTELLE_ID VARCHAR(4) NOT NULL COMMENT 'versandstelle_id',
	LAGERSORTIMENT_ID VARCHAR(1) NOT NULL COMMENT 'Lagersortiment ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagernummer / Versandstelle / Lagersortiment Zuordnung'
;