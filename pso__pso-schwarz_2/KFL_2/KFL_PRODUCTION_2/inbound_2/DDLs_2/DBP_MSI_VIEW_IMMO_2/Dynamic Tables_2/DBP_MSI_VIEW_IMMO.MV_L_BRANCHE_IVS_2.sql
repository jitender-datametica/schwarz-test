CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_BRANCHE_IVS_2(
	MANDANT_ID,
	BRANCHE_ID,
	BRANCHE_BEZ,
	SPR_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

SELECT
mandant_id
,branche_id
,branche_bez
,spr_id
FROM dbp_view.v_ivs_l_branche_2
WHERE spr_id = 22;