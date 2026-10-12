CREATE OR REPLACE VIEW dbp_msi_view_log.mv_aktivitaetsbereich_spr_zu_2
-- 18.09.2020, AP0064865, SPEC0085770, baranowska, create view
(
 mandant_id
,aktivitaetsbereich_id
,aktivitaetsbereich_bez
,aktivitaetsbereich_bez_de
,aktivitaetsbereich_bez_cz
,aktivitaetsbereich_bez_sk
,aktivitaetsbereich_bez_hr
,aktivitaetsbereich_bez_pl
,aktivitaetsbereich_bez_ro
,aktivitaetsbereich_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.aktivitaetsbereich_id,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.aktivitaetsbereich_bez END) AS aktivitaetsbereich_bez                 -- standard == DE
,
Max(CASE
WHEN v01.spr_id =  22 THEN v01.aktivitaetsbereich_bez END) AS aktivitaetsbereich_bez_de                          -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.aktivitaetsbereich_bez END), aktivitaetsbereich_bez_de) AS aktivitaetsbereich_bez_bg    -- BG

FROM dbp_view.v_aktivitaetsbereich_spr_zu_2 v01
GROUP BY v01.mandant_id
        ,v01.aktivitaetsbereich_id;
