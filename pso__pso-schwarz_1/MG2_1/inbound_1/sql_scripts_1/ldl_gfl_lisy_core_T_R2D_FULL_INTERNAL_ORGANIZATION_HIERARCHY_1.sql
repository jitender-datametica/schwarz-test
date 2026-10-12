DELETE FROM etl.T_TMP_FULL_INT_ORG_HIERARCHY_1;

INSERT INTO etl.T_TMP_FULL_INT_ORG_HIERARCHY_1
(
    CHILD_ORG_SID				
    ,CHILD_ORG_TYPE_CD			
    ,CHILD_ORG_NR				
    ,CHILD_ORG_NAME				
    ,LEVELS_ABOVE_LEAF			
    ,TOP_HIERARCHY_TYPE_CD		
    ,DWH_VALID_FROM_TMSP		
    ,DWH_VALID_TO_TMSP			
    ,PARENT_ORG_SID				
    ,PARENT_ORG_TYPE_CD			
    ,PARENT_ORG_NR				
    ,PARENT_ORG_NAME			
    ,INT_ORG_HIERACHY_PATH		
    ,PARENT_COUNTRY_ORG_CD		
)
with
--organization relationship type
ort (CHILD_ORG_TYPE_CD, PARENT_ORG_TYPE_CD, INT_ORG_HIERARCHY_TYPE_CD, NEXT_INT_ORG_HIERARCHY_TYPE_CD) as
(
    -- VGES/sales_1
    SELECT 'STORE', 'SALES_MANAGER', 'SALES_STORE', 'ACCOUNT_SALES' FROM DUAL
    UNION ALL
    SELECT 'SALES_MANAGER', 'ACCOUNT_MANAGER', 'ACCOUNT_SALES', 'COMPANY_ACCOUNT' FROM DUAL
    UNION ALL
    SELECT 'ACCOUNT_MANAGER', 'COMPANY', 'COMPANY_ACCOUNT', 'REGION_COMPANY' FROM DUAL

    -- BGES/delivery
    UNION ALL
    SELECT 'STORE', 'COMPANY', 'DELIVCMP_STORE', 'REGION_COMPANY' FROM DUAL
    UNION ALL
    SELECT 'STORE', 'COMPANY', 'OWNERCMP_STORE', 'X' FROM DUAL
    UNION ALL
    SELECT 'STORE', 'COMPANY', 'EXPCMP_STORE', 'X' FROM DUAL
    UNION ALL
    SELECT 'STORE', 'COMPANY', 'BALSHCMP_STORE', 'X' FROM DUAL

    -- common
	UNION ALL
    SELECT 'STORE', 'COMPANY', 'CNTRY_ORG_STORE', 'CNTRY_GRP_CNTRY_ORG' FROM DUAL
    UNION ALL
    SELECT 'COMPANY', 'REGION_1', 'REGION_COMPANY', 'CNTRY_ORG_REGION' FROM DUAL
    UNION ALL
    SELECT 'REGION_1', 'COMPANY', 'CNTRY_ORG_REGION', 'CNTRY_GRP_CNTRY_ORG' FROM DUAL
    UNION ALL
    SELECT 'COMPANY', 'COUNTRY_GRP', 'CNTRY_GRP_CNTRY_ORG', 'TRUST_COUNTRY_GRP' FROM DUAL
    UNION ALL
    SELECT 'COUNTRY_GRP', 'TRUST', 'TRUST_COUNTRY_GRP', 'X' FROM DUAL
)
-- full hierarchy_1 tree
,fht as
(
    SELECT 
        greatest(
            c.DWH_VALID_FROM_TMSP
            ,h.DWH_VALID_FROM_TMSP
            ,p.DWH_VALID_FROM_TMSP
            )                           as DWH_VALID_FROM_TMSP
        ,least(
            c.DWH_VALID_TO_TMSP
            ,h.DWH_VALID_TO_TMSP
            ,p.DWH_VALID_TO_TMSP
            )                           as DWH_VALID_TO_TMSP
        
        ,c.INT_ORG_SID                  as CHILD_ORG_SID
        ,c.INT_ORG_TYPE_CD              as CHILD_ORG_TYPE_CD
        ,c.INT_ORG_NR                   as CHILD_ORG_NR
        ,c.INT_ORG_NAME                 as CHILD_ORG_NAME
        
        ,p.INT_ORG_SID                  as PARENT_ORG_SID
        ,p.INT_ORG_TYPE_CD              as PARENT_ORG_TYPE_CD
        ,p.INT_ORG_NR                   as PARENT_ORG_NR
        ,p.INT_ORG_NAME                 as PARENT_ORG_NAME
        ,p.COUNTRY_ORG_CD               as PARENT_COUNTRY_ORG_CD
		
        ,ort.INT_ORG_HIERARCHY_TYPE_CD  as TOP_HIERARCHY_TYPE_CD
        ,ort.NEXT_INT_ORG_HIERARCHY_TYPE_CD
        ,1                              as LEVELS_ABOVE_LEAF
        ,cast(ort.INT_ORG_HIERARCHY_TYPE_CD as VARCHAR(200))    as INT_ORG_HIERACHY_PATH
        
    FROM core_rel.T_INTERNAL_ORGANIZATION_1 c
        inner join ort on c.INT_ORG_TYPE_CD = ort.CHILD_ORG_TYPE_CD
        inner join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_1 h 
                        on h.INT_ORG_SID = c.INT_ORG_SID
                        and h.DWH_VALID_FROM_TMSP <= c.DWH_VALID_TO_TMSP
                        and h.DWH_VALID_TO_TMSP >= c.DWH_VALID_FROM_TMSP
                        and h.INT_ORG_HIERARCHY_TYPE_CD = ort.INT_ORG_HIERARCHY_TYPE_CD
        inner join core_rel.T_INTERNAL_ORGANIZATION_1 p 
                        on p.INT_ORG_SID = h.PARENT_INT_ORG_SID
                        and p.DWH_VALID_FROM_TMSP <= least(c.DWH_VALID_TO_TMSP, h.DWH_VALID_TO_TMSP)
                        and p.DWH_VALID_TO_TMSP >= greatest(c.DWH_VALID_FROM_TMSP, h.DWH_VALID_FROM_TMSP)
	
	UNION ALL
    
    SELECT 
        greatest(
            c.DWH_VALID_FROM_TMSP
            ,h.DWH_VALID_FROM_TMSP
            ,p.DWH_VALID_FROM_TMSP
            )                           as DWH_VALID_FROM_TMSP
        ,least(
            c.DWH_VALID_TO_TMSP
            ,h.DWH_VALID_TO_TMSP
            ,p.DWH_VALID_TO_TMSP
            )                           as DWH_VALID_TO_TMSP

        ,c.CHILD_ORG_SID
        ,c.CHILD_ORG_TYPE_CD
        ,c.CHILD_ORG_NR
        ,c.CHILD_ORG_NAME
        
        ,p.INT_ORG_SID                  as PARENT_ORG_SID
        ,p.INT_ORG_TYPE_CD              as PARENT_ORG_TYPE_CD
        ,p.INT_ORG_NR                   as PARENT_ORG_NR
        ,p.INT_ORG_NAME                 as PARENT_ORG_NAME
        ,p.COUNTRY_ORG_CD               as PARENT_COUNTRY_ORG_CD
        
        ,h.INT_ORG_HIERARCHY_TYPE_CD    as TOP_HIERARCHY_TYPE_CD
        ,ort.NEXT_INT_ORG_HIERARCHY_TYPE_CD
        ,LEVELS_ABOVE_LEAF + 1          as LEVELS_ABOVE_LEAF
        ,INT_ORG_HIERACHY_PATH||' | '||h.INT_ORG_HIERARCHY_TYPE_CD    as INT_ORG_HIERACHY_PATH
        
    FROM fht c
        join ort on c.PARENT_ORG_TYPE_CD = ort.CHILD_ORG_TYPE_CD
                and c.NEXT_INT_ORG_HIERARCHY_TYPE_CD = ort.INT_ORG_HIERARCHY_TYPE_CD
        join core_rel.T_INTERNAL_ORGANIZATION_HIERARCHY_1 h 
                        on h.INT_ORG_SID = c.PARENT_ORG_SID
                        and h.DWH_VALID_FROM_TMSP <= c.DWH_VALID_TO_TMSP
                        and h.DWH_VALID_TO_TMSP >= c.DWH_VALID_FROM_TMSP
                        and h.INT_ORG_HIERARCHY_TYPE_CD = ort.INT_ORG_HIERARCHY_TYPE_CD
        join core_rel.T_INTERNAL_ORGANIZATION_1 p 
                        on p.INT_ORG_SID = h.PARENT_INT_ORG_SID
                        and p.DWH_VALID_FROM_TMSP <= least(c.DWH_VALID_TO_TMSP, h.DWH_VALID_TO_TMSP)
                        and p.DWH_VALID_TO_TMSP >= greatest(c.DWH_VALID_FROM_TMSP, h.DWH_VALID_FROM_TMSP)	
)
SELECT
    CHILD_ORG_SID
    ,CHILD_ORG_TYPE_CD
    ,CHILD_ORG_NR
    ,CHILD_ORG_NAME
    ,LEVELS_ABOVE_LEAF
    ,TOP_HIERARCHY_TYPE_CD
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,PARENT_ORG_SID
    ,PARENT_ORG_TYPE_CD
    ,PARENT_ORG_NR
    ,PARENT_ORG_NAME
    ,INT_ORG_HIERACHY_PATH
    ,PARENT_COUNTRY_ORG_CD
