CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_AGG_DSBRD_MEAS_PG_NVGTN_1
  (
    dsbrd_id
  , blk_id
  , phy_doc_type_id
  , meas_grp_id
  , dspl_meas_grp_fl
  , blk_strt_pg_fl
  , dsbrd_blk_ord
  , meas_grp_cnt
  , pg_meas_grp_cnt
  , blk_meas_ord
  , hd_row_ind
  , blk_meas_titl_text_id
  , blk_meas_titl2_text_id
  , meas_id
  , mstr_mtrc_guid
  , tot_meas_id
  , tot_mstr_mtrc_guid
  , dsbrd_meas_ord
  , pg_meas_ord
  , dsbrd_meas_grp_ord
  , prev_pg_guid
  , pg_guid
  , next_pg_guid
  , prev_pg_no
  , pg_no
  , next_pg_no
  , dummy_fl
  , load_id
  , dwh_inserted
  , dwh_updated
  )
  AS
     SELECT
       dsbrd_id,
     blk_id,
     phy_doc_type_id,
     meas_grp_id,
     dspl_meas_grp_fl,
     blk_strt_pg_fl,
     dsbrd_blk_ord,
     meas_grp_cnt,
     pg_meas_grp_cnt,
     blk_meas_ord,
     hd_row_ind,
     blk_meas_titl_text_id,
     blk_meas_titl2_text_id,
     meas_id,
     mstr_mtrc_guid,
     tot_meas_id,
     tot_mstr_mtrc_guid,
     dsbrd_meas_ord,
     pg_meas_ord,
     dsbrd_meas_grp_ord,
     prev_pg_guid,
     pg_guid,
     next_pg_guid,
     prev_pg_no,
     pg_no,
     next_pg_no,
     dummy_fl,
     load_id,
     dwh_inserted,
     dwh_updated
 FROM p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn_1
;