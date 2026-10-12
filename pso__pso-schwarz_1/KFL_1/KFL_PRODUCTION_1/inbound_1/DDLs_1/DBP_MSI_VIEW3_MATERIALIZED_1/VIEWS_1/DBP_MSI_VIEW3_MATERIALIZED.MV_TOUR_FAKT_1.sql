create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOUR_FAKT_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	TOUR_ID,
	DAT_TOUR,
	TRANSPORTART_ID,
	GP_ID,
	LAGERNUMMER_ID,
	ANZAHL_TOUR
) as
SELECT
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.tour_id,
v01.dat_tour,
v01.transportart_id,
v01.gp_id,
v02.lagernummer_id,
v01.tour_id AS anzahl_tour     -- Nur mit count(distinct) verwendbar!!!

FROM dbp_view.v_tour_1 v01
INNER JOIN dbp_view.v_tour_det_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.nb_id = v02.nb_id
AND v01.tour_id = v02.tour_id
WHERE v02.loesch_fg = 0
AND extract(year from v01.dat_tour) >= year(current_timestamp) - 2;