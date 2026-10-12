CREATE OR REPLACE VIEW dbp_msi_view_log.mv_bestellart_spr_zu_prompt -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 bestellart_id
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

FROM dbp_view.v_bestellart_spr_zu v01
GROUP BY v01.bestellart_id

-- Dummy records for noch available ID within movement data records
UNION

SELECT
v02.bestellart_id,
v02.bestellart_bez,
v02.bestellart_bez_de,
v02.bestellart_bez_cz,
v02.bestellart_bez_sk,
v02.bestellart_bez_hr,
v02.bestellart_bez_pl,
v02.bestellart_bez_ro,
v02.bestellart_bez_bg
FROM
(SELECT
'-2' AS bestellart_id,
'n/a' AS bestellart_bez,
'n/a' AS bestellart_bez_de,
'n/a' AS bestellart_bez_cz,
'n/a' AS bestellart_bez_sk,
'n/a' AS bestellart_bez_hr,
'n/a' AS bestellart_bez_pl,
'n/a' AS bestellart_bez_ro,
'n/a' AS bestellart_bez_bg
) v02;
