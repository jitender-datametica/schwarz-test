CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lager_bewgrund_spr_zu -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 grund_id
,lager_bewart_id
,mandant_id
,hist_fg
,grund_bez
,grund_bez_de
,grund_bez_cz
,grund_bez_sk
,grund_bez_hr
,grund_bez_pl
,grund_bez_ro
,grund_bez_bg
)
AS
SELECT
v01.grund_id,
v01.lager_bewart_id,
v01.mandant_id,
Max(v01.hist_fg) AS hist_fg,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.grund_bez END) AS grund_bez                    -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.grund_bez END) AS grund_bez_de                             -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.grund_bez END), grund_bez_de) AS grund_bez_bg    -- BG

FROM dbp_view.v_lager_bewgrund_spr_zu v01
WHERE v01.hist_fg = 0
GROUP BY v01.grund_id
        ,v01.lager_bewart_id
        ,v01.mandant_id;
