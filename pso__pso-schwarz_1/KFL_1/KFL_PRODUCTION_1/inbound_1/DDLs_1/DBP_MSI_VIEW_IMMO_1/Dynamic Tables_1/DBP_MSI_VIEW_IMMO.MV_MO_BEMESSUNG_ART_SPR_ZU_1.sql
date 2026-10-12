CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MO_BEMESSUNG_ART_SPR_ZU_1(
	MANDANT_ID,
	BEMESSUNG_ART_ID,
	SPR_ID,
	BEMESSUNG_ART_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   mandant_id, bemessung_art_id, spr_id, bemessung_art_bez
   FROM dbp_view.v_immo_mo_bemessung_art_spr_zu_1
   WHERE spr_id =22

   UNION ALL

   SELECT DISTINCT
   mandant_id, '' AS bemessung_art_id, 22 AS spr_id, ' ' AS bemessung_art_bez
   FROM dbp_view.v_mandant_1;