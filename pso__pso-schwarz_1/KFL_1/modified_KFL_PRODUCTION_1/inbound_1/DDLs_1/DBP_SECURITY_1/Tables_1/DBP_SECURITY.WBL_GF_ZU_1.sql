CREATE TABLE DBP_SECURITY.WBL_GF_ZU_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	WBL_ID INTEGER NOT NULL COMMENT 'Warenbereichsleiter ID',
	GF_ID INTEGER COMMENT 'Geschäftsführer ID, numerisch',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Zuordnungstabelle WBL_1 (EKL - Einkaufsleiter) zu GF_1 (Geschäftsführer) - wird manuell über MSI (TAS) befüllt'
;