CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lager_bewart_typ_spr_zu_hist_2 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,lager_bewart_typ_id
,hist_fg
,lager_bewart_typ_bez
,lager_bewart_typ_bez_de
,lager_bewart_typ_bez_cz
,lager_bewart_typ_bez_sk
,lager_bewart_typ_bez_hr
,lager_bewart_typ_bez_pl
,lager_bewart_typ_bez_ro
,lager_bewart_typ_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.lager_bewart_typ_id,
Max(v01.hist_fg) AS hist_fg,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lager_bewart_typ_bez END) AS lager_bewart_typ_bez                               -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lager_bewart_typ_bez END) AS lager_bewart_typ_bez_de                                        -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.lager_bewart_typ_bez END), lager_bewart_typ_bez_de) AS lager_bewart_typ_bez_bg    -- BG

FROM dbp_view.v_lager_bewart_typ_spr_zu_2 v01
WHERE v01. hist_fg = 1
GROUP BY v01.mandant_id
        ,v01.lager_bewart_typ_id;
