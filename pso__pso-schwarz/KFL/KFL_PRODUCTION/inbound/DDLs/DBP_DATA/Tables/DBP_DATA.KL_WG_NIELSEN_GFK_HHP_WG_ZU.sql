CREATE TABLE DBP_DATA.KL_WG_NIELSEN_GFK_HHP_WG_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	KL_WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
	GFK_WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der GfK Warengruppe aus dem Haushaltspanel(wird manuell im DWH generiert)',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sortimentstool - Mapping-Tabelle Kaufland Warengruppen für Nielsen (kl_wg_id) zu GfK Haushaltspanel Warengruppe (gfk_wg_id) - wird durch einen TS-Bericht aus MSI vom FB gepflegt'
;