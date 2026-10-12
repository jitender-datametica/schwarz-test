CREATE OR REPLACE VIEW dbp_msi_view_log.mv_brand_abschnitt_spr_zu_2 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2

(
 mandant_id
,lagernummer_id
,brand_abschnitt_id
,brand_abschnitt_bez
,brand_abschnitt_bez_de
,brand_abschnitt_bez_cz
,brand_abschnitt_bez_sk
,brand_abschnitt_bez_hr
,brand_abschnitt_bez_pl
,brand_abschnitt_bez_ro
,brand_abschnitt_bez_bg
)
AS
SELECT
v01.mandant_id,
v01.lagernummer_id,
v01.brand_abschnitt_id,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.brand_abschnitt_bez END) AS brand_abschnitt_bez                               -- standard == DE
,
Max(CASE
WHEN v01.spr_id = 22 THEN v01.brand_abschnitt_bez END) AS brand_abschnitt_bez_de                                        -- DE
,
Coalesce(Max(CASE
WHEN v01.spr_id = 124 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_cz    -- CZ
,
Coalesce(Max(CASE
WHEN v01.spr_id = 108 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_sk    -- SK
,
Coalesce(Max(CASE
WHEN v01.spr_id =  65 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v01.spr_id =  90 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v01.spr_id =  95 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_ro    -- RO
,
Coalesce(Max(CASE
WHEN v01.spr_id =  18 THEN v01.brand_abschnitt_bez END), brand_abschnitt_bez_de ) AS brand_abschnitt_bez_bg    -- BG

FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01
GROUP BY v01.mandant_id
      ,v01.lagernummer_id
      ,v01.brand_abschnitt_id

UNION
SELECT
v01.mandant_id,
v01.lagernummer_id,
'-1'brand_abschnitt_id,
'system generated' AS brand_abschnitt_bez,
'system generated' AS brand_abschnitt_bez_de,
'system generated' AS brand_abschnitt_bez_cz,
'system generated' AS brand_abschnitt_bez_sk,
'system generated' AS brand_abschnitt_bez_hr,
'system generated' AS brand_abschnitt_bez_pl,
'system generated' AS brand_abschnitt_bez_ro,
'system generated' AS brand_abschnitt_bez_bg
FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01

UNION
SELECT
v01.mandant_id,
v01.lagernummer_id,
'  'brand_abschnitt_id,
'system generated' AS brand_abschnitt_bez,
'system generated' AS brand_abschnitt_bez_de,
'system generated' AS brand_abschnitt_bez_cz,
'system generated' AS brand_abschnitt_bez_sk,
'system generated' AS brand_abschnitt_bez_hr,
'system generated' AS brand_abschnitt_bez_pl,
'system generated' AS brand_abschnitt_bez_ro,
'system generated' AS brand_abschnitt_bez_bg
FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01;
