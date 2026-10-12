CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MO_ART_1(
	MO_ART_KZ,
	MO_ART_BEZ
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v0.mo_art_kz, v1.mo_art_bez
   FROM dbp_view.v_immo_l_mo_art_1 v0
   JOIN dbp_view.v_immo_mo_art_spr_zu_1 v1
   ON v0.mandant_id = v1.mandant_id
   AND v0.mo_art_kz = v1.mo_art_kz
   AND v1.spr_id = 22
   WHERE v0.mandant_id = 1;