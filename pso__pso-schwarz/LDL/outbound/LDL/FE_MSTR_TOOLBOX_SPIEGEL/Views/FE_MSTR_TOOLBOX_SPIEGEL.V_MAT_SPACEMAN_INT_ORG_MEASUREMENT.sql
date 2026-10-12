/*
#----------------------------------------------------------------------------
# Description:
# Materialization view for the fe_mstr_toolbox_spiegel.t_spaceman_int_org_measurement table.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.02.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_spaceman_int_org_measurement AS WITH CTE_ORG_KEYS AS (SELECT
   INTORGCL.int_org_sid,
   INTORG.int_org_nr
  FROM ldl_p_lew_core_ac.v_internal_organisation_client AS INTORGCL
   INNER JOIN ldl_p_lew_core_ac.v_internal_organisation AS INTORG ON INTORGCL.int_org_sid = INTORG.int_org_sid
  WHERE INTORGCL.int_org_type_cd = 'SPACEMAN'
  GROUP BY INTORGCL.int_org_sid,
   INTORG.int_org_nr), CTE_METRIC_SYS AS (SELECT 1 AS metric_system_id,
    'cm' AS metric_system_name,
    'kg' AS metric_system_weight_name,
    1 AS factor,
    1 AS factor_weight,
    60 AS dd_600_width,
    60 AS dd_600_depth,
    66.5 AS dd_665_width,
    80 AS dd_800_width,
    80 AS dd_800_depth,
    80 AS ep_800_depth,
    120 AS ep_1200_width,
    120 AS ep_1200_depth,
    133 AS ep_1330_width,
    62 AS pod_620_depth
   UNION ALL
   SELECT 2 AS metric_system_id,
    'inch' AS metric_system_name,
    'pound' AS metric_system_weight_name,
    0.393701 AS factor,
    2.20462 AS factor_weight,
    60 AS dd_600_width,
    60 AS dd_600_depth,
    66.5 AS dd_665_width,
    80 AS dd_800_width,
    80 AS dd_800_depth,
    80 AS ep_800_depth,
    120 AS ep_1200_width,
    120 AS ep_1200_depth,
    133 AS ep_1330_width,
    62 AS pod_620_depth), CTE_METRIC_SYS_US AS (SELECT 1 AS metric_system_id,
    'cm' AS metric_system_name,
    'kg' AS metric_system_weight_name,
    2.54 AS factor,
    0.453592 AS factor_weight,
    NULL AS dd_600_width,
    NULL AS dd_600_depth,
    NULL AS dd_665_width,
    NULL AS dd_800_width,
    NULL AS dd_800_depth,
    NULL AS ep_800_depth,
    46 AS ep_1200_width,
    48 AS ep_1200_depth,
    NULL AS ep_1330_width,
    24.409462 AS pod_620_depth
   UNION ALL
   SELECT 2 AS metric_system_id,
    'inch' AS metric_system_name,
    'pound' AS metric_system_weight_name,
    1 AS factor,
    1 AS factor_weight,
    NULL AS dd_600_width,
    NULL AS dd_600_depth,
    NULL AS dd_665_width,
    NULL AS dd_800_width,
    NULL AS dd_800_depth,
    NULL AS ep_800_depth,
    46 AS ep_1200_width,
    48 AS ep_1200_depth,
    NULL AS ep_1330_width,
    24.409462 AS pod_620_depth) (SELECT *
  FROM (SELECT t2.int_org_sid,
      t4.metric_system_id,
      t4.metric_system_name,
      t4.metric_system_weight_name,
      t4.factor,
      t4.factor_weight,
      t4.dd_600_width,
      t4.dd_600_depth,
      t4.dd_665_width,
      t4.dd_800_width,
      t4.dd_800_depth,
      t4.ep_800_depth,
      t4.ep_1200_width,
      t4.ep_1200_depth,
      t4.ep_1330_width,
      t4.pod_620_depth
     FROM CTE_ORG_KEYS AS t2
      INNER JOIN CTE_METRIC_SYS AS t4 ON TRUE
     WHERE t2.int_org_nr <> 'US'
     UNION ALL
     SELECT t10.int_org_sid,
      t12.metric_system_id,
      t12.metric_system_name,
      t12.metric_system_weight_name,
      t12.factor,
      t12.factor_weight,
      CAST(t12.dd_600_width AS INTEGER) AS dd_600_width,
      CAST(t12.dd_600_depth AS INTEGER) AS dd_600_depth,
      CAST(t12.dd_665_width AS NUMERIC) AS dd_665_width,
      CAST(t12.dd_800_width AS INTEGER) AS dd_800_width,
      CAST(t12.dd_800_depth AS INTEGER) AS dd_800_depth,
      CAST(t12.ep_800_depth AS INTEGER) AS ep_800_depth,
      t12.ep_1200_width,
      t12.ep_1200_depth,
      CAST(t12.ep_1330_width AS INTEGER) AS ep_1330_width,
      t12.pod_620_depth
     FROM CTE_ORG_KEYS AS t10
      INNER JOIN CTE_METRIC_SYS_US AS t12 ON TRUE
     WHERE t10.int_org_nr = 'US'));