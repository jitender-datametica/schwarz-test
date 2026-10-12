CREATE OR REPLACE VIEW s_conl_workbench.v_mstr_mis_store_2
AS
(SELECT
'Nederland' as Land_2,
store_map.store_nr as Filialnummer,
store_map.store_name as Filialname,
store_map.wh_id as GES_Nummer,
store_map.wh_name as GES_Name,
store_map.account_manager_name as Vertriebsleiter,
store_map.sales_manager_name as Verkaufsleiter,
store_map.longitude as lengtegraad,
store_map.latitude  as breedtegraad,
-- Verkaufsfläche
store_map.dat_opening_ovis as Eroeffnungsdatum,
store_map.dat_closing_ovis as "Schließungsdatum",
cal.cy as Kalenderjahr,
cal.byr as Geschaeftsjahr,
cal.month_id as Monat_Nr,
cal.cy_month as Monat_GJ,
lj_om_kl.turnover as Omzet_LJ,
vj_om_kl.turnover as Omzet_VJ,
lj_om_kl.customer as Klanten_LJ,
vj_om_kl.customer as Klanten_VJ,
lj_ber.ber_turnover_cy as Umsatz_Bereinigt_LJ,
vj_ber.ber_turnover_py as Umsatz_Bereinigt_VJ,
lj_ber.ber_customer_cy as Kunden_Bereinigt_LJ,
vj_ber.ber_customer_py as Kunden_Bereinigt_VJ,
lj_net_h.hours_net as Nettouren_LJ,
vj_net_h.hours_net as Nettouren_VJ,
lj_sap.turnover_net as Omzet_SAP_LJ,
vj_sap.turnover_net as Omzet_SAP_VJ
FROM s_conl_workbench.v_mis_turnover_customer_2 as lj_om_kl
INNER JOIN s_conl_workbench.v_m_cost_center_store_2 as store_map
ON lj_om_kl.store_id = store_map.store_id
LEFT JOIN s_conl_workbench.v_mis_net_hours_2 as lj_net_h
ON  lj_om_kl.store_id = lj_net_h.store_id
AND lj_om_kl.cy_month = lj_net_h.cy_month
INNER JOIN s_conl.v_cal_month_2 as cal
ON lj_om_kl.cy_month = cal.cy_month
LEFT JOIN s_conl_workbench.v_mis_turnover_customer_2 as vj_om_kl
ON lj_om_kl.store_id = vj_om_kl.store_id
AND vj_om_kl.cy_month = cal.prev_cy_month
LEFT JOIN s_conl_workbench.v_mis_net_hours_2 as vj_net_h
ON lj_net_h.store_id = vj_net_h.store_id
AND vj_net_h.cy_month = cal.prev_cy_month
LEFT JOIN s_conl_workbench.v_mis_ber_turnover_customer_2 as lj_ber
ON lj_om_kl.client_id = lj_ber.client_id
AND lj_om_kl.store_id = lj_ber.store_id
AND lj_om_kl.cy_month = lj_ber.cy_month
LEFT JOIN s_conl_workbench.v_mis_ber_turnover_customer_2 as vj_ber
ON lj_om_kl.client_id = vj_ber.client_id
AND lj_om_kl.store_id = vj_ber.store_id
AND cal.prev_cy_month = vj_ber.cy_month
LEFT JOIN s_conl_workbench.v_turnover_net_sap_2  as lj_sap
ON CAST(store_map.store_nr as VARCHAR(25)) = lj_sap.store_nr
AND lj_om_kl.cy_month = lj_sap.cy_month
LEFT JOIN s_conl_workbench.v_turnover_net_sap_2  as vj_sap
ON CAST(store_map.store_nr as VARCHAR(25)) = vj_sap.store_nr
AND cal.prev_cy_month  = vj_sap.cy_month
WHERE lj_om_kl.cy_month >= 201803
AND store_map.mis_store_active_fg = 1
AND lj_om_kl.turnover > 100
		--AND Monat_GJ <= (SELECT MAX(Monat_GJ) FROM s_conl_workbench.v_mstr_cost_store_2)

)
;


