CREATE TABLE DBP_DATA.VS_2 (
	VS_ID INTEGER NOT NULL COMMENT 'ID der Vertriebsschiene',
	VS_BEZ VARCHAR(160) COMMENT 'Bezeichnung der Vertriebsschiene, z.Bsp. Nord',
	VK_ID INTEGER COMMENT 'Vertriebskanal ID',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	VSVT_BEZ VARCHAR(160) COMMENT 'Bezeichnung, z.Bsp. Vertrieb Nord',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	VS_REF_WUP_ID INTEGER COMMENT 'gibt den leitmarkt der region_2 an. wird manuell befüllt'
)COMMENT='TP1_MIS - Vertriebsschiene'
;