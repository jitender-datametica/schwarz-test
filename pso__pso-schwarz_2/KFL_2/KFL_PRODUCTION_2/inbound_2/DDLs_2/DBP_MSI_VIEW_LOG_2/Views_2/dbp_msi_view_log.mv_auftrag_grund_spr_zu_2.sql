CREATE OR REPLACE VIEW dbp_msi_view_log.mv_auftrag_grund_spr_zu_2 -- 06.07.2020, AP0053509, SPEC0071753, mcie1607, initiale Anlage_2

AS
SELECT
v01.mandant_id,
v01.auftrag_grund_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.auftrag_grund_bez END) AS auftrag_grund_bez                         -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.auftrag_grund_bez END) AS auftrag_grund_bez_de                               -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.auftrag_grund_bez END), auftrag_grund_bez_de ) AS auftrag_grund_bez_bg    -- BG

FROM dbp_view.v_auftrag_grund_spr_zu_2 v01
GROUP BY v01.mandant_id
        ,v01.auftrag_grund_id;
