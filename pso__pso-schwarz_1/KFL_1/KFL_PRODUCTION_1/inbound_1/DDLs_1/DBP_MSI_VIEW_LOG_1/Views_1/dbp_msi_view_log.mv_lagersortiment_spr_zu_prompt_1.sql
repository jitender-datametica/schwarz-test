CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagersortiment_spr_zu_prompt_1
-- 20201.01.22, AP0063967, SPEC0090556, srom0404, initial
-- 2021.07.20, AP0079230, dknop, added artificaial records for assortment 0 + 9
AS
SELECT
v01.lagersortiment_id,
Max(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez                  -- standard == DE
, Max(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez_de                           -- DE
, Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_cz    -- CZ
, Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_sk    -- SK
, Coalesce(Max(CASE WHEN v01.spr_id =  65 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_hr    -- HR
, Coalesce(Max(CASE WHEN v01.spr_id =  90 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_pl    -- PL
, Coalesce(Max(CASE WHEN v01.spr_id =  95 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_ro    -- RO
, Coalesce(Max(CASE WHEN v01.spr_id =  18 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_bg    -- BG
FROM dbp_view.v_lagersortiment_spr_zu_1 v01
WHERE LEFT(v01.lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
GROUP BY  
         v01.lagersortiment_id 
UNION ALL
-- utilizing existing records for assortment 1 as 0 (not defined) / assortment 2 as 9 (empties)
SELECT 
CASE WHEN v01.lagersortiment_id = 1 THEN '0' WHEN v01.lagersortiment_id =2 THEN '9' END  AS lagersortiment_id
,CASE WHEN v01.lagersortiment_id = 1 THEN 'nicht definiert' WHEN v01.lagersortiment_id =2 THEN 'Leergut' END AS lagersortiment_bez                  -- standard == DE
,CASE WHEN v01.lagersortiment_id = 1 THEN 'nicht definiert' WHEN v01.lagersortiment_id =2 THEN 'Leergut' END AS lagersortiment_bez_de                           -- DE
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_cz    -- CZ
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_sk    -- SK
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_hr    -- HR
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_pl    -- PL
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_ro    -- RO
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_bg    -- BG
FROM dbp_view.v_lagersortiment_spr_zu_1 v01
WHERE LEFT(v01.lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' ) AND v01.lagersortiment_id IN ('1','2')
AND LENGTH(TRIM(v01.lagernummer_id))=4
GROUP BY  
         v01.lagersortiment_id
;