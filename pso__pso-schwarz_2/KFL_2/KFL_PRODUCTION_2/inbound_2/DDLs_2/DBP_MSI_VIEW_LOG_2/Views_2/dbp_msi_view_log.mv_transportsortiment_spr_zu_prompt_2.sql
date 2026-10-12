CREATE OR REPLACE VIEW dbp_msi_view_log.mv_transportsortiment_spr_zu_prompt_2
-- 04.03.2021, AP0073899 , nwag2310, initial
-- 16.11.2021, AP0073899, dknop, (transportsortiment_id='-1')
--2022-06-07, AP0125093, SPEC0157732, adding Dummy_2 Records for Transportsortiment ID 99, dknop
AS
SELECT
 CAST(v01.lagersortiment_id AS VARCHAR(2)) AS transportsortiment_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez                  -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.lagersortiment_bez END) AS lagersortiment_bez_de                           -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lagersortiment_bez END), lagersortiment_bez_de) AS lagersortiment_bez_bg    -- BG

FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(Trim(v01.lagernummer_id))=4
AND v01.lagersortiment_id NOT IN ('2','5','7')
GROUP BY v01.lagersortiment_id

UNION
SELECT
 '27' AS transportsortiment_id
,'OG / Pflanzen' AS lagersortiment_bez                  -- standard == DE
,'OG / Pflanzen' AS lagersortiment_bez_de                           -- DE
,'F&V / Plants' AS lagersortiment_bez_cz    -- CZ
,'F&V / Plants' AS lagersortiment_bez_sk    -- SK
,'F&V / Plants'AS lagersortiment_bez_hr    -- HR
,'F&V / Plants' AS lagersortiment_bez_pl    -- PL
,'F&V / Plants' AS lagersortiment_bez_ro    -- RO
,'F&V / Plants' AS lagersortiment_bez_bg    -- BG

FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.lagersortiment_id='2'
GROUP BY v01.lagersortiment_id

UNION
SELECT
 '-1' AS transportsortiment_id
,'kein BELOS-Vorgang' AS lagersortiment_bez                  -- standard == DE
,'kein BELOS-Vorgang' AS lagersortiment_bez_de                           -- DE
,'no BELOS data' AS lagersortiment_bez_cz    -- CZ
,'no BELOS data' AS lagersortiment_bez_sk    -- SK
,'no BELOS data'AS lagersortiment_bez_hr    -- HR
,'no BELOS data' AS lagersortiment_bez_pl    -- PL
,'no BELOS data' AS lagersortiment_bez_ro    -- RO
,'no BELOS data' AS lagersortiment_bez_bg    -- BG


FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.lagersortiment_id='2'
GROUP BY v01.lagersortiment_id

UNION
SELECT
 '99' AS transportsortiment_id
,'Transportsortiment nicht eindeutig' AS lagersortiment_bez                  -- standard == DE
,'Transportsortiment nicht eindeutig' AS lagersortiment_bez_de                           -- DE
,'Transportation assortment not unique' AS lagersortiment_bez_cz    -- CZ
,'Transportation assortment not unique' AS lagersortiment_bez_sk    -- SK
,'Transportation assortment not unique'AS lagersortiment_bez_hr    -- HR
,'Transportation assortment not unique' AS lagersortiment_bez_pl    -- PL
,'Transportation assortment not unique' AS lagersortiment_bez_ro    -- RO
,'Transportation assortment not unique' AS lagersortiment_bez_bg    -- BG


FROM dbp_view.v_lagersortiment_spr_zu_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.lagersortiment_id='2'
GROUP BY v01.lagersortiment_id;