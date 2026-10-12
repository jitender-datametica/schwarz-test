CREATE TABLE DBP_DATA.PMR_ANGEBOT_WERBEMITTEL_ZU_2 (
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant_2 im DWH',
	ANGEBOT_ID NUMBER(38,0) NOT NULL COMMENT 'aus TableName wbs_werbeaenderungen_2 Offer/Angebot_2',
	WERBEMITTEL_ART_ID VARCHAR(4) COMMENT 'Werbemittel Art_2 ID',
	WERBEMITTEL_ID NUMBER(38,0) COMMENT 'Werbemittel ID ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='ZPMR_EOP_TACTIC_TYPE_TACTIC_TT/Funktionsbaustein Interface PMR to WBS  Exporting Values';