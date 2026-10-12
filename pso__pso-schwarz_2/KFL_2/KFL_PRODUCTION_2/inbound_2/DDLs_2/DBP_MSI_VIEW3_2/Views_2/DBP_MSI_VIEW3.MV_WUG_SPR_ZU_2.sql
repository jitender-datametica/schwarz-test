CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUG_SPR_ZU_2 (
   mandant_id,
   wug_id,
   arthiertyp_id,
   wg_id,
   spr_id,
   wug_bez,
   wug_id_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.wug_id,
   v01.arthiertyp_id,
   v01.wg_id,
   v01.spr_id,
   v01.wug_bez,
   CAST(
      CAST(v01.wug_id AS CHAR(10)) || ' ' || v01.wug_bez AS CHAR(50)
   ) AS wug_id_bez
FROM
   dbp_view.v_wug_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2;