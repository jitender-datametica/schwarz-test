CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerbereich_spr_zu_1 -- 09.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 mandant_id
,wup_id
,nb_id
,lagernummer_id
,lagertyp_id
,lagerbereich_id
,lagerbereich_bez
,lagerbereich_bez_de
,lagerbereich_bez_cz
,lagerbereich_bez_sk
,lagerbereich_bez_hr
,lagerbereich_bez_pl
,lagerbereich_bez_ro
,lagerbereich_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.lagernummer_id,
v01.lagertyp_id,
v01.lagerbereich_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lagerbereich_bez END) AS lagerbereich_bez,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lagerbereich_bez END) AS lagerbereich_bez_de,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.lagerbereich_bez END), lagerbereich_bez_de) AS lagerbereich_bez_bg    -- BG

FROM dbp_view.v_lagerbereich_spr_zu_1 v01
GROUP BY v01.mandant_id
        ,v01.wup_id
        ,v01.nb_id
        ,v01.lagernummer_id
        ,v01.lagertyp_id
        ,v01.lagerbereich_id;
