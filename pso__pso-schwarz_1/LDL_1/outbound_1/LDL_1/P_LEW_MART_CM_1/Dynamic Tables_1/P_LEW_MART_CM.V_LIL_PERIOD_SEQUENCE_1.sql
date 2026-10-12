
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_period_sequence_1 AS
SELECT part1.region_id AS client_id,
 part1.period_id AS per_id,
 part1.per_text,
 part1.per_text_en,
 part1.period_lvl AS per_lvl,
  part1.seq_lift - part2.seq_lift AS seq_lift,
  part1.seq_gl - part2.seq_gl AS seq_gl
FROM (SELECT region_id,
    period_id,
    per_text,
    per_text_en,
    period_lvl,
    seq_lift,
    seq_gl
   FROM ldl_p_lew_mart_cm.v_lil_period_pre_sequence_1
   UNION ALL
   SELECT PERMS.region_id,
    PTP.ltst_pseudo_period_id AS period_id,
    PM.per_text,
    PM.per_text_en,
    PERMS.period_lvl,
    PERMS.seq_lift,
    PERMS2.seq_gl
   FROM ldl_p_lew_mart_cm.v_lil_period_pre_sequence_1 AS PERMS
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS RPL ON PERMS.region_sid = RPL.region_sid AND RPL.class_cd
        = 'LIFT1' AND PERMS.period_id = RPL.ltst_per_id
    INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_type_1 AS PTP ON RPL.per_tp_id = PTP.period_type_id AND PTP.ltst_pseudo_period_id
     IS NOT NULL
    INNER JOIN ldl_p_lew_mart_cm.v_lil_period_1 AS PM_1 ON PTP.ltst_pseudo_period_id = PM.per_id
    LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS RPL2 ON PERMS.region_sid = RPL2.region_sid AND PERMS
       .period_lvl = RPL2.per_tp_id AND RPL2.class_cd = 'LIFTGL'
    LEFT JOIN ldl_p_lew_mart_cm.v_lil_period_pre_sequence_1 AS PERMS2 ON PERMS.region_sid = PERMS2.region_sid AND RPL2.ltst_per_id
       = PERMS2.period_id) AS part1
 INNER JOIN (SELECT SQ.region_id,
   SQ.period_lvl,
   SQ.seq_lift,
   SQ2.seq_gl
  FROM ldl_p_lew_mart_cm.v_lil_period_pre_sequence_1 AS SQ
   INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS RPL0 ON SQ.region_sid = RPL0.region_sid AND SQ.period_id
       = RPL0.ltst_per_id AND RPL0.class_cd = 'LIFT1'
   LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_region_per_latest_1 AS RPL20 ON SQ.region_sid = RPL20.region_sid AND SQ.period_lvl
       = RPL20.per_tp_id AND RPL20.class_cd = 'LIFTGL'
   LEFT JOIN ldl_p_lew_mart_cm.v_lil_period_pre_sequence_1 AS SQ2 ON SQ.region_sid = SQ2.region_sid AND RPL20.ltst_per_id
     = SQ2.period_id) AS part2 ON part1.region_id = part2.region_id AND part1.period_lvl = part2.period_lvl;

