
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM4_GROUPED_METRICS_2
(
   meas_id
 , liam4_meas_cd
 , liam4_meas_desc
 , liam4_meas_desc_EN
 , liam4_meas_smart_desc 
 , liam4_meas_smart_desc_EN
 , grp_id
 , grp_desc
 , grp_desc_EN
 , grp_smart_desc
 , grp_smart_desc_EN 
 , liam4_meas_id
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT    meas_id
        , meas_cd AS liam4_meas_cd
        , CAST(meas.meas_desc AS VARCHAR(128)) AS liam4_meas_desc
        , CAST(meas.meas_desc_EN AS VARCHAR(128)) AS liam4_meas_desc_EN
        , REPLACE(REPLACE(meas.meas_desc, '(Packung) (000)', ''), 'Packung (000)', '') AS liam4_meas_smart_desc
        , REPLACE(meas.meas_desc_EN, ' Packs (000)', '') AS liam4_meas_smart_desc_EN
        , liam4_meas_grp_id AS grp_id
        , CAST(grp.meas_grp_desc AS VARCHAR(128)) AS grp_desc
        , CAST(grp.meas_grp_desc_EN AS VARCHAR(128)) AS grp_desc_EN
        , DECODE(meas.liam4_meas_grp_id, 4, 'Gesamtmarkt (alle shopper_2)', 6, 'Lidl Shopper_2 im Wettbewerber 1', 7, 'Lidl Shopper_2 im Wettbewerber 2', grp.meas_grp_desc) AS grp_smart_desc
        , DECODE(meas.liam4_meas_grp_id, 4, 'Total Market (all shopper_2)', 6, 'Lidl Shopper_2 at Comp. 1', 7, 'Lidl Shopper_2 at Comp. 2', grp.meas_grp_desc_EN) AS grp_smart_desc_EN
        , liam4_srt_cd AS liam4_meas_id
FROM P_LEW_MART_CM.v_lil_measure_2 AS meas
INNER JOIN P_LEW_MART_CM.v_lil_measure_group_2 AS grp
    ON grp.meas_grp_id = meas.liam4_meas_grp_id
WHERE liam4_meas_grp_id NOT IN (-1,1)
AND meas_id NOT IN (8, 24);
