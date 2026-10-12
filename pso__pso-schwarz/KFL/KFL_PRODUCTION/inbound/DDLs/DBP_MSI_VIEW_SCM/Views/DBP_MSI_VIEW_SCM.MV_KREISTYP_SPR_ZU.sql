CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_kreistyp_spr_zu
-- 12.08.2021, srom0404, AP0098488, SPEC0121102 - Reichweitenliste
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy Werte fuer DE
AS
SELECT DISTINCT
 v01.mandant_id
,v01.kreistyp_id
, MAX(CASE WHEN spr_id =  22 THEN kreistyp_bez END) AS kreistyp_bez                      -- standard == DE
, MAX(CASE WHEN spr_id =  22 THEN kreistyp_bez END) AS kreistyp_bez_de                               -- DE
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN kreistyp_bez END), kreistyp_bez_de) AS kreistyp_bez_bg    -- BG
FROM DBP_VIEW.v_kreistyp_spr_zu v01

GROUP BY v01.mandant_id
        ,v01.kreistyp_id
        
UNION ALL 

SELECT 
 v02.mandant_id
,v02.kreistyp_id
,v02.kreistyp_bez
,v02.kreistyp_bez_de
,v02.kreistyp_bez_cz
,v02.kreistyp_bez_sk
,v02.kreistyp_bez_hr
,v02.kreistyp_bez_pl
,v02.kreistyp_bez_ro
,v02.kreistyp_bez_bg
FROM (SELECT 1 AS mandant_id
            ,'' AS kreistyp_id
            ,'leer/empty' AS kreistyp_bez
            ,'leer/empty' AS kreistyp_bez_de
            ,'leer/empty' AS kreistyp_bez_cz
            ,'leer/empty' AS kreistyp_bez_sk
            ,'leer/empty' AS kreistyp_bez_hr
            ,'leer/empty' AS kreistyp_bez_pl
            ,'leer/empty' AS kreistyp_bez_ro
            ,'leer/empty' AS kreistyp_bez_bg
     ) v02;