CREATE OR REPLACE VIEW dbp_msi_view_log.MV_NACHSCHUB_OPTION_SPR_ZU_2
-- 2021-03-29, dknop, SPEC0107644, AP0081632, initial
-- 2021-07-09, dknop, SPEC0107644, AP0081632, adding empty value
AS 
SELECT 
 cast(v01.nachschub_option_id as char(2)) as nachschub_option_id
,Max(CASE WHEN v01.spr_id = 22 THEN v01.nachschub_option_bez END) AS nachschub_option_bez                      -- standard == DE
,Max(CASE WHEN v01.spr_id = 22 THEN v01.nachschub_option_bez END) AS nachschub_option_bez_de                                  -- DE
,Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_cz    -- CZ
,Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_sk    -- SK
,Coalesce(Max(CASE WHEN v01.spr_id =  65 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_hr    -- HR
,Coalesce(Max(CASE WHEN v01.spr_id =  90 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_pl    -- PL
,Coalesce(Max(CASE WHEN v01.spr_id =  95 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_ro    -- RO
,Coalesce(Max(CASE WHEN v01.spr_id =  18 THEN v01.nachschub_option_bez END),nachschub_option_bez_de) AS nachschub_option_bez_bg    -- BG
FROM dbp_view.v_nachschub_option_spr_zu_2 v01
GROUP BY v01.nachschub_option_id
UNION
SELECT
0 AS nachschub_option_id,
'' AS nachschub_option_bez,
'' AS nachschub_option_bez_de,
'' AS nachschub_option_bez_cz,
'' AS nachschub_option_bez_sk,
'' AS nachschub_option_bez_hr,
'' AS nachschub_option_bez_pl,
'' AS nachschub_option_bez_ro,
'' AS nachschub_option_bez_bg
FROM dbp_view.v_nachschub_option_spr_zu_2;