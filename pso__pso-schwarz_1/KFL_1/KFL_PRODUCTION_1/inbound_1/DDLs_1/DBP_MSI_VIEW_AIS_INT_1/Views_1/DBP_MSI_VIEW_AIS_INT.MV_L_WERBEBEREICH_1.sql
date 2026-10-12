CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_WERBEBEREICH_1(

MANDANT_ID,
WERBEBEREICH_CD,
WERBEBEREICH_BEZ

) AS
--SPEC0259141 prescherad 17.10.2024 / Neuanlage
 SELECT
   v01.mandant_id,
   v01.werbebereich_cd,
   v01.werbebereich_bez
FROM dbp_view.v_l_werbebereich_1 v01;