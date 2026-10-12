CREATE OR REPLACE VIEW dbp_msi_view_log.mv_bestellart_spr_zu_2 -- 13.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,bestellart_id
,bestellart_bez
,bestellart_bez_de
,bestellart_bez_cz
,bestellart_bez_sk
,bestellart_bez_hr
,bestellart_bez_pl
,bestellart_bez_ro
,bestellart_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.bestellart_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.bestellart_bez END) AS bestellart_bez                         -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.bestellart_bez END) AS bestellart_bez_de                                  -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.bestellart_bez END), bestellart_bez_de) AS bestellart_bez_bg    -- BG

FROM dbp_view.v_bestellart_spr_zu_2 v01
GROUP BY v01.mandant_id
        ,v01.bestellart_id

-- Dummy_2 records for noch available ID within movement data records
UNION

SELECT
v02.mandant_id,
'-2' AS bestellart_id,
'n/a' AS bestellart_bez,
'n/a' AS bestellart_bez_de,
'n/a' AS bestellart_bez_cz,
'n/a' AS bestellart_bez_sk,
'n/a' AS bestellart_bez_hr,
'n/a' AS bestellart_bez_pl,
'n/a' AS bestellart_bez_ro,
'n/a' AS bestellart_bez_bg
FROM dbp_view.v_mandant_2 v02;
