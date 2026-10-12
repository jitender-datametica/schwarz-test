create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ANLIEFERUNG_MANAGEMENT_DET_2(
	MANDANT_ID,
	ANLIEFERUNG_ID,
	BEST_BELEG_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	RETOURE_FG,
	PALETTIERT_FG,
	WERBUNG_FG,
	GP_ID
) as
   SELECT v01.mandant_id, v01.anlieferung_id, v01.best_beleg_id, v01.lagernummer_id, v01.wup_id, v01.nb_id, v01.retoure_fg, v01.palettiert_fg, v01.werbung_fg, v01.gp_id
   FROM dbp_view.v_anlieferung_management_det_2 v01;