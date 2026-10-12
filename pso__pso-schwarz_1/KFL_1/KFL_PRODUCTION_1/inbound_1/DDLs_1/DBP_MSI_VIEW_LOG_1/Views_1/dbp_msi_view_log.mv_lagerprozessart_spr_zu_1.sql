CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerprozessart_spr_zu_1 -- 18.09.2020, AP0064865, SPEC0085770, baranowska, create view
(
 mandant_id
,lagerprozessart_id
,lagerprozessart_bez
,lagerprozessart_bez_de
,lagerprozessart_bez_cz
,lagerprozessart_bez_sk
,lagerprozessart_bez_hr
,lagerprozessart_bez_pl
,lagerprozessart_bez_ro
,lagerprozessart_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.lagerprozessart_id,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.lagerprozessart_bez END) AS lagerprozessart_bez                 -- standard == DE
,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.lagerprozessart_bez END) AS lagerprozessart_bez_de                          -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_bg    -- BG

FROM dbp_view.v_lagerprozessart_spr_zu_1 v01
GROUP BY v01.mandant_id
        ,v01.lagerprozessart_id;
