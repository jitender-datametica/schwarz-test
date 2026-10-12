CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_STANDORT_TYP_SPR_ZU (
   belos_standort_typ_id,
   spr_id,
   belos_standort_typ_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.belos_standort_typ_id,
   v01.spr_id,
   v01.belos_standort_typ_bez
FROM
   dbp_view.v_belos_standort_typ_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;