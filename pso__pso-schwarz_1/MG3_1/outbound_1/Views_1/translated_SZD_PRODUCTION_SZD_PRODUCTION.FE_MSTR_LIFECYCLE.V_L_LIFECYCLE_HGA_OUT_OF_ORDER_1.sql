CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_l_lifecycle_hga_out_of_order_1 (out_of_order, out_of_order_desc
, out_of_order_desc_de, out_of_order_desc_ch, out_of_order_desc_en, out_of_order_desc_cz, out_of_order_desc_lt,
out_of_order_desc_sk, out_of_order_desc_si, out_of_order_desc_ro) AS SELECT DISTINCT CASE
  WHEN NOT is_in_operation_fg
  THEN 'ja'
  WHEN is_in_operation_fg
  THEN 'nein'
  ELSE NULL
  END AS out_of_order,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'ja'
  WHEN is_in_operation_fg
  THEN 'nein'
  ELSE NULL
  END AS out_of_order_desc,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'ja'
  WHEN is_in_operation_fg
  THEN 'nein'
  ELSE NULL
  END AS out_of_order_desc_de,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'ja'
  WHEN is_in_operation_fg
  THEN 'nein'
  ELSE NULL
  END AS out_of_order_desc_ch,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_en,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_cz,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_lt,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_sk,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_si,
  CASE
  WHEN NOT is_in_operation_fg
  THEN 'yes'
  WHEN is_in_operation_fg
  THEN 'no'
  ELSE NULL
  END AS out_of_order_desc_ro
FROM szd_production_core.t_fact_hga_error_1;