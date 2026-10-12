CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_spr_zu -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,art_id
,art_bez
,art_bez_de
,art_bez_cz
,art_bez_sk
,art_bez_hr
,art_bez_pl
,art_bez_ro
,art_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.art_id,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.art_bez END) AS art_bez                 -- standard == DE
,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.art_bez END) AS art_bez_de                          -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.art_bez END), art_bez_de) AS art_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.art_bez END), art_bez_de) AS art_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.art_bez END), art_bez_de) AS art_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.art_bez END), art_bez_de) AS art_bez_bg    -- BG

FROM dbp_view.v_art_spr_zu v01
GROUP BY v01.mandant_id
        ,v01.art_id;
