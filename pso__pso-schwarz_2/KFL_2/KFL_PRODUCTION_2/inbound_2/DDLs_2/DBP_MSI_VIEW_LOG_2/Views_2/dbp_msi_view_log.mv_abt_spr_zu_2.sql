CREATE OR REPLACE VIEW dbp_msi_view_log.mv_abt_spr_zu_2 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2

AS
SELECT DISTINCT
v01.arthiertyp_id,
v01.abt_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.abt_bez END) AS abt_bez                  -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.abt_bez END) AS abt_bez_de                           -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.abt_bez END), abt_bez_de) AS abt_bez_bg    -- BG

FROM dbp_view.v_abt_spr_zu_2 v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.abt_id;
