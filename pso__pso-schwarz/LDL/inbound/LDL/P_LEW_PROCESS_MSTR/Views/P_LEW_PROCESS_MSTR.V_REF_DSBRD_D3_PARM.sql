CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_DSBRD_D3_PARM
(
  dsbrd_id
, int_id
, client_ctry_id
, client_id
, aspect_id
, wh_id
, move_to_store_id
, org_lvl_id
, tm_lvl_id
, currency_iso_cd
, curr_tot_id
, cy_month
, cy_week
, byr
, d3_param
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     dsbrd_id,
   int_id,
   client_ctry_id,
   client_id,
   aspect_id,
   wh_id,
   move_to_store_id,
   org_lvl_id,
   tm_lvl_id,
   currency_iso_cd,
   curr_tot_id,
   cy_month,
   cy_week,
   byr,
   d3_param,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_dsbrd_d3_parm
;