
CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_REF_DSBRD_BLK_PHY_MEAS_FMT_1
(
  dsbrd_id
, blk_id
, phy_doc_type_id
, meas_id
, dsbrd_meas_ord
, pg_meas_ord
, pg_no
, meas_fmt_id
)
TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
AS
   SELECT
     dsbrd_id,
   blk_id,
   phy_doc_type_id,
   nav.meas_id,
   dsbrd_meas_ord,
   pg_meas_ord,
   pg_no,
   meas_fmt_id
  FROM p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn_1 AS nav
   INNER JOIN p_lew_process_mstr.v_ref_meas_act_1 AS meas
   ON nav.meas_id = meas.meas_id;
