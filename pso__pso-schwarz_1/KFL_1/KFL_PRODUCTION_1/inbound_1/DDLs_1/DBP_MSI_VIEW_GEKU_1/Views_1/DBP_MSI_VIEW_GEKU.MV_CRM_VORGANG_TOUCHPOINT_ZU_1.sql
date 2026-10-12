CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_VORGANG_TOUCHPOINT_ZU_1
(
	MANDANT_ID,
	CRM_VORGANG_ID,
	TOUCHPOINT_ID,
	TOUCHPOINT_COUNT,
	TOUCHPOINT_FG,
	DAT_START,
	DAT_ENDE,
	DAT_START_PROCESSING,
	DAT_END_PROCESSING,
	SEC_KZ
) AS
--staeblern AP0097264 SPEC0134521 initiale Anlage_1 
--02.05.2024 twie: SPEC0247600 neue Datumsfelder aus Vorgang

SELECT v01.MANDANT_ID, 
    v01.CRM_VORGANG_ID,
    v01.TOUCHPOINT_ID,
    v01.TOUCHPOINT_COUNT,
    CASE WHEN v01.TOUCHPOINT_COUNT > 0 THEN 1 ELSE 0 END AS TOUCHPOINT_FG,
    TO_DATE(v02.dat_start) AS dat_start,
    TO_DATE(v02.dat_ende) AS dat_ende,
    TO_DATE(v02.dat_start_processing) AS dat_start_processing,
    TO_DATE(v02.dat_end_processing) AS dat_end_processing,
    3::BYTEINT AS sec_kz
    
FROM DBP_VIEW.V_CRM_VORGANG_TOUCHPOINT_ZU_1 v01

JOIN dbp_view.v_crm_vorgang_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.crm_vorgang_id = v02.crm_vorgang_id
;