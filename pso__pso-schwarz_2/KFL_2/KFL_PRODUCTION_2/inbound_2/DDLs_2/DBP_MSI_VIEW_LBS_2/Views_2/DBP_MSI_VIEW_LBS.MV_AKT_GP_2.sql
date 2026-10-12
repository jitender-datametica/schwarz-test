CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_AKT_GP_2(
	MANDANT_ID,
	AKT_GP_ID,
	AKT_GP_NAME,
	AKT_LAND_ID
) AS SELECT
v01.mandant_id,
v01.gp_id akt_gp_id,
v01.gp_name akt_gp_name,
v01.land_id akt_land_id
FROM dbp_view.v_gp_2 v01;