CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IN_EINKAEUFER_GRP_SPR_ZU(
	MANDANT_ID,
	EINKAEUFER_GRP_ID,
	SPR_ID,
	EINKAEUFER_GRP_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   mandant_id, einkaeufer_grp_id, spr_id, einkaeufer_grp_bez
   FROM dbp_view.v_in_einkaeufer_grp_spr_zu
   WHERE spr_id = 22;