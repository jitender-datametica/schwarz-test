CREATE OR REPLACE VIEW DBP_MSi_VIEW_AIS_INT.MV_ART_USER_ZU_2
AS
SELECT DISTINCT
v01.art_id,
v01.mandant_id,
v02.user_id
                              
FROM dbp_msi_v_view.v_art_zek_zu_2 v01
                              
JOIN dbp_security.user_zek_zu_2 v02
ON v01.zek_id = v02.zek_id
AND v01.mandant_id = v02.mandant_id

JOIN 
(SELECT DISTINCT 
 user_id 
 FROM 
 dbp_msi_v_view.v_akt_msi_user_2) v03
ON v03.user_id = v02.user_id;