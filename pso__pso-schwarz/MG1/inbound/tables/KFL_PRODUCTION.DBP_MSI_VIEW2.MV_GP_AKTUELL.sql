create or replace dynamic table MV_GP_AKTUELL(
	AKT_GP_ID,
	AKT_GP_NAME
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_P_DYNAMIC_TABLE_AIS_DE
 as
SELECT
v01.gp_id,
gp_name
--, wup_id

FROM dbp_view.v_art_gp_nm_zu_per v01
LEFT JOIN dbp_view.v_gp v02
ON  v01.gp_id=v02.gp_id
AND v01.mandant_id = v02.mandant_id

WHERE v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
GROUP BY 1,2;