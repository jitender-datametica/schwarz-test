CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_HERST_ZU_1
(
mandant_id
,art_id
,herst_id
,gp_art_id
,gp_id
,akt_gp_id
,mhd_zeitraum_dz
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT DISTINCT
v1.mandant_id,
v1.art_id, 
CASE WHEN v1.herst_id = v2.gp_id THEN -2 ELSE v1.herst_id END herst_id,
v1.gp_art_id, 
v2.gp_id,
v2.gp_id AS akt_gp_id,
v1.mhd_zeitraum_dz
FROM dbp_view.v_art_gp_zu_per_1 v1
LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v2
ON v1.art_id = v2.art_id
AND v1.mandant_id = v2.mandant_id
WHERE v1.dat_bis = '9999-12-31';