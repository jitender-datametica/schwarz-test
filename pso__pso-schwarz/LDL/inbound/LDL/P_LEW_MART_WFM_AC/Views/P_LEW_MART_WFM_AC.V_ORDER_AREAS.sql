CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ORDER_AREAS
(
    country_lidl_cd
   ,wh_id
   ,order_area_cd
   ,order_area_descr
)
AS
SELECT
country_lidl_cd,
wh_id,
order_area_cd,
order_area_descr
FROM p_lew_mart_wfm.v_order_areas
;




