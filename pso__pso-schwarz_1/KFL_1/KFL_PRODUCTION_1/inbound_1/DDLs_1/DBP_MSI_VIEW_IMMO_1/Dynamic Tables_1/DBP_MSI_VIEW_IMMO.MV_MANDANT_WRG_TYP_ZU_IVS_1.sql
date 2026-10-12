CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MANDANT_WRG_TYP_ZU_IVS_1(
	MANDANT_ID,
	WRG_ID,
	WRG_TYP_ID,
	WRG_TYP_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS


SELECT
mandant_id
, wrg_id
, wrg_typ_id
, wrg_typ_bez

FROM dbp_view.v_mandant_wrg_typ_zu_1;