CREATE OR REPLACE VIEW dbp_msi_view_log.mv_belos_tourart_spr_zu_prompt_2
--02.03.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_2
AS
SELECT

v01.belos_tourart_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.belos_tourart_bez END) AS belos_tourart_bez                        -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.belos_tourart_bez END) AS belos_tourart_bez_de                                 -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_b
FROM dbp_view.v_belos_tourart_spr_zu_2 v01

group by v01.belos_tourart_id;
