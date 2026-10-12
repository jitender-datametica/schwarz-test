CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.autdi_13_1 (country, itemnr_long, item_nr, itemnr_long_desc,
store, itemdesc, entrydate, store_day, warehousemil, status, std, quantity, missing_items, suspicious_stock, store_desc
, warehouseno, subgroup_desc, subgroup_no, family_desc, family_no, rlz_customer, rlz_store, rlz_wh) AS SELECT VM.country
 ,
 VM.itemnr_long,
 VM.item_nr,
   VM.item_nr || ' - ' || VM.itemdesc AS itemnr_long_desc,
 VM.store,
 VM.itemdesc,
 VM.entrydate,
  CAST(VM.store AS STRING) || CAST(VM.entrydate AS STRING) AS store_day,
 VM.warehousemil,
 VM.status,
 VM.std,
 VM.quantity,
  CASE
  WHEN VM.quantity = 0 AND DD_PARAM.param_value <> VM.item_nr
  THEN 1
  ELSE 0
  END AS missing_items,
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
FROM ldl_autodispo_core.t_oracle_v_fk_mil AS VM
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_item AS I ON VM.item_nr = I.item_nr AND VM.country = I.country
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store AS S ON VM.store = S.store_nr AND VM.country = S.country AND S.deleted
    = 0
 LEFT JOIN ldl_autodispo_core.t_oracle_v_dd_parameter AS DD_PARAM ON VM.country = DD_PARAM.country AND DD_PARAM.param_name
    = 'CONTROL_ITEM';