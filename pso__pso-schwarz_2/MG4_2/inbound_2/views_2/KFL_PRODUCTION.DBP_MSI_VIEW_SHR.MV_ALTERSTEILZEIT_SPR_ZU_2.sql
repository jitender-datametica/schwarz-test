create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_ALTERSTEILZEIT_SPR_ZU_2(
	MANDANT_ID,
	ATZ_PHASE_ID,
	ATZ_BEZ
) as
   SELECT
   v01.mandant_id, v01.atz_phase_id, v01.atz_bez

   FROM dbp_view.v_altersteilzeit_spr_zu_2 v01
   WHERE v01.spr_id = 22
;