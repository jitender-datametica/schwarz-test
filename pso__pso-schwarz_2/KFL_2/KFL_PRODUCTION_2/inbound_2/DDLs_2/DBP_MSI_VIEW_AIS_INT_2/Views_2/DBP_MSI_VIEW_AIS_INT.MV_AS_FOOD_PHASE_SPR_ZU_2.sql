CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_AS_FOOD_PHASE_SPR_ZU_2 (
	PHASE_ID,
	PHASE_BEZ,
	PHASE_BEZ_DE,
	PHASE_BEZ_CZ,
	PHASE_BEZ_SK,
	PHASE_BEZ_HR,
	PHASE_BEZ_PL,
	PHASE_BEZ_RO,
	PHASE_BEZ_BG
	) AS SELECT 
	DISTINCT v01.phase_id
	,'Phase ' || phase_id
	,'Phase ' || phase_id
	,'Fáze ' || phase_id
	,'Fáza ' || phase_id
	,'Faza ' || phase_id
	,'Faza ' || phase_id
	,'Faza ' || phase_id
	,'Фаза ' || phase_id
	FROM dbp_view.v_as_food_det_2 v01
	WHERE v01.phase_id <> 4;