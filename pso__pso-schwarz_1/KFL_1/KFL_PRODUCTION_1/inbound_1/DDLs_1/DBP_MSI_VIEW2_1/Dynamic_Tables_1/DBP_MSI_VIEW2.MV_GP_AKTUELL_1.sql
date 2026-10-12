CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_GP_AKTUELL_1
(
	AKT_GP_ID,
	AKT_GP_NAME
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.gp_id,
gp_name
--, wup_id

FROM dbp_view.v_art_gp_nm_zu_per_1 v01
LEFT JOIN dbp_view.v_gp_1 v02
ON  v01.gp_id=v02.gp_id
AND v01.mandant_id = v02.mandant_id

WHERE v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
GROUP BY 1,2;