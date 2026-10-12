CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_RUECK_GRUND_SPR_ZU_1 (
   rueck_grund_id,
   mandant_id,
   spr_id,
   rueck_grund_bez
) AS 
-- AP0002469, 13.01.2016, srom0404, UNION auf -1 (nicht jede Rückführung hat einen Grund)
-- in der View mv_rueckfuehrung_lt_1 ist entsprechend COALESCE mit -1 eingebaut
-- in der View mv_l_rueck_grund_1 ist entsprechend UNION auf -1 eingebaut
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.rueck_grund_id,
   v01.mandant_id,
   v01.spr_id,
   v01.rueck_grund_bez
FROM
   dbp_view.v_rueck_grund_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id
UNION
SELECT
   -1 AS rueck_grund_id,
   mandant_id,
   22 AS spr_id,
   'DWH - no reason' AS rueck_grund_bez
FROM
   dbp_view.v_mandant_1;