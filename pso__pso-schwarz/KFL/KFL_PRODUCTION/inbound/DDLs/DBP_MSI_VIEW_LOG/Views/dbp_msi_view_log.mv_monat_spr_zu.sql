CREATE OR REPLACE VIEW dbp_msi_view_log.mv_monat_spr_zu
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mo_id
,mo_bez
,mo_bez_de
,mo_bez_cz
,mo_bez_sk
,mo_bez_hr
,mo_bez_pl
,mo_bez_ro
,mo_bez_bg
)
AS
SELECT
v01.mo_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.mo_bez END) AS mo_bez             -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.mo_bez END) AS mo_bez_de                      -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN mo_bez END), mo_bez_de) AS mo_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN mo_bez END), mo_bez_de) AS mo_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN mo_bez END), mo_bez_de) AS mo_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN mo_bez END), mo_bez_de) AS mo_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN mo_bez END), mo_bez_de) AS mo_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN mo_bez END), mo_bez_de) AS mo_bez_bg    -- BG

FROM dbp_view.v_monat_spr_zu v01
GROUP BY v01.mo_id;