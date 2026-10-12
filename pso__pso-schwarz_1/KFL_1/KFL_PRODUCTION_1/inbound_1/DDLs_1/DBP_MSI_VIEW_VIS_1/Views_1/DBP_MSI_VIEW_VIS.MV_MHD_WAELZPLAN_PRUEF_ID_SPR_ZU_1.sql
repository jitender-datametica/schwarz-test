CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MHD_WAELZPLAN_PRUEF_ID_SPR_ZU_1(
 MANDANT_ID,
 WAELZPLAN_PRUEF_ID,
 WAELZPLAN_PRUEF_BEZ,
 WAELZPLAN_PRUEF_BEZ_CZ,
 WAELZPLAN_PRUEF_BEZ_PL,
 WAELZPLAN_PRUEF_BEZ_SK,
 WAELZPLAN_PRUEF_BEZ_HR,
 WAELZPLAN_PRUEF_BEZ_RO,
 WAELZPLAN_PRUEF_BEZ_BG
) AS
-- 09012023 snik - Creation 
  SELECT
    mandant_id
   ,waelzplan_pruef_id
   ,MAX(CASE WHEN spr_id =  22 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez   
   ,MAX(CASE WHEN spr_id = 124 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_cz
   ,MAX(CASE WHEN spr_id =  90 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_pl
   ,MAX(CASE WHEN spr_id = 108 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_sk
   ,MAX(CASE WHEN spr_id =  65 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_hr
   ,MAX(CASE WHEN spr_id =  95 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_ro
   ,MAX(CASE WHEN spr_id =  18 THEN waelzplan_pruef_bez ELSE NULL END)  AS waelzplan_pruef_bez_bg
  FROM DBP_VIEW.V_MHD_WAELZPLAN_PRUEF_ID_SPR_ZU_1
  GROUP BY
    mandant_id
   ,waelzplan_pruef_id
;