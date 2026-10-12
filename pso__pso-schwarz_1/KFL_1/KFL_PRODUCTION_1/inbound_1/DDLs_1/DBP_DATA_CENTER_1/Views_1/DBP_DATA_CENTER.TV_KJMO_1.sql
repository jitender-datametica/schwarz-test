create or replace view DBP_DATA_CENTER.TV_KJMO_1(
	KJMO
) as SELECT
kjmo
FROM dbp_view.v_monat_1;