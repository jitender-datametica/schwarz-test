CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lager_bewart_spr_zu_1 -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 mandant_id
,lager_bewart_id
,lager_bewart_bez
,lager_bewart_bez_de
,lager_bewart_bez_cz
,lager_bewart_bez_sk
,lager_bewart_bez_hr
,lager_bewart_bez_pl
,lager_bewart_bez_ro
,lager_bewart_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.lager_bewart_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lager_bewart_bez END) AS lager_bewart_bez                           -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.lager_bewart_bez END) AS lager_bewart_bez_de                                    -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_bg    -- BG

FROM dbp_view.v_lager_bewart_spr_zu_1 v01
--keine Berücksichtigung der SAP-Industriesysteme für DE + CZ		
WHERE v01.system_id NOT IN (2,17,28,32,48,53)
GROUP BY v01.mandant_id
,v01.lager_bewart_id;
