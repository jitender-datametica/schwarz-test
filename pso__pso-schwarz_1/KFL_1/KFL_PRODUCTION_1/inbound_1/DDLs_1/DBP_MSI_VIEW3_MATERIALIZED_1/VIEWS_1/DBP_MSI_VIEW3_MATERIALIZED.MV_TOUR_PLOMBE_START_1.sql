create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_PLOMBE_START_1(
	MANDANT_ID,
	TOUR_ID,
	PLOMBE_ID,
	PLOMBE_POS_ID,
	NB_ID,
	WUP_ID,
	PLOMBE_VORGANG_ID,
	DAT_ERFASST,
	ZEIT_ERFASST,
	STORNO_FG
) as
   SELECT
   mandant_id, tour_id, plombe_id, plombe_pos_id, nb_id, wup_id, plombe_vorgang_id, dat_erfasst, zeit_erfasst, storno_fg
   FROM dbp_view.v_tour_plombe_start_1;