CREATE OR REPLACE VIEW dbp_msi_view_log.mv_hwg_spr_zu_1 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 arthiertyp_id
,hwg_id
,hwg_bez
,hwg_bez_de
,hwg_bez_cz
,hwg_bez_sk
,hwg_bez_hr
,hwg_bez_pl
,hwg_bez_ro
,hwg_bez_bg
)
AS
SELECT
v01.arthiertyp_id,
v01.hwg_id,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.hwg_bez END) AS hwg_bez                 -- standard == DE
,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.hwg_bez END) AS hwg_bez_de                           --DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.hwg_bez END), hwg_bez_de) AS hwg_bez_bg    -- BG

FROM dbp_view.v_hwg_spr_zu_1  v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.hwg_id;
