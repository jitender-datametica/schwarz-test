CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_turnover_net_sap AS SELECT -- store_map.cost_center as cost_center,

 STORE_MAP.orig_store_nr AS store_nr,
 ROUND(CAST(MP.cy_month AS BIGNUMERIC), 0) AS cy_month,
 SUM(COALESCE(SAP_NET_TURNOVER.turnover_net, 0) * - 1) AS turnover_net
FROM ldl_s_conl_workbench.t_i_turnover_net_sap AS SAP_NET_TURNOVER
 INNER JOIN ldl_s_conl_workbench.t_m_month_periode AS MP ON CASE
   WHEN CAST(SAP_NET_TURNOVER.booking_periode AS FLOAT64) <= 9
   THEN SAP_NET_TURNOVER.booking_year || '0' || SAP_NET_TURNOVER.booking_periode
   ELSE SAP_NET_TURNOVER.booking_year || SAP_NET_TURNOVER.booking_periode
   END = MP.by_period
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all AS STORE_MAP ON CASE
   WHEN STRPOS(SAP_NET_TURNOVER.cost_center, 'ECD01') <> 0 OR STRPOS(SAP_NET_TURNOVER.cost_center, 'ECG02') <> 0 OR
       STRPOS(SAP_NET_TURNOVER.cost_center, 'EC001') <> 0 OR STRPOS(SAP_NET_TURNOVER.cost_center, 'EC002') <> 0 OR
     STRPOS(SAP_NET_TURNOVER.cost_center, 'EC003') <> 0
   THEN 'ECD01'
   WHEN LENGTH(TRIM(SAP_NET_TURNOVER.cost_center)) = 5
   THEN RIGHT(TRIM(SAP_NET_TURNOVER.cost_center), 3)
   WHEN LENGTH(TRIM(SAP_NET_TURNOVER.cost_center)) = 6
   THEN RIGHT(TRIM(SAP_NET_TURNOVER.cost_center), 6)
   ELSE NULL
   END = STORE_MAP.cost_center
GROUP BY store_nr,
 MP.cy_month;