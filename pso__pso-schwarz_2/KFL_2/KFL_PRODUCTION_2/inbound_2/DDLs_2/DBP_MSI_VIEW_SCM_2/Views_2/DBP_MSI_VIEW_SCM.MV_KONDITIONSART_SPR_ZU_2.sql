CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_konditionsart_spr_zu_2
--AP0048505 Initial 
-- 19.07.2021 sanadze (Mayko): SPEC0106469 erstellt auf Snowflake
AS
SELECT DISTINCT
 v01.mandant_id
, v01.konditionsart_id
, v01.system_id
, MAX(CASE WHEN spr_id =  22 THEN konditionsart_bez END) AS konditionsart_bez                 -- standard == DE
, MAX(CASE WHEN spr_id =  22 THEN konditionsart_bez END) AS konditionsart_bez_de                          -- DE
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN konditionsart_bez END), konditionsart_bez_de) AS konditionsart_bez_bg    -- BG
FROM  dbp_view.v_konditionsart_spr_zu_2  v01

GROUP BY
 v01.mandant_id
, v01.konditionsart_id
, v01.system_id;