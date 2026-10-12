INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  inv_sid,
  inv_dt,
  inv_type_cd,
  inv_nr,
  int_org_sid,
  int_org_type_cd,
  country_org_sid,
  country_org_cd,
  inv_period_start_dt,
  inv_period_end_dt,
  inv_reason_id,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

select inv.inv_sid,
       inv.inv_dt,
       inv.inv_type_cd,
       inv.inv_nr,
       inv.int_org_sid,
       inv.int_org_type_cd,
       inv.country_org_sid,
       inv.country_org_cd,
       inv.inv_period_start_dt,
       inv.inv_period_end_dt,
       COALESCE(inv.inv_reason_id,-1) as inv_reason_id,
       ${LOAD_ID} dwh_load_id,
       inv.dwh_node_cd,
       0 tf_error_fg,
       '' error_descr,
       0 record_id,
       'core_rel' filename
from core_rel.t_inventory_1 inv
;
