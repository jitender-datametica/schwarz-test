CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ABT_SPR_ZU_EN_2
-- 2021.09.22, srom0404, INC3535686, remove filter on mandant_id = 1 and some formatting
(
mandant_id
, arthiertyp_id
, abt_id
, abt_bez
, spr_id
)
AS
SELECT v01.mandant_id
      ,v01.arthiertyp_id
      ,v01.abt_id
      ,COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.abt_bez END) 
               ,MAX(CASE WHEN v01.spr_id = 22 THEN v01.abt_bez END)
               ) AS abt_bez
     ,MAX(v01.spr_id) AS spr_id
FROM dbp_view.v_abt_spr_zu_2 v01

WHERE v01.arthiertyp_id = 2
  AND v01.spr_id IN (22,24) 
   --AND mandant_id = 1

GROUP BY v01.mandant_id
        ,v01.arthiertyp_id
        ,v01.abt_id
;