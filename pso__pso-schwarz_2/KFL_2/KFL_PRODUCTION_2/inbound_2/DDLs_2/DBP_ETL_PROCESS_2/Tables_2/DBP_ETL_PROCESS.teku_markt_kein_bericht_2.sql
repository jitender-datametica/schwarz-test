CREATE OR REPLACE TABLE TEKU_MARKT_KEIN_BERICHT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	KEIN_BERICHT_BEZ VARCHAR(255) COMMENT 'Hier ist ein Text hinterlegt, wer keinen Bericht bekommen soll. z.Bsp. HL_2 plus VKL_2',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='TEKU Ladehilfstabelle - für Märkte und deren Hierarchie-Elemente, die keinen Bericht erhalten sollen.'
;