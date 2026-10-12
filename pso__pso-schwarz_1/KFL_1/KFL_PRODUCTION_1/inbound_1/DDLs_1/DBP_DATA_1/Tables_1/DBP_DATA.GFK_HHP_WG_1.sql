CREATE TABLE DBP_DATA.GFK_HHP_WG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	GFK_WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der GfK Warengruppe aus dem Haushaltspanel(wird manuell im DWH generiert)',
	GFK_WG_BEZ VARCHAR(240) COLLATE 'en-ci' COMMENT 'Bezeichnung der GfK Warengruppe aus dem Haushaltspanel',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - GfK Haushaltspanel Warengruppe'
;