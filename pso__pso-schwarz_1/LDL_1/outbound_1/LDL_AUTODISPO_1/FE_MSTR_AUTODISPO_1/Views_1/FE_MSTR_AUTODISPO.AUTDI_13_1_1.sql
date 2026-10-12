CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.autdi_13_1_1 (country_1, itemnr_long, item_nr, itemnr_long_desc,
store, itemdesc, entrydate, store_day, warehousemil, status_1, std, quantity, missing_items_1, suspicious_stock, store_desc
, warehouseno, subgroup_desc, subgroup_no, family_desc, family_no, rlz_customer, rlz_store, rlz_wh) AS SELECT VM.country_1
 ,
 VM.itemnr_long,
 VM.item_nr,
   VM.item_nr || ' - ' || VM.itemdesc AS itemnr_long_desc,
 VM.store,
 VM.itemdesc,
 VM.entrydate,
  CAST(VM.store AS STRING) || CAST(VM.entrydate AS STRING) AS store_day,
 VM.warehousemil,
 VM.status_1,
 VM.std,
 VM.quantity,
  CASE
  WHEN VM.quantity = 0 AND DD_PARAM.param_value <> VM.item_nr
  THEN 1
  ELSE 0
  END AS missing_items_1,
  CASE
  WHEN VM.quantity <> 0 AND DD_PARAM.param_value <> VM.item_nr
  THEN 1
  ELSE 0
  END AS suspicious_stock,
 S.store_address AS store_desc,
 S.store_wh AS warehouseno,
 I.item_sub_group AS subgroup_desc,
 I.item_sub_group_nr AS subgroup_no,
 I.item_family_group AS family_desc,
 I.item_family_group_nr AS family_no,
 I.item_rlz_supplier AS rlz_customer,
 I.item_rlz_store AS rlz_store,
 I.item_rlz_warehouse AS rlz_wh
FROM ldl_autodispo_core.t_oracle_v_fk_mil_1 AS VM
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_item_1 AS I ON VM.item_nr = I.item_nr AND VM.country_1 = I.country_1
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store_1 AS S ON VM.store = S.store_nr AND VM.country_1 = S.country_1 AND S.deleted
    = 0
 LEFT JOIN ldl_autodispo_core.t_oracle_v_dd_parameter_1 AS DD_PARAM ON VM.country_1 = DD_PARAM.country_1 AND DD_PARAM.param_name
    = 'CONTROL_ITEM';