CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_SPR_ZU
AS
/* SPRACHE Abschriftart Int */
-- 2017.0223 : Initial
-- 2021-11-18 : Updated for Snowflake

SELECT
  v01.abschriftart_int_id
/* ALIASES */
, TRIM(v01.abschriftart_int_id) AS abschriftart
, MAX(CASE WHEN spr_id =  22 THEN abschriftart_int_bez ELSE 'AKZ ' || abschriftart END) AS abschriftart_int_bez_de 

, abschriftart_int_bez_de                                                                      AS abschriftart_int_bez
, COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_cz
, COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_sk
, COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_hr
, COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_pl
, COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_ro
, COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bez_bg

, abschriftart || ' ' || abschriftart_int_bez_de                                                                      AS abschriftart_int
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_cz
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_sk
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_hr
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_pl
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_ro
, abschriftart || ' ' || COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschriftart_int_bez END), abschriftart_int_bez_de) AS abschriftart_int_bg

FROM dbp_view.v_abschriftart_int_spr_zu  v01

GROUP BY
v01.abschriftart_int_id;