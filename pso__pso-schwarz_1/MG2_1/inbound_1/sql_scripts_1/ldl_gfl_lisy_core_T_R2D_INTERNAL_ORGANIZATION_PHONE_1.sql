DELETE FROM ETL.T_R2D_INTERNAL_ORGANIZATION_PHONE_1;

INSERT INTO ETL.T_R2D_INTERNAL_ORGANIZATION_PHONE_1
(
    INT_ORG_SID			
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP	
    ,PHONE_NR			
)
with 
int_org_phone as
(
    SELECT 
        io.INT_ORG_SID
		,greatest(io.DWH_VALID_FROM_TMSP
            ,pa.DWH_VALID_FROM_TMSP
            ,tn.DWH_VALID_FROM_TMSP
		)                                       as VAL_FROM
		,least(io.DWH_VALID_TO_TMSP
            ,pa.DWH_VALID_TO_TMSP
            ,tn.DWH_VALID_TO_TMSP
		)                                       as VAL_TO
		,tn.PHONE_NR                            as PHONE_NR
        
        ,lag(PHONE_NR) over (
                PARTITION BY io.INT_ORG_SID
                ORDER BY VAL_FROM ASC
            )                                   as PREV_PHONE_NR
        ,CASE
                WHEN PREV_PHONE_NR = PHONE_NR THEN 0
                ELSE 1
            END                                 as HAS_CHANGE_FG
    FROM core_rel.T_INTERNAL_ORGANIZATION_1 io
        join core_rel.T_PARTY_ADDRESS_1 pa on pa.PARTY_SID = io.INT_ORG_SID
                    and pa.ADDR_TYPE_CD = 'TEL'
                    and pa.ADDR_USG_TYPE_CD = 'TL_MN'
                    and pa.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                    and pa.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
        join core_rel.T_TELEPHONE_NUMBER_1 tn on pa.ADDR_SID = tn.PHONE_NR_SID
                    and tn.DWH_VALID_FROM_TMSP <= least(io.DWH_VALID_TO_TMSP
                                                        ,pa.DWH_VALID_TO_TMSP
                                                     )
                    and tn.DWH_VALID_TO_TMSP >= greatest(io.DWH_VALID_FROM_TMSP
                                                        ,pa.DWH_VALID_FROM_TMSP
                                                      )
    --temp just for test_1 to see how lisy-only data looks 
	-- WHERE 1=1
		-- and (
				-- (io.INT_ORG_TYPE_CD in ('STORE', 'COMPANY') and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD not in ('STORE', 'COMPANY')
			-- )
 
)
,io_phone_with_groups as
(
    SELECT 
        io_phone.*
        ,SUM(HAS_CHANGE_FG) OVER (
                    PARTITION BY INT_ORG_SID
                    ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                )                as GROUP_ID
    FROM int_org_phone io_phone
)
SELECT 
    INT_ORG_SID
    ,min(VAL_FROM)     as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)       as DWH_VALID_TO_TMSP
    ,PHONE_NR
FROM io_phone_with_groups
GROUP BY
    INT_ORG_SID
    ,PHONE_NR
    ,GROUP_ID
;