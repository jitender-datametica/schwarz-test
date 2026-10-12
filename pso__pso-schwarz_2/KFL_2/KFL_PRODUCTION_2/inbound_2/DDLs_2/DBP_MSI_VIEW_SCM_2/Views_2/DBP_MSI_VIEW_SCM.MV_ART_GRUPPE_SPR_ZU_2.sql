CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_art_gruppe_spr_zu_2
AS
SELECT
 t0.art_attribut_id AS art_gruppe_id
,TRIM(t1.art_attribut_bez) AS art_gruppe_bez
FROM DBP_VIEW.v_art_gruppe_attribut_zu_2 t0
LEFT JOIN DBP_VIEW.v_art_attribut_spr_zu_2 t1_2
  ON t0.art_attribut_id=t1.art_attribut_id
WHERE t0.art_gruppe_id = 'FL001' 
GROUP BY t0.art_attribut_id
        ,t1.art_attribut_bez
        
UNION

SELECT art_gruppe_id
      ,art_gruppe_bez
FROM (SELECT
             '-'  AS art_gruppe_id
            ,'-/nicht gepflegt / not maintained' AS art_gruppe_bez
     ) t1_2

UNION

SELECT art_gruppe_id
      ,art_gruppe_bez
FROM (SELECT 
             '-1'  AS art_gruppe_id
            ,'Alle Artikelgruppen' AS art_gruppe_bez
     ) t1_2;