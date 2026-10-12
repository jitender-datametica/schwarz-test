CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ANNAHMEVERWEIGERUNG_SPR_ZU_1 (
   mandant_id,
   annahmeverweigerung_id,
   spr_id,
   annahmeverweigerung_bez
) AS -- 20230717 staeblern Umstellung auf Session Variable 
SELECT
   v01.mandant_id,
   v01.annahmeverweigerung_id,
   v01.spr_id,
   v01.annahmeverweigerung_bez
FROM
   dbp_view.v_annahmeverweigerung_spr_zu_1 v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;