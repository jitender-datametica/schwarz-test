CREATE OR REPLACE VIEW dbp_msi_view_log.mv_verkaufsorganisation_spr_zu -- 13.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 mandant_id
,verkaufsorganisation_id
,verkaufsorganisation_bez
,verkaufsorganisation_bez_de
,verkaufsorganisation_bez_cz
,verkaufsorganisation_bez_sk
,verkaufsorganisation_bez_hr
,verkaufsorganisation_bez_pl
,verkaufsorganisation_bez_ro
,verkaufsorganisation_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.verkaufsorganisation_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.verkaufsorganisation_bez END) AS verkaufsorganisation_bez                                   -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.verkaufsorganisation_bez END) AS verkaufsorganisation_bez_de                                            -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.verkaufsorganisation_bez END), verkaufsorganisation_bez_de) AS verkaufsorganisation_bez_bg    -- BG

FROM dbp_view.v_verkaufsorganisation_spr_zu v01
GROUP BY v01.mandant_id
        ,v01.verkaufsorganisation_id;
