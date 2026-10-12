CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOURART_SUBTYP_SPR_ZU_2 (
   tourart_subtyp_id,
   spr_id,
   mandant_id,
   tourart_subtyp_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.tourart_subtyp_id,
   v01.spr_id,
   v01.mandant_id,
   v01.tourart_subtyp_bez
FROM
   dbp_view.v_tourart_subtyp_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;