
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_PERIOD_SEQUENCE
(
  client_id
, per_id
, per_text
, per_text_EN
, per_lvl
, seq_lift
, seq_gl
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
  part1.region_id AS client_id
, part1.period_id AS per_id
, part1.per_text AS per_text
, part1.per_text_EN AS per_text_EN
, part1.period_lvl AS per_lvl
, (part1.seq_lift-part2.seq_lift) AS seq_lift
, (part1.seq_gl-part2.seq_gl) AS seq_gl
FROM
(
    SELECT
      region_id
    , period_id
    , per_text
    , per_text_EN
    , period_lvl
    , seq_lift
    , seq_gl
    FROM P_LEW_MART_CM.v_lil_period_pre_sequence
    UNION ALL
    SELECT
      perms.region_id
    , ptp.ltst_pseudo_period_id AS period_id
    , pm.per_text
    , pm.per_text_EN
    , perms.period_lvl
    , perms.seq_lift
    , perms2.seq_gl
    FROM P_LEW_MART_CM.v_lil_period_pre_sequence AS perms
    INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_per_latest AS rpl
        ON rpl.region_sid = perms.region_sid
        AND rpl.class_cd = 'LIFT1'
        AND rpl.ltst_per_id = perms.period_id
    INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_type AS ptp
        ON ptp.period_type_id = rpl.per_tp_id
        AND ptp.ltst_pseudo_period_id IS NOT NULL
    INNER JOIN P_LEW_MART_CM.v_lil_period AS pm
        ON pm.per_id = ptp.ltst_pseudo_period_id
    LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_per_latest AS rpl2
        ON rpl2.region_sid = perms.region_sid
        AND rpl2.per_tp_id = perms.period_lvl
        AND rpl2.class_cd = 'LIFTGL'
    LEFT OUTER JOIN P_LEW_MART_CM.v_lil_period_pre_sequence AS perms2
        ON perms.region_sid = perms2.region_sid
        AND rpl2.ltst_per_id = perms2.period_id
) AS part1
CROSS JOIN
(
    SELECT 
        sq.region_id
        , sq.period_lvl
        , sq.seq_lift
        , sq2.seq_gl
    FROM P_LEW_MART_CM.v_lil_period_pre_sequence AS sq
    INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_per_latest AS rpl
        ON rpl.region_sid = sq.region_sid
        AND rpl.ltst_per_id = sq.period_id
        AND rpl.class_cd = 'LIFT1'
    LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_per_latest AS rpl2
        ON rpl2.region_sid = sq.region_sid
        AND rpl2.per_tp_id = sq.period_lvl
        AND rpl2.class_cd = 'LIFTGL'
    LEFT OUTER JOIN P_LEW_MART_CM.v_lil_period_pre_sequence AS sq2
        ON sq.region_sid = sq2.region_sid
        AND rpl2.ltst_per_id = sq2.period_id
) AS part2
WHERE part1.region_id = part2.region_id
AND part1.period_lvl = part2.period_lvl;
