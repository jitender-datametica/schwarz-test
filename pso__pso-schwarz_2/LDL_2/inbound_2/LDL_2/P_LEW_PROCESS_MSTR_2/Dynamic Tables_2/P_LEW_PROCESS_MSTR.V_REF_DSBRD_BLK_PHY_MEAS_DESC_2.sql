
CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_REF_DSBRD_BLK_PHY_MEAS_DESC_2
(
  phy_doc_type_id
, dsbrd_id
, blk_meas_ord
, pg_no
, blk_id
, meas_id
, meas_titl
, meas_titl_2
, tm_lvl_id
, meas_grp_id
, dsbrd_meas_ord
, pg_meas_ord
, meas_grp_titl
, blk_titl
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_2 value; will be refreshed by Abinitio 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
AS
   SELECT
     dbm.phy_doc_type_id,
   dbm.dsbrd_id,
   dbm.blk_meas_ord,
   dbm.pg_no,
   dbm.blk_id,
   dbm.meas_id,
   t.text_desc AS meas_titl,
   NULLIF(t2.text_desc ,'') AS meas_titl_2,
   t.tm_lvl_id,
   dbm.meas_grp_id,
   dbm.dsbrd_meas_ord,
   dbm.pg_meas_ord,
   tmg.text_desc AS meas_grp_titl,
   tb.text_desc AS blk_titl
  FROM p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn_2 AS dbm
   INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS t
   ON dbm.blk_meas_titl_text_id = t.text_id
   INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS t2
   ON dbm.blk_meas_titl2_text_id = t2.text_id
   INNER JOIN p_lew_process_mstr.v_ref_meas_grp_act_2 AS mg
   ON dbm.meas_grp_id = mg.meas_grp_id
   INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS tmg
   ON mg.meas_grp_text_id = tmg.text_id
   INNER JOIN p_lew_process_mstr.v_ref_blk_act_2 AS b
   ON dbm.blk_id = b.blk_id
   INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS tb
   ON b.blk_titl_text_id = tb.text_id
   WHERE t.tm_lvl_id = t2.tm_lvl_id
   OR t2.tm_lvl_id = 0
   GROUP BY
     dbm.phy_doc_type_id
   , dbm.dsbrd_id
   , dbm.blk_meas_ord
   , dbm.pg_no
   , dbm.blk_id
   , dbm.meas_id
   , t.text_desc
   , t2.text_desc
   , t.tm_lvl_id
   , dbm.meas_grp_id
   , dbm.dsbrd_meas_ord
   , dbm.pg_meas_ord
   , tmg.text_desc
   , tb.text_desc
;
