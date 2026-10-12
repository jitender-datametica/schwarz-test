CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_AKT_GP_1(
	MANDANT_ID,
	AKT_GP_ID,
	AKT_GP_NAME
) AS
--2024-04-22, AP0179753, dknop, initial
SELECT
 v01.mandant_id
,v01.gp_id AS akt_gp_id
,v01.gp_name AS akt_gp_name
FROM dbp_view.v_gp_1 v01
;