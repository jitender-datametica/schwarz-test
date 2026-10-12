CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mstr_mis_store_2 AS SELECT 'Nederland' AS land_2,
 STORE_MAP.store_nr AS filialnummer,
 STORE_MAP.store_name AS filialname,
 STORE_MAP.wh_id AS ges_nummer,
 STORE_MAP.wh_name AS ges_name,
 STORE_MAP.account_manager_name AS vertriebsleiter,
 STORE_MAP.sales_manager_name AS verkaufsleiter,
 STORE_MAP.longitude AS lengtegraad,
 STORE_MAP.latitude AS breedtegraad,
 -- Verkaufsfläche
 STORE_MAP.dat_opening_ovis AS eroeffnungsdatum,
 STORE_MAP.dat_closing_ovis AS `schließungsdatum`,
 CAL.cy AS kalenderjahr,
 CAL.byr AS geschaeftsjahr,
 CAL.month_id AS monat_nr,
 CAL.cy_month AS monat_gj,
 LJ_OM_KL.turnover AS omzet_lj,
 VJ_OM_KL.turnover AS omzet_vj,
 LJ_OM_KL.customer AS klanten_lj,
 VJ_OM_KL.customer AS klanten_vj,
 LJ_BER.ber_turnover_cy AS umsatz_bereinigt_lj,
 VJ_BER.ber_turnover_py AS umsatz_bereinigt_vj,
 LJ_BER.ber_customer_cy AS kunden_bereinigt_lj,
 VJ_BER.ber_customer_py AS kunden_bereinigt_vj,
 LJ_NET_H.hours_net AS nettouren_lj,
 VJ_NET_H.hours_net AS nettouren_vj,
 LJ_SAP.turnover_net AS omzet_sap_lj,
 VJ_SAP.turnover_net AS omzet_sap_vj
FROM ldl_s_conl_workbench.v_mis_turnover_customer_2 AS LJ_OM_KL
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store_2 AS STORE_MAP ON LJ_OM_KL.store_id = STORE_MAP.store_id
 LEFT JOIN ldl_s_conl_workbench.v_mis_net_hours_2 AS LJ_NET_H ON LJ_OM_KL.store_id = LJ_NET_H.store_id AND LJ_OM_KL.cy_month
    = LJ_NET_H.cy_month
 INNER JOIN ldl_s_conl.v_cal_month_2 AS CAL ON LJ_OM_KL.cy_month = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_mis_turnover_customer_2 AS VJ_OM_KL ON LJ_OM_KL.store_id = VJ_OM_KL.store_id AND CAL.prev_cy_month
    = VJ_OM_KL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_mis_net_hours_2 AS VJ_NET_H ON LJ_NET_H.store_id = VJ_NET_H.store_id AND CAL.prev_cy_month
    = VJ_NET_H.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_mis_ber_turnover_customer_2 AS LJ_BER ON LJ_OM_KL.client_id = LJ_BER.client_id AND
    LJ_OM_KL.store_id = LJ_BER.store_id AND LJ_OM_KL.cy_month = LJ_BER.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_mis_ber_turnover_customer_2 AS VJ_BER ON LJ_OM_KL.client_id = VJ_BER.client_id AND
    LJ_OM_KL.store_id = VJ_BER.store_id AND CAL.prev_cy_month = VJ_BER.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_turnover_net_sap_2 AS LJ_SAP ON CAST(STORE_MAP.store_nr AS STRING) = LJ_SAP.store_nr AND
   LJ_OM_KL.cy_month = LJ_SAP.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_turnover_net_sap_2 AS VJ_SAP ON CAST(STORE_MAP.store_nr AS STRING) = VJ_SAP.store_nr AND
   CAL.prev_cy_month = VJ_SAP.cy_month
WHERE LJ_OM_KL.cy_month >= 201803
 AND STORE_MAP.mis_store_active_fg = 1
 AND LJ_OM_KL.turnover > 100 -- AND Monat_GJ <= (SELECT MAX(Monat_GJ) FROM LDL.s_conl_workbench.v_mstr_cost_store_2)
;