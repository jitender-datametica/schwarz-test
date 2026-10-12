DELETE FROM ETL.T_R2D_REAL_ESTATE_PHONE_1;

INSERT INTO ETL.T_R2D_REAL_ESTATE_PHONE_1
(
    REAL_ESTATE_SID			
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP	
    ,PHONE_NR			
)
with 
re_phone as
(
    SELECT 
        re.REAL_ESTATE_SID
		,greatest(re.DWH_VALID_FROM_TMSP
            ,rea.DWH_VALID_FROM_TMSP
            ,tn.DWH_VALID_FROM_TMSP
		)                                       as VAL_FROM
		,least(re.DWH_VALID_TO_TMSP
            ,rea.DWH_VALID_TO_TMSP
            ,tn.DWH_VALID_TO_TMSP
		)                                       as VAL_TO
		,tn.PHONE_NR                            as PHONE_NR
        
        ,lag(PHONE_NR) over (
                PARTITION BY re.REAL_ESTATE_SID
                ORDER BY VAL_FROM ASC
            )                                   as PREV_PHONE_NR
        ,CASE
                WHEN PREV_PHONE_NR = PHONE_NR THEN 0
                ELSE 1
            END                                 as HAS_CHANGE_FG
    FROM core_rel.T_REAL_ESTATE_1 re_1
        join core_rel.T_REAL_ESTATE_ADDRESS_1 rea on rea.REAL_ESTATE_SID = re.REAL_ESTATE_SID
                    and rea.ADDR_TYPE_CD = 'TEL'
                    and rea.ADDR_USG_TYPE_CD = 'TL_MN'
                    and rea.DWH_VALID_FROM_TMSP <= re.DWH_VALID_TO_TMSP
                    and rea.DWH_VALID_TO_TMSP >= re.DWH_VALID_FROM_TMSP
        join core_rel.T_TELEPHONE_NUMBER_1 tn on rea.ADDR_SID = tn.PHONE_NR_SID
                    and tn.DWH_VALID_FROM_TMSP <= least(re.DWH_VALID_TO_TMSP
                                                        ,rea.DWH_VALID_TO_TMSP
                                                     )
                    and tn.DWH_VALID_TO_TMSP >= greatest(re.DWH_VALID_FROM_TMSP
                                                        ,rea.DWH_VALID_FROM_TMSP
                                                      ) 
)
,re_phone_with_groups as
(
    SELECT 
        re_phone.*
        ,SUM(HAS_CHANGE_FG) OVER (
                    PARTITION BY REAL_ESTATE_SID
                    ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                )                as GROUP_ID
    FROM re_phone
)
SELECT 
    REAL_ESTATE_SID
    ,min(VAL_FROM)     as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)       as DWH_VALID_TO_TMSP
    ,PHONE_NR
FROM re_phone_with_groups
GROUP BY
    REAL_ESTATE_SID
    ,PHONE_NR
    ,GROUP_ID
;