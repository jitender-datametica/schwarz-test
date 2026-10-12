CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_INV_DIFF_RECORD_POS
/*
#DescStart#
#$Revision: 9567 $, $LastChangedBy: jgraeff $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
       client_id
,      record_year
,      record_cd
,      record_pos_id
,      record_pos_sub_id
,      loc_sid
,      item_sid
,      comp_sid
,      sales_org_sid
,      uom_sid
,      curr_sid
,      move_type_cd
,      storage_loc_cd
,      inv_nr
,      inv_record_cd
,      inv_dt
,      inv_type_cd
,      uom_cd
,      inv_diff_qty
,      curr_cd
,      inv_diff_gross_val
,      inv_diff_net_val
,      dwh_cal_dt
,      dwh_load_id
,      dwh_created
,      dwh_updated
)
AS
   SELECT
          client_id,
   record_year,
   record_cd,
   record_pos_id,
   record_pos_sub_id,
   loc_sid,
   item_sid,
   comp_sid,
   sales_org_sid,
   uom_sid,
   curr_sid,
   move_type_cd,
   storage_loc_cd,
   inv_nr,
   inv_record_cd,
   inv_dt,
   inv_type_cd,
   uom_cd,
   inv_diff_qty,
   curr_cd,
   inv_diff_gross_val,
   inv_diff_net_val,
   dwh_cal_dt,
   dwh_load_id,
   dwh_created,
   dwh_updated
FROM p_lew_core.t_inv_diff_record_pos
;