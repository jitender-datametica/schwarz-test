
CREATE OR REPLACE DYNAMIC TABLE P_LEW_PROCESS_MSTR.V_REF_DSBRD_PHDOC_MEAS_2
  (
    phy_doc_type_id
  , dsbrd_id
  , meas_id
  , phy_doc_dsbrd_meas_ord
  , meas_titl
  , tm_lvl_id
  , meas_fmt_id
  , meas_grp_titl
  , tot_fl
  , avg_fl
  )
TARGET_LAG = '1 hour, 30 minutes' -- dummy_2 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_PROCESS_MSTR
  AS
     SELECT
       c.phy_doc_type_id,
     a.dsbrd_id,
     a.meas_id,
     a.phy_doc_dsbrd_meas_ord,
     t.text_desc AS meas_titl,
     t.tm_lvl_id,
     b.meas_fmt_id,
     tg.text_desc AS meas_grp_titl,
     b.tot_fl,
     b.avg_fl
 FROM p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_rel_act_2 AS a
     INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS  t
     ON a.meas_text_id = t.text_id
     INNER JOIN p_lew_process_mstr.v_ref_phdoc_act_2 AS c
     ON a.phy_doc_id = c.phy_doc_id
     INNER JOIN p_lew_process_mstr.v_ref_meas_act_2 AS b
     ON a.meas_id = b.meas_id
     INNER JOIN p_lew_process_mstr.v_ref_meas_grp_act_2 AS mg
     ON b.meas_grp_id = mg.meas_grp_id
     INNER JOIN p_lew_process_mstr.v_ref_text_act_2 AS  tg
     ON mg.meas_grp_text_id = tg.text_id
     GROUP BY
       c.phy_doc_type_id
     , a.dsbrd_id
     , a.meas_id
     , a.phy_doc_dsbrd_meas_ord
     , t.text_desc
     , t.tm_lvl_id
     , b.meas_fmt_id
     , tg.text_desc
     , b.tot_fl
     , b.avg_fl
;
