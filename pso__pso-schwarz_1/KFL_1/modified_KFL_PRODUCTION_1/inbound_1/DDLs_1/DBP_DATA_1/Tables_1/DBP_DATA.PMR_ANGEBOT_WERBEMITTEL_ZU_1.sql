CREATE TABLE DBP_DATA.PMR_ANGEBOT_WERBEMITTEL_ZU_1 (
	MANDANT_ID INTEGER COMMENT 'Mandant_1 im DWH',
	ANGEBOT_ID INTEGER NOT NULL COMMENT 'aus TableName wbs_werbeaenderungen_1 Offer/Angebot_1',
	WERBEMITTEL_ART_ID VARCHAR(4) COMMENT 'Werbemittel Art_1 ID',
	WERBEMITTEL_ID INTEGER COMMENT 'Werbemittel ID ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='ZPMR_EOP_TACTIC_TYPE_TACTIC_TT/Funktionsbaustein Interface PMR to WBS  Exporting Values';