
CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_REF_ORG_LVL_DSBRD_MEAS_DIV_1
(
  int_id
, meas_id
, dsbrd_id
, phy_doc_id
, client_ctry_id
, client_id
, aspect_id
, wh_id
, move_to_store_id
, org_lvl_id
, curr_tot_id
, currency_iso_cd
, phy_doc_dsbrd_meas_ord
, divsr
, unit_text_desc
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
AS
   SELECT
     mno.int_id,
   md.meas_id,
   dml.dsbrd_id,
   dml.phy_doc_id,
   mno.client_ctry_id,
   mno.client_id,
   mno.aspect_id,
   mno.wh_id,
   mno.move_to_store_id,
   mno.org_lvl_id,
   c.curr_tot_id,
   c.currency_iso_cd,
   dml.phy_doc_dsbrd_meas_ord,
   md.divsr,
   t_tu.text_desc
  FROM p_lew_process_mstr.v_ref_org_lvl_meas_div_act_1 AS md
   INNER JOIN p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_rel_act_1 AS dml
   ON md.meas_id = dml.meas_id
   INNER JOIN p_lew_process_mstr.t_agg_nvgtn_org_1 AS mno
   ON mno.org_lvl_id BETWEEN md.org_lvl_id_from AND md.org_lvl_id_to
   INNER JOIN p_lew_mart_msi_ac.v_ref_currency_1 AS c
   ON mno.curr_client_id=c.client_id
   OR (    mno.int_id IN (1 ,9)
       AND c.currency_iso_cd = 'EUR'
       AND c.client_id = 23
      )
   INNER JOIN p_lew_process_mstr.v_ref_meas_act_1 AS m
   ON md.meas_id = m.meas_id
   INNER JOIN p_lew_process_mstr.v_ref_text_act_1 AS t_tu
   ON md.unit_text_id = t_tu.text_id
   WHERE m.curr_meas_fg = 0
   OR md.currency_iso_cd = c.currency_iso_cd;
