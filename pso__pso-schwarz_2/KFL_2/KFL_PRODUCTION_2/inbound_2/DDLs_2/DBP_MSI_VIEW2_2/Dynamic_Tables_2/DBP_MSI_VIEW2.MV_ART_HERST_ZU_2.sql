CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_HERST_ZU_2
(
	MANDANT_ID,
	ART_ID,
	HERST,
	HERST_ID,
	GP_ART_ID,
	GP_ID,
	AKT_GP_ID,
	MHD_ZEITRAUM_DZ
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT DISTINCT
v1.mandant_id,
v1.art_id, 
v1.herst_id,
CASE WHEN v1.herst_id = v2.gp_id THEN -2 ELSE v1.herst_id END,
v1.gp_art_id, 
v2.gp_id,
v2.gp_id AS akt_gp_id,
v1.mhd_zeitraum_dz

FROM dbp_view.v_art_gp_zu_per_2 v1
LEFT JOIN dbp_view.v_art_gp_nm_zu_per_2 v2
ON v1.art_id = v2.art_id 
WHERE v1.mandant_id = 1
AND v1.dat_bis = '9999-12-31';
