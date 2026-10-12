CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_WERBEBEREICH(

MANDANT_ID,
WERBEBEREICH_CD,
WERBEBEREICH_BEZ

) AS
--SPEC0259141 prescherad 17.10.2024 / Neuanlage
 SELECT
   v01.mandant_id,
   v01.werbebereich_cd,
   v01.werbebereich_bez
FROM dbp_view.v_l_werbebereich v01
WHERE v01.mandant_id = 1;