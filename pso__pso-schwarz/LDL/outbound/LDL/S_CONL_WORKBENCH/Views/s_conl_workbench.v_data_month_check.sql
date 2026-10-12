CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_data_month_check AS SELECT 'Kosten Extern    ' AS bestand,
 MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0)) AS cy_month_loaded
FROM ldl_s_conl_workbench.v_cost_extern
UNION ALL
SELECT 'Loonjournal post' AS bestand,
 MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0)) AS cy_month_loaded
FROM ldl_s_conl_workbench.v_cost_loonjournal_post
UNION ALL
SELECT 'Reservering' AS bestand,
 MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0)) AS cy_month_loaded
FROM ldl_s_conl_workbench.v_cost_reservering_hk_meer_toeslag
UNION ALL
SELECT 'Kosten SAP' AS bestand,
 MAX(ROUND(CAST(cy_month AS BIGNUMERIC), 0))
FROM ldl_s_conl_workbench.v_cost_sap
UNION ALL
SELECT 'PO lead' AS bestand,
 MAX(CAST(cy_month AS BIGNUMERIC)) AS cy_month_loaded
FROM ldl_s_conl_workbench.v_hr_po_lead;