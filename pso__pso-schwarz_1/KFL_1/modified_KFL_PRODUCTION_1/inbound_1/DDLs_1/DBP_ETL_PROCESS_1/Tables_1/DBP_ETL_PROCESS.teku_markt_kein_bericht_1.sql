CREATE OR REPLACE TABLE TEKU_MARKT_KEIN_BERICHT_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	KEIN_BERICHT_BEZ VARCHAR(255) COMMENT 'Hier ist ein Text hinterlegt, wer keinen Bericht bekommen soll. z.Bsp. HL_1 plus VKL_1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='TEKU Ladehilfstabelle - für Märkte und deren Hierarchie-Elemente, die keinen Bericht erhalten sollen.'
;