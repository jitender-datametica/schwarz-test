CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_sap AS SELECT SAP_C.cost_typ,
 SAP_C.cost_typ_desc,
 SAP_C.cost_center AS cost_center_short,
 SAP_C.object_desc,
 MP.cy_month,
 SAP_C.saldo_amount,
 SAP_C.contra_account_desc,
 SAP_C.transcation_desc,
  CASE
  WHEN STRPOS(SAP_C.cost_center, 'ECD01') <> 0 OR STRPOS(SAP_C.cost_center, 'ECG02') <> 0 OR STRPOS(SAP_C.cost_center,
       'EC001') <> 0 OR STRPOS(SAP_C.cost_center, 'EC002') <> 0 OR STRPOS(SAP_C.cost_center, 'EC003') <> 0
  THEN 'ECD01'
  WHEN STRPOS(SAP_C.cost_center, '308106') <> 0
  THEN '318106'
  WHEN STRPOS(SAP_C.cost_center, '309058') <> 0
  THEN '319058'
  WHEN STRPOS(SAP_C.cost_center, '309068') <> 0
  THEN '319068'
  WHEN STRPOS(SAP_C.cost_center, '309308') <> 0
  THEN '319308'
  WHEN STRPOS(SAP_C.cost_center, '309378') <> 0
  THEN '319378'
  WHEN STRPOS(SAP_C.cost_center, '309408') <> 0
  THEN '319408'
  WHEN STRPOS(SAP_C.cost_center, '309628') <> 0
  THEN '319628'
  WHEN STRPOS(SAP_C.cost_center, '309648') <> 0
  THEN '319648'
  WHEN STRPOS(SAP_C.cost_center, '309668') <> 0
  THEN '319668'
  WHEN LENGTH(TRIM(SAP_C.cost_center)) = 5
  THEN RIGHT(TRIM(SAP_C.cost_center), 3)
  WHEN LENGTH(TRIM(SAP_C.cost_center)) = 6
  THEN RIGHT(TRIM(SAP_C.cost_center), 6)
  ELSE NULL
  END AS cost_center,
 COST_T.cost_component_desc
FROM ldl_s_conl_workbench.t_i_cost_sap AS SAP_C
 LEFT JOIN ldl_s_conl_workbench.t_m_cost_typ AS COST_T ON SAP_C.cost_typ = COST_T.cost_typ
 INNER JOIN ldl_s_conl_workbench.t_m_month_periode AS MP ON CASE
   WHEN CAST(SAP_C.booking_periode AS FLOAT64) <= 9
   THEN SAP_C.booking_year || '0' || SAP_C.booking_periode
   ELSE SAP_C.booking_year || SAP_C.booking_periode
   END = MP.by_period
WHERE COST_T.cost_typ IS NOT NULL;