CREATE OR REPLACE VIEW s_conl_workbench.v_data_month_check
AS
(SELECT
'Kosten Extern    ' as bestand,
max(TO_NUMBER(cy_month)) as cy_month_loaded
FROM s_conl_workbench.v_cost_extern

UNION ALL
SELECT
'Loonjournal post' as bestand,
max(TO_NUMBER(cy_month)) as cy_month_loaded
FROM s_conl_workbench.v_cost_loonjournal_post

UNION ALL
SELECT
'Reservering' as bestand,
max(TO_NUMBER(cy_month))  as cy_month_loaded
FROM s_conl_workbench.v_cost_reservering_hk_meer_toeslag

UNION ALL
SELECT
'Kosten SAP' as bestand,
max(TO_NUMBER(cy_month))
FROM s_conl_workbench.v_cost_sap

UNION ALL
SELECT
'PO lead' as bestand,
max(CAST(cy_month AS INT)) as cy_month_loaded
FROM s_conl_workbench.v_hr_po_lead

);


