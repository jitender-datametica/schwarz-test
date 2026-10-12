CREATE OR REPLACE VIEW s_conl_workbench.v_turnover_net_sap_2
AS
(SELECT
--store_map.cost_center as cost_center,
store_map.orig_store_nr as store_nr,
TO_NUMBER(mp.cy_month) as cy_month,
sum(coalesce(sap_net_turnover.turnover_net,0)*(-1)) as turnover_net
FROM s_conl_workbench.t_i_turnover_net_sap_2 as sap_net_turnover
INNER JOIN s_conl_workbench.t_m_month_periode_2 as mp
ON (CASE
WHEN sap_net_turnover.booking_periode<=9 THEN sap_net_turnover.booking_year||'0'||sap_net_turnover.booking_periode
ELSE sap_net_turnover.booking_year||sap_net_turnover.booking_periode END) = mp.by_period
LEFT JOIN s_conl_workbench.v_m_cost_center_all_2 as store_map
ON CASE
WHEN (
(CONTAINS(sap_net_turnover.cost_center, 'ECD01')) OR
(CONTAINS(sap_net_turnover.cost_center, 'ECG02')) OR
(CONTAINS(sap_net_turnover.cost_center, 'EC001')) OR
(CONTAINS(sap_net_turnover.cost_center, 'EC002')) OR
(CONTAINS(sap_net_turnover.cost_center, 'EC003'))
) THEN 'ECD01'
WHEN length(trim(sap_net_turnover.cost_center)) = 5 THEN right(trim(sap_net_turnover.cost_center), 3)
WHEN length(trim(sap_net_turnover.cost_center)) = 6 THEN right(trim(sap_net_turnover.cost_center), 6) END  =store_map.cost_center
group by
	store_map.orig_store_nr,
	mp.cy_month
);


