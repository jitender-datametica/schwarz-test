CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ORDER_TIMES_WH_1
(
    country_lidl_cd
   ,wh_id
   ,range_zone_id
   ,range_desc
)
AS
   SELECT
   clnt.src_country_lidl_cd     AS country_lidl_cd,
   loc.src_wh_id                AS wh_id,
   drw.src_range_zone_id        AS range_zone_id,
   drw.order_time_range_name    AS range_desc
   FROM p_lew_core_ac.v_warehouse_order_time_range_1 AS drw
   INNER JOIN p_lew_core_ac.v_location_1  AS loc
   ON  drw.loc_sid_wh = loc.loc_sid
   AND drw.client_id = loc.client_id
   INNER JOIN p_lew_core_ac.v_client_1 AS clnt
   ON drw.client_id = clnt.client_id
;