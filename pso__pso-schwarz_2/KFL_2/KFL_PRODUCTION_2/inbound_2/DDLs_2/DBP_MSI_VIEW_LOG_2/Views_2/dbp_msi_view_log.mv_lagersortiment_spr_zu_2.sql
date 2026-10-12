CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagersortiment_spr_zu_2
AS
-- 20.11.2020, AP0063967, SPEC0090556 | nwag2310 added add. record for assortment 0 
-- 12.01.2021, AP0063967, SPEC0090556 | nwag2310 added filter on EWM Lagernummer
-- 15.07.2021, AP0079230 | nwag2310 added artificaial records for assortment 0 + 9
-- 01.02.2022, dknop, v01.wup_id>0
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.lagernummer_id,
v01.lagersortiment_id,
MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez                  -- standard == DE
, MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez_de                           -- DE
, COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_bg    -- BGFROM dbp_view.v_lagersortiment_spr_zu_2 v01
FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.wup_id>0
GROUP BY  v01.mandant_id
         ,v01.wup_id
         ,v01.nb_id
         ,v01.lagernummer_id
         ,v01.lagersortiment_id -- 03.11.2020, AP0063967, SPEC0090556
UNION ALL
-- utilizing existing records for assortment 1 as 0 (not defined) / assortment 2 as 9 (empties)
SELECT 
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.lagernummer_id
,CASE WHEN v01.lagersortiment_id = 1 THEN '0' WHEN v01.lagersortiment_id =2 THEN '9' END  AS lagersortiment_id
,CASE WHEN v01.lagersortiment_id = 1 THEN 'nicht definiert' WHEN v01.lagersortiment_id =2 THEN 'Leergut' END AS lagersortiment_bez                  -- standard == DE
,CASE WHEN v01.lagersortiment_id = 1 THEN 'nicht definiert' WHEN v01.lagersortiment_id =2 THEN 'Leergut' END AS lagersortiment_bez_de                           -- DE
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_cz    -- CZ
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_sk    -- SK
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_hr    -- HR
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_pl    -- PL
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_ro    -- RO
,CASE WHEN v01.lagersortiment_id = 1 THEN 'not defined' WHEN v01.lagersortiment_id =2 THEN 'Empties' END AS lagersortiment_bez_bg    -- BG
FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' ) AND v01.lagersortiment_id IN ('1','2')
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.wup_id>0
GROUP BY  v01.mandant_id
         ,v01.wup_id
         ,v01.nb_id
         ,v01.lagernummer_id
         ,v01.lagersortiment_id
;