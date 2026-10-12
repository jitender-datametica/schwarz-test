create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_ALTERSTEILZEIT_1(
	MANDANT_ID,
	ATZ_PHASE_ID
) as
   SELECT
   v01.mandant_id, v01.atz_phase_id

   FROM dbp_view.v_l_altersteilzeit_1 v01;