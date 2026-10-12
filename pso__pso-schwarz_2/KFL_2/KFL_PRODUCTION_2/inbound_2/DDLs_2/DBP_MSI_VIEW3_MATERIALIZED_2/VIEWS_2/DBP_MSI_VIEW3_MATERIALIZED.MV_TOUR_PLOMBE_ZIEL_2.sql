create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_PLOMBE_ZIEL_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	TOUR_ID,
	PLOMBE_ID,
	PLOMBE_PROZESS_ID,
	PLOMBE_AKTIVITAET,
	DAT_SCAN,
	ZEIT_SCAN
) as
   SELECT
   mandant_id, nb_id, wup_id, tour_id, plombe_id, plombe_prozess_id, plombe_aktivitaet, dat_scan, zeit_scan
   FROM dbp_view.v_tour_plombe_ziel_2
   WHERE extract(year from dat_scan) >= year(current_timestamp) - 2;