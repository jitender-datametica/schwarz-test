CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_WERBETEAM_1(

MANDANT_ID,
WERBETEAM_CD, 
WERBEBEREICH_CD,
WERBETEAM_BEZ

) AS
--SPEC0259141 prescherad 17.10.2024 / Neuanlage
 SELECT
    v01.mandant_id,
    v01.werbeteam_cd,
    v01.werbebereich_cd,
    v01.werbeteam_bez
FROM dbp_view.v_l_werbeteam_1 v01;