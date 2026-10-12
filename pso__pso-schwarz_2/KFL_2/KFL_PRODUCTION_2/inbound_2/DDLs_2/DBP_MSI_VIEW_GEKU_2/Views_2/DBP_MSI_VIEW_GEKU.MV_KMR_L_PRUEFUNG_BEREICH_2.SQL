CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_PRUEFUNG_BEREICH_2(
	AMX_SYSTEM_ID,
	PRUEFUNG_BEREICH_ID,
	PRUEFUNG_BEREICH_BEZ
) AS 
    SELECT 
        amx_system_id,
        pruefung_bereich_id,
        pruefung_bereich_bez
 
FROM DBP_VIEW.V_KMR_L_PRUEFUNG_BEREICH_2 ;


--- new view for SPEC0242924