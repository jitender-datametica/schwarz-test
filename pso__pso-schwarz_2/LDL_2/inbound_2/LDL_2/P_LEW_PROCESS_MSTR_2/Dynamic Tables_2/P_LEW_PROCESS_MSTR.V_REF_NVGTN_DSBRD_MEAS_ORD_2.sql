
CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_REF_NVGTN_DSBRD_MEAS_ORD_2
(
    dsbrd_id
   , blk_id
   , phy_doc_type_id
   , dsbrd_blk_ord
   , meas_grp_id
   , meas_grp_cnt
   , hd_row_ind
   , blk_meas_titl_text_id
   , blk_meas_titl2_text_id
   , meas_id
   , mstr_mtrc_guid
   , tot_meas_id
   , tot_mstr_mtrc_guid
   , blk_meas_ord
   , dsbrd_meas_ord
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_2 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
AS
   SELECT
      cbr.dsbrd_id,
   cbr.blk_id,
   cbr.phy_doc_type_id,
   cbr.dsbrd_blk_ord,
   lm.meas_grp_id,
   Sum (1) OVER (PARTITION BY lm.meas_grp_id ) meas_grp_cnt,
   lmbr.hd_row_ind,
   lmbr.blk_meas_titl_text_id,
   lmbr.blk_meas_titl2_text_id,
   lmbr.meas_id,
   lm.mstr_mtrc_guid,
   lmbr.tot_meas_id,
   tlm.mstr_mtrc_guid AS tot_mstr_mtrc_guid,
   lmbr.blk_meas_ord,
   RANK () OVER (ORDER BY cbr.dsbrd_blk_ord ,lmbr.blk_meas_ord) dsbrd_meas_ord
  FROM p_lew_process_mstr.v_ref_dsbrd_blk_rel_act_2 AS cbr
   INNER JOIN p_lew_process_mstr.v_ref_meas_blk_rel_act_2  AS lmbr
   ON cbr.blk_id = lmbr.blk_id
   INNER JOIN p_lew_process_mstr.v_ref_meas_act_2 AS lm
   ON lmbr.meas_id = lm.meas_id
   INNER JOIN p_lew_process_mstr.v_ref_meas_act_2 AS tlm
   ON lmbr.tot_meas_id = tlm.meas_id
   WHERE cbr.phy_doc_type_id=4
   GROUP BY
      cbr.dsbrd_id
     , cbr.blk_id
     , cbr.phy_doc_type_id
     , cbr.dsbrd_blk_ord
     , lm.meas_grp_id
     , lmbr.hd_row_ind
     , lmbr.blk_meas_titl_text_id
     , lmbr.blk_meas_titl2_text_id
     , lmbr.meas_id
     , lm.mstr_mtrc_guid
     , lmbr.tot_meas_id
     , tlm.mstr_mtrc_guid
     , lmbr.blk_meas_ord
;
