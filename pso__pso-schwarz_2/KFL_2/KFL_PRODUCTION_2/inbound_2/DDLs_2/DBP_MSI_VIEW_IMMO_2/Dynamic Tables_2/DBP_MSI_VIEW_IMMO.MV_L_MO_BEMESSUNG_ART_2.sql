CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MO_BEMESSUNG_ART_2(
	MANDANT_ID,
	BEMESSUNG_ART_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   mandant_id, bemessung_art_id
   FROM dbp_view.v_immo_l_mo_bemessung_art_2;