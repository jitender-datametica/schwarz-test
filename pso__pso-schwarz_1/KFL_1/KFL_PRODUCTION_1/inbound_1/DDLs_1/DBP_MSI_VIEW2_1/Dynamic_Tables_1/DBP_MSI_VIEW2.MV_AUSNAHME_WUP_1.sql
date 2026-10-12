CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AUSNAHME_WUP_1
(
	ART_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT_PLAN,
	PRUEF_ID,
	Z_ARBEITSGEBIET_ID,
	GP_ID,
	AUSNAHME_MUTTER_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.art_id,
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.dat_plan,
v01.pruef_id,
CASE
WHEN v01.z_arbeitsgebiet_id = 0 THEN 'Z'
WHEN v01.z_arbeitsgebiet_id = 1 THEN 'S'
ELSE ' ' END AS z_arbeitsgebiet_id,
v02.gp_id,
ausnahme_mutter_id
FROM dbp_view.v_ausnahme_1 v01
JOIN dbp_view.v_art_gp_nm_zu_per_1 v02
ON v01.art_id = v02.art_id AND
v01.mandant_id = v02.mandant_id AND
v01.wup_id = v02.wup_id AND
v01.dat_plan BETWEEN v02.dat_von AND v02.dat_bis

WHERE (v01.mandant_id = 1
AND v01.nb_id <> -111
AND pruef_id IN (126,203,204,205,206,207,208,209,210,214,216,218,221,223,225,231,700)
AND z_arbeitsgebiet_id = 1)
OR (v01.mandant_id = 1
AND v01.nb_id <> -111
AND pruef_id IN (250,252,001,005,002,253,254)
AND z_arbeitsgebiet_id = 0);