CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wg_verkettung_spr_zu_prompt --28.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage
--29.01.2021, SPEC0097379, AP0069430, dknop, replacing with new solution
(
 wg_verkett_id
,wg_verkett_bez
,wg_verkett_bez_de
,wg_verkett_bez_cz
,wg_verkett_bez_sk
,wg_verkett_bez_hr
,wg_verkett_bez_pl
,wg_verkett_bez_ro
,wg_verkett_bez_bg
)
AS
SELECT
v01.wg_verkett_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wg_verkett_bez END) AS wg_verkett_bez                        -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.wg_verkett_bez END) AS wg_verkett_bez_de                                  -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.wg_verkett_bez END), wg_verkett_bez_de) AS wg_verkett_bez_bg    -- BG

FROM dbp_view.v_wg_verkettung_spr_zu v01
GROUP by v01.mandant_id
        ,v01.wg_verkett_id

-- Dummy records for noch available ID within movement data records

UNION

SELECT
TO_NUMBER('-2') AS wg_verkett_id,
'n/a' AS wg_verkett_bez,
'n/a' AS wg_verkett_bez_de,
'n/a' AS wg_verkett_bez_cz,
'n/a' AS wg_verkett_bez_sk,
'n/a' AS wg_verkett_bez_hr,
'n/a' AS wg_verkett_bez_pl,
'n/a' AS wg_verkett_bez_ro,
'n/a' AS wg_verkett_bez_bg
FROM dbp_view.v_mandant v02;
