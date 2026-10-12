CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wg_spr_zu_1 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 arthiertyp_id
,wg_id
,wg_bez
,wg_bez_de
,wg_bez_cz
,wg_bez_sk
,wg_bez_hr
,wg_bez_pl
,wg_bez_ro
,wg_bez_bg
)
AS
SELECT DISTINCT
v01.arthiertyp_id,
v01.wg_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wg_bez END) AS wg_bez                 -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wg_bez END) AS wg_bez_de                          -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.wg_bez END), wg_bez_de) AS wg_bez_bg    -- BG

FROM dbp_view.v_wg_spr_zu_1 v01
WHERE  v01.arthiertyp_id = 2
AND v01.wg_id >= -3
GROUP BY v01.arthiertyp_id
       ,v01.wg_id;
