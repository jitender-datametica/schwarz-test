CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wug_spr_zu_2 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 arthiertyp_id
,wg_id
,wug_id
,wug_bez
,wug_bez_de
,wug_bez_cz
,wug_bez_sk
,wug_bez_hr
,wug_bez_pl
,wug_bez_ro
,wug_bez_bg
)
AS
SELECT
v01.arthiertyp_id,
v01.wg_id,
v01.wug_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wug_bez END) AS wug_bez              -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wug_bez END) AS wug_bez_de                       -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN wug_bez END), wug_bez_de) AS wug_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN wug_bez END), wug_bez_de) AS wug_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN wug_bez END), wug_bez_de) AS wug_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN wug_bez END), wug_bez_de) AS wug_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN wug_bez END), wug_bez_de) AS wug_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN wug_bez END), wug_bez_de) AS wug_bez_bg    -- BG

FROM dbp_view.v_wug_spr_zu_2 v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.wg_id
        ,v01.wug_id;
