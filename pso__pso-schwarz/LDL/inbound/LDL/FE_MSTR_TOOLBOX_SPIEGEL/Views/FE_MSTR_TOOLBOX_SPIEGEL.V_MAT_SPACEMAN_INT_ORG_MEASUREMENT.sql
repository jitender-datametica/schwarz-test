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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_SPACEMAN_INT_ORG_MEASUREMENT(
   INT_ORG_SID
 , METRIC_SYSTEM_ID
 , METRIC_SYSTEM_NAME
 , METRIC_SYSTEM_WEIGHT_NAME
 , FACTOR
 , FACTOR_WEIGHT
 , DD_600_WIDTH
 , DD_600_DEPTH
 , DD_665_WIDTH
 , DD_800_WIDTH
 , DD_800_DEPTH
 , EP_800_DEPTH
 , EP_1200_WIDTH
 , EP_1200_DEPTH
 , EP_1330_WIDTH
 , POD_620_DEPTH
) AS

WITH CTE_ORG_KEYS AS 
(
    SELECT
     intorgcl.int_org_sid
    ,intorg.int_org_nr
    FROM P_LEW_CORE_AC.v_internal_organisation_client intorgcl
    INNER JOIN P_LEW_CORE_AC.v_internal_organisation intorg
     ON intorgcl.int_org_sid = intorg.int_org_sid
    WHERE intorgcl.int_org_type_cd = 'SPACEMAN' 
    GROUP BY intorgcl.int_org_sid, intorg.int_org_nr
)

, CTE_METRIC_SYS AS 
(
    SELECT
    1               AS  metric_system_id
    , 'cm'          AS  metric_system_name
    , 'kg'          AS  metric_system_weight_name
    , 1             AS  factor
    , 1             AS  factor_weight
    , 60            AS  dd_600_width
    , 60            AS  dd_600_depth
    , 66.5          AS  dd_665_width
    , 80            AS  dd_800_width
    , 80            AS  dd_800_depth
    , 80            AS  ep_800_depth
    , 120           AS  ep_1200_width
    , 120           AS  ep_1200_depth
    , 133           AS  ep_1330_width
    , 62            AS  pod_620_depth
    
    UNION ALL 
    
    SELECT
    2               AS  metric_system_id
    , 'inch'        AS  metric_system_name
    , 'pound'       AS  metric_system_weight_name
    , 0.393701      AS  factor
    , 2.20462       AS  factor_weight
    , 60            AS  dd_600_width
    , 60            AS  dd_600_depth
    , 66.5          AS  dd_665_width
    , 80            AS  dd_800_width
    , 80            AS  dd_800_depth
    , 80            AS  ep_800_depth
    , 120           AS  ep_1200_width
    , 120           AS  ep_1200_depth
    , 133           AS  ep_1330_width
    , 62            AS  pod_620_depth
)

, CTE_METRIC_SYS_US AS
(
    SELECT
    1               AS  metric_system_id
    , 'cm'          AS  metric_system_name
    , 'kg'          AS  metric_system_weight_name
    , 2.54          AS  factor
    , 0.453592      AS  factor_weight
    , NULL          AS  dd_600_width
    , NULL          AS  dd_600_depth
    , NULL          AS  dd_665_width
    , NULL          AS  dd_800_width
    , NULL          AS  dd_800_depth
    , NULL          AS  ep_800_depth
    , 46            AS  ep_1200_width
    , 48            AS  ep_1200_depth
    , NULL          AS  ep_1330_width
    , 24.409462     AS  pod_620_depth
    
    UNION ALL 
    
    SELECT
    2               AS  metric_system_id
    , 'inch'        AS  metric_system_name
    , 'pound'       AS  metric_system_weight_name
    , 1             AS  factor
    , 1             AS  factor_weight
    , NULL          AS  dd_600_width
    , NULL          AS  dd_600_depth
    , NULL          AS  dd_665_width
    , NULL          AS  dd_800_width
    , NULL          AS  dd_800_depth
    , NULL          AS  ep_800_depth
    , 46            AS  ep_1200_width
    , 48            AS  ep_1200_depth
    , NULL          AS  ep_1330_width
    , 24.409462     AS  pod_620_depth
)

 SELECT 
   int_org_sid
 , metric_system_id
 , metric_system_name
 , metric_system_weight_name
 , factor
 , factor_weight
 , dd_600_width
 , dd_600_depth
 , dd_665_width
 , dd_800_width
 , dd_800_depth
 , ep_800_depth
 , ep_1200_width
 , ep_1200_depth
 , ep_1330_width
 , pod_620_depth
 FROM CTE_ORG_KEYS
 CROSS JOIN CTE_METRIC_SYS
 WHERE int_org_nr <> 'US'
 
 UNION ALL
 
 SELECT 
   int_org_sid
 , metric_system_id
 , metric_system_name
 , metric_system_weight_name
 , factor
 , factor_weight
 , dd_600_width
 , dd_600_depth
 , dd_665_width
 , dd_800_width
 , dd_800_depth
 , ep_800_depth
 , ep_1200_width
 , ep_1200_depth
 , ep_1330_width
 , pod_620_depth
 FROM CTE_org_keys
 CROSS JOIN CTE_METRIC_SYS_US
 WHERE int_org_nr = 'US'
;