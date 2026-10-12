CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_loonjournal_post_1 AS SELECT CAL.cy_month,
 LJP.account_number,
 LJP.cost_center_desc,
  CASE
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl ECD01') <> 0 OR STRPOS(LJP.cost_center_desc, 'KstPl ECG02') <> 0 OR STRPOS(LJP
       .cost_center_desc, 'KstPl EC001') <> 0 OR STRPOS(LJP.cost_center_desc, 'KstPl EC002') <> 0 OR STRPOS(LJP.cost_center_desc
     , 'KstPl EC003') <> 0
  THEN 'ECD01'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 308106') <> 0
  THEN '318106'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309058') <> 0
  THEN '319058'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309068') <> 0
  THEN '319068'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309308') <> 0
  THEN '319308'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309378') <> 0
  THEN '319378'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309408') <> 0
  THEN '319408'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309628') <> 0
  THEN '319628'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309648') <> 0
  THEN '319648'
  WHEN STRPOS(LJP.cost_center_desc, 'KstPl 309668') <> 0
  THEN '319668'
  WHEN LENGTH(TRIM(LJP.cost_center_desc)) = 11
  THEN RIGHT(TRIM(LJP.cost_center_desc), 3)
  WHEN LENGTH(TRIM(LJP.cost_center_desc)) = 12
  THEN RIGHT(TRIM(LJP.cost_center_desc), 6)
  ELSE NULL
  END AS cost_center,
 LJP.pay_component,
 PCC.cost_component_desc,
  COALESCE(LJP.debit_amount, 0) - COALESCE(LJP.credit_amount, 0) AS saldo_amount
FROM ldl_s_conl_workbench.t_i_cost_loonjournal_post_1 AS LJP
 LEFT JOIN ldl_s_conl_workbench.t_m_pay_cost_component_1 AS PCC ON LEFT(LJP.pay_component, 4) = LEFT(PCC.pay_component_code
   , 4)
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_1 AS CAL ON LJP.booking_year = CAL.booking_year AND LJP.booking_period =
   CAL.booking_periode;