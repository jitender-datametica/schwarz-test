CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_DISPOSITION_RHYTHMUS_SPR_ZU_1 (
   system_id,
   mandant_id,
   disposition_rhythmus_id,
   spr_id,
   disposition_rhythmus_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.system_id,
   v01.mandant_id,
   v01.disposition_rhythmus_id,
   v01.spr_id,
   v01.disposition_rhythmus_bez
FROM
   dbp_view.v_disposition_rhythmus_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02
   ON v01.spr_id = v02.spr_id;