CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_kreistyp_gruppe_spr_zu
-- AP0048505 Initial 
-- 12.08.2021, srom0404, AP0098488, SPEC0121102 - Reichweitenliste
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy Werte für Laender, die noch nicht in l_kreistyp_gruppe sind
AS
SELECT DISTINCT
 v01.mandant_id
,v01.kreistyp_gruppe_id
, MAX(CASE WHEN spr_id =  22 THEN kreistyp_gruppe_bez END) AS kreistyp_gruppe_bez                 -- standard == DE
, MAX(CASE WHEN spr_id =  22 THEN kreistyp_gruppe_bez END) AS kreistyp_gruppe_bez_de                          -- DE
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_bg    -- BG
FROM DBP_VIEW.v_kreistyp_gruppe_spr_zu v01

GROUP BY
 v01.mandant_id
, v01.kreistyp_gruppe_id

UNION ALL

SELECT v02.mandant_id
      ,'' AS kreistyp_id
      ,'leer/empty' kreistyp_gruppe_bez
      ,'leer/empty' kreistyp_gruppe_bez_de
      ,'leer/empty' kreistyp_gruppe_bez_cz
      ,'leer/empty' kreistyp_gruppe_bez_sk
      ,'leer/empty' kreistyp_gruppe_bez_hr
      ,'leer/empty' kreistyp_gruppe_bez_pl
      ,'leer/empty' kreistyp_gruppe_bez_ro
      ,'leer/empty' kreistyp_gruppe_bez_bg
FROM DBP_VIEW.v_mandant v02
WHERE v02.mandant_id NOT IN (SELECT mandant_id FROM DBP_VIEW.v_l_kreistyp_gruppe WHERE kreistyp_gruppe_id = '');