CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_AKT_GP_SPR_ZU(
	MANDANT_ID,
	AKT_GP_ID,
	AKT_GP_NAME,
	AKT_GP_NAME_DE,
	AKT_GP_NAME_CZ,
	AKT_GP_NAME_PL,
	AKT_GP_NAME_MD,
	AKT_GP_NAME_SK,
	AKT_GP_NAME_HR,
	AKT_GP_NAME_RO,
	AKT_GP_NAME_BG
) AS SELECT
v01.mandant_id,
v01.gp_id akt_gp_id,
v01.gp_name_lat AS akt_gp_name,
v01.gp_name_lat AS akt_gp_name_de,
v01.gp_name_lat AS akt_gp_name_cz,
v01.gp_name_lat AS akt_gp_name_pl,
v01.gp_name_lat AS akt_gp_name_md,
v01.gp_name_lat AS akt_gp_name_sk,
v01.gp_name_lat AS akt_gp_name_hr,
v01.gp_name_lat AS akt_gp_name_ro,
v01.gp_name AS akt_gp_name_bg
FROM dbp_view.v_gp v01;