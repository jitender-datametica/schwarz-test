create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_BESCH_BEST_DET_1(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_BEST_BELEG,
	ANFORDERER_NAME
) as
--2026-02-04, AP0309228, SPEC0356102, initial, dknop
SELECT 
mandant_id,
best_beleg_id,
best_beleg_pos_id,
dat_best_beleg,
anforderer_name
FROM dbp_view.v_besch_best_det_1;
