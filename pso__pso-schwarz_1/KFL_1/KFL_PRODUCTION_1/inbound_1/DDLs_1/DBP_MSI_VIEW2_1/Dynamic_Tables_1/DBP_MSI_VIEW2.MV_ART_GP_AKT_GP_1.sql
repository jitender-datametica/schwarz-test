CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ART_GP_AKT_GP_1
(
	AKT_GP_ID,
	GP_ID,
	ART_ID,
	MANDANT_ID,
	AKT_GP_NAME
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.akt_gp_id, 
v02.gp_id, 
v02.art_id, 
v02.mandant_id, 
v03.gp_name

FROM dbp_msi_view2.mv_art_gp_aktuell_1 v01
INNER JOIN dbp_view.v_art_gp_zu_per_1 v02
ON v01.art_id=v02.art_id
INNER JOIN dbp_view.v_gp_1 v03
ON v01.akt_gp_id=v03.gp_id
WHERE v02.mandant_id = 1
GROUP BY 1,2,3,4,5;
