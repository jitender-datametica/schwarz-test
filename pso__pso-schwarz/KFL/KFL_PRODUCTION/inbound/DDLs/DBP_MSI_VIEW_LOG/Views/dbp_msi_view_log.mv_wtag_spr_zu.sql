CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wtag_spr_zu -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 wtag_id
,wtag_bez
,wtag_bez_de
,wtag_bez_cz
,wtag_bez_sk
,wtag_bez_hr
,wtag_bez_pl
,wtag_bez_ro
,wtag_bez_bg
)
AS
SELECT
v01.wtag_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wtag_bez END) AS wtag_bez               -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wtag_bez END) AS wtag_bez_de                        -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN wtag_bez END), wtag_bez_de) AS wtag_bez_bg    -- BG

FROM dbp_view.v_wtag_spr_zu v01
GROUP BY v01.wtag_id;