FROM fht 
;
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
DELETE FROM ETL.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY_1;


INSERT INTO ETL.T_R2D_FULL_INTERNAL_ORGANIZATION_HIERARCHY_1(
	CHILD_ORG_SID
    ,CHILD_ORG_TYPE_CD
    ,CHILD_ORG_NR
    ,CHILD_ORG_NAME
    ,LEVELS_ABOVE_LEAF
    ,TOP_HIERARCHY_TYPE_CD
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,PARENT_ORG_SID
    ,PARENT_ORG_TYPE_CD
    ,PARENT_ORG_NR
    ,PARENT_ORG_NAME
    ,INT_ORG_HIERACHY_PATH
    ,PARENT_COUNTRY_ORG_CD
)
with
fh_with_change_fg as
(
    SELECT 
        x.*
        ,sha2(
            nvl(lower(CHILD_ORG_NR), '@')
            ||'#&#'||nvl(lower(CHILD_ORG_NAME), '@')
            ||'#&#'||nvl(to_char(PARENT_ORG_SID), '-1')
            ||'#&#'||nvl(lower(PARENT_ORG_NR), '-1')
            ||'#&#'||nvl(lower(PARENT_ORG_NAME), '-1')
            ||'#&#'||nvl(PARENT_COUNTRY_ORG_CD, '@')
            ) as row_hash_for_diff
            
        ,lag(row_hash_for_diff)
            over (
                PARTITION BY CHILD_ORG_SID, LEVELS_ABOVE_LEAF, TOP_HIERARCHY_TYPE_CD
                ORDER BY DWH_VALID_FROM_TMSP asc
            )                           as prev_row_hash_for_diff
        
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                         as HAS_CHANGE_FG

    FROM etl.T_TMP_FULL_INT_ORG_HIERARCHY_1 x

)
, fh_with_groups as
(
    SELECT
        x.*
        ,SUM(HAS_CHANGE_FG)
            over (
                PARTITION BY CHILD_ORG_SID, LEVELS_ABOVE_LEAF, TOP_HIERARCHY_TYPE_CD
                ORDER BY DWH_VALID_FROM_TMSP asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) as GROUP_ID
    FROM fh_with_change_fg x
)
SELECT 
    CHILD_ORG_SID
    ,CHILD_ORG_TYPE_CD
    ,CHILD_ORG_NR
    ,CHILD_ORG_NAME
    ,LEVELS_ABOVE_LEAF
    ,TOP_HIERARCHY_TYPE_CD
    ,min(DWH_VALID_FROM_TMSP)  as DWH_VALID_FROM_TMSP
    ,max(DWH_VALID_TO_TMSP)    as DWH_VALID_TO_TMSP
    ,PARENT_ORG_SID
    ,PARENT_ORG_TYPE_CD
    ,PARENT_ORG_NR
    ,PARENT_ORG_NAME
    ,INT_ORG_HIERACHY_PATH
    ,PARENT_COUNTRY_ORG_CD
FROM fh_with_groups
GROUP BY
    CHILD_ORG_SID
    ,CHILD_ORG_TYPE_CD
    ,CHILD_ORG_NR
    ,CHILD_ORG_NAME
    ,LEVELS_ABOVE_LEAF
    ,TOP_HIERARCHY_TYPE_CD
    ,PARENT_ORG_SID
    ,PARENT_ORG_TYPE_CD
    ,PARENT_ORG_NR
    ,PARENT_ORG_NAME
    ,INT_ORG_HIERACHY_PATH
    ,PARENT_COUNTRY_ORG_CD
    ,GROUP_ID
;
