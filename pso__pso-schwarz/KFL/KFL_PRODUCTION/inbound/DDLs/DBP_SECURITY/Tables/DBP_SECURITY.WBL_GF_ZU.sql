CREATE TABLE DBP_SECURITY.WBL_GF_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WBL_ID NUMBER(38,0) NOT NULL COMMENT 'Warenbereichsleiter ID',
	GF_ID NUMBER(38,0) COMMENT 'Geschäftsführer ID, numerisch',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Zuordnungstabelle WBL (EKL - Einkaufsleiter) zu GF (Geschäftsführer) - wird manuell über MSI (TAS) befüllt'
;