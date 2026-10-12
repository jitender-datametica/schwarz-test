DELETE FROM etl.T_R2D_RESOURCE_ITEM_COST_1;


INSERT INTO etl.T_R2D_RESOURCE_ITEM_COST_1
(
    REAL_ESTATE_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,COST_TYPE_CD
    ,RESOURCE_ITEM_TYPE_CD
    ,CURR_CD
    ,COST_VAL
    ,COST_EUR_VAL
)
with 
re_cost as
(
    SELECT 
        re.REAL_ESTATE_SID
        ,greatest(re.DWH_VALID_FROM_TMSP
                ,ric.DWH_VALID_FROM_TMSP
                ,exr.DWH_VALID_FROM_TMSP
            )                                    as VAL_FROM
        ,least(re.DWH_VALID_TO_TMSP
                ,ric.DWH_VALID_TO_TMSP
                ,exr.DWH_VALID_TO_TMSP
            )                                    as VAL_TO
        ,ric.COST_TYPE_CD
        ,ric.RESOURCE_ITEM_TYPE_CD
        ,ric.CURR_CD
        ,ric.COST_VAL
        ,ric.COST_VAL * exr.EXCHANGE_RATE        as COST_EUR_VAL
        
        ,sha2(
            nvl(to_char(COST_VAL),-1)
            ||'#&#'||nvl(to_char(EXCHANGE_RATE),-1)
        )                                        as row_hash_for_diff
        ,lag(row_hash_for_diff) over (partition by re.REAL_ESTATE_SID, ric.COST_TYPE_CD order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                           as HAS_CHANGE_FG
    FROM core_rel.T_REAL_ESTATE_1 re_1
        join core_rel.T_RESOURCE_ITEM_COST_1 ric 
                    on ric.RESOURCE_ITEM_SID = re.REAL_ESTATE_SID
                    and ric.DWH_VALID_FROM_TMSP <= re.DWH_VALID_TO_TMSP
                    and ric.DWH_VALID_TO_TMSP >= re.DWH_VALID_FROM_TMSP
        join core_rel.T_EXCHANGE_RATE_1 exr 
                    on exr.SRC_CURR_CD = ric.CURR_CD
                    and exr.TGT_CURR_CD = 'EUR'
                    and exr.EXCHANGE_RATE_TYPE_CD = 'BEW_ISK' -- or other type of exchange rate
                    and exr.DWH_VALID_FROM_TMSP <= least(re.DWH_VALID_TO_TMSP, ric.DWH_VALID_TO_TMSP)
                    and exr.DWH_VALID_TO_TMSP >= greatest(re.DWH_VALID_FROM_TMSP, ric.DWH_VALID_FROM_TMSP)
)
,re_cost_with_groups as 
(
    SELECT 
        rec.*
        ,SUM(HAS_CHANGE_FG)
            over(PARTITION BY REAL_ESTATE_SID, COST_TYPE_CD
                ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )                                                as GROUP_ID
    FROM re_cost rec
)
SELECT 
    REAL_ESTATE_SID
    ,min(VAL_FROM)      as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)        as DWH_VALID_TO_TMSP
    ,COST_TYPE_CD
    ,RESOURCE_ITEM_TYPE_CD
    ,CURR_CD
    ,COST_VAL
    ,COST_EUR_VAL
FROM re_cost_with_groups
GROUP BY
    REAL_ESTATE_SID
    ,COST_TYPE_CD
    ,RESOURCE_ITEM_TYPE_CD
    ,CURR_CD
    ,COST_VAL
    ,COST_EUR_VAL
    ,GROUP_ID
;
