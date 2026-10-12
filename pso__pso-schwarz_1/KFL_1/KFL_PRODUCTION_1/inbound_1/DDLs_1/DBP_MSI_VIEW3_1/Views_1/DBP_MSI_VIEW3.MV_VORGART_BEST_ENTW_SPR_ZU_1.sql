CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VORGART_BEST_ENTW_SPR_ZU_1 (
   mandant_id,
   vorgart_best_entw_id,
   spr_id,
   vorgart_best_entw_bez
) AS
 -- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.vorgart_best_entw_id,
   v01.spr_id,
   v01.vorgart_best_entw_bez
FROM
   dbp_view.v_vorgart_best_entw_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;