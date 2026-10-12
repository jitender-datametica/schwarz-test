CREATE OR REPLACE VIEW dbp_msi_view_log.mv_owg_spr_zu_2
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 arthiertyp_id
,owg_id
,owg_bez
,owg_bez_de
,owg_bez_cz
,owg_bez_sk
,owg_bez_hr
,owg_bez_pl
,owg_bez_ro
,owg_bez_bg
)
AS
SELECT
v01.arthiertyp_id,
v01.owg_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.owg_bez END) AS owg_bez                  -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.owg_bez END) AS owg_bez_de                           -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_bg    -- BG

FROM dbp_view.v_owg_spr_zu_2 v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.owg_id;