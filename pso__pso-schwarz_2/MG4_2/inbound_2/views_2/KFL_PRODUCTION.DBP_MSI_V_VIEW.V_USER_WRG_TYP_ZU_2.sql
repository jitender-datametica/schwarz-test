create or replace view KFL_PRODUCTION.DBP_MSI_V_VIEW.V_USER_WRG_TYP_ZU_2(
	USER_ID COMMENT 'ID des MSI Users',
	WRG_TYP_ID COMMENT 'Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0',
	BERICHTSKURS_TYP_ID COMMENT 'Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1'
) as 
    SELECT 
        user_id,
        wrg_typ_id,
        berichtskurs_typ_id

FROM DBP_MSI_DATA.USER_WRG_TYP_ZU_2 ;