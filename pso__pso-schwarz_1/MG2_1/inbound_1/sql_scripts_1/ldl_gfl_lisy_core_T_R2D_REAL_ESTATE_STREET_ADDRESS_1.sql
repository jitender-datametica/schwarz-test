DELETE FROM ETL.T_R2D_REAL_ESTATE_STREET_ADDRESS_1;


INSERT INTO ETL.T_R2D_REAL_ESTATE_STREET_ADDRESS_1
(
    REAL_ESTATE_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP	
    ,ISO_COUNTRY_CD		
    ,COUNTRY_NAME		
    ,CITY_NAME			
    ,DISTRICT_NAME		
    ,ZIP				
    ,STREET_NAME		
    ,HOUSE_NR			
    ,LON				
    ,LAT				
    ,REPORTING_COUNTRY_CD 
    ,REPORTING_COUNTRY_NAME
)
with 
re_addr as
(
    SELECT 
        re.REAL_ESTATE_SID
        ,greatest(re.DWH_VALID_FROM_TMSP
            ,rea.DWH_VALID_FROM_TMSP
            ,sa.DWH_VALID_FROM_TMSP
        )                                               as VAL_FROM
        , least(re.DWH_VALID_TO_TMSP
            ,rea.DWH_VALID_TO_TMSP
            ,sa.DWH_VALID_TO_TMSP
		)                                               as VAL_TO
        ,sa.ISO_COUNTRY_CD
        ,sa.COUNTRY_NAME
        ,sa.CITY_NAME
        ,sa.DISTRICT_NAME
        ,sa.ZIP
        ,sa.STREET_NAME
        ,sa.HOUSE_NR
        ,sa.LON
        ,sa.LAT
		,CASE
			when re.REAL_ESTATE_NR like 'MT%' then 'MT'
			else sa.REPORTING_COUNTRY_CD						
		END 											as REP_COUNTRY_CD
		,CASE
			when re.REAL_ESTATE_NR like 'MT%' then 'Malta'
			else rc.REPORTING_COUNTRY_NAME						
		END                                             as REP_COUNTRY_NAME

        ,sha2(
            nvl(lower(sa.ISO_COUNTRY_CD), '@')
            ||'#&#'||nvl(lower(sa.COUNTRY_NAME), 'Unbekannt')
            ||'#&#'||nvl(lower(sa.CITY_NAME), '@')
            ||'#&#'||nvl(lower(sa.DISTRICT_NAME), '@')
            ||'#&#'||nvl(lower(sa.ZIP), '@')
            ||'#&#'||nvl(lower(sa.STREET_NAME), '@')
            ||'#&#'||nvl(lower(to_char(sa.HOUSE_NR)), '@')
            ||'#&#'||nvl(to_char(sa.LON), '@')
            ||'#&#'||nvl(to_char(sa.LAT), '@')
			||'#&#'||nvl(lower(REP_COUNTRY_CD), '@')
			||'#&#'||nvl(lower(REP_COUNTRY_NAME), 'Unbekannt')
            ) as row_hash_for_diff
            
        ,lag(row_hash_for_diff) over (partition by re.REAL_ESTATE_SID order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                         as HAS_CHANGE_FG
    FROM core_rel.T_REAL_ESTATE_1 re_1
        join core_rel.T_REAL_ESTATE_ADDRESS_1 rea
                    on re.REAL_ESTATE_SID = rea.REAL_ESTATE_SID
                    and rea.ADDR_TYPE_CD = 'STAD'
                    and rea.ADDR_USG_TYPE_CD = 'SA_MN'
                    and rea.DWH_VALID_FROM_TMSP <= re.DWH_VALID_TO_TMSP
                    and rea.DWH_VALID_TO_TMSP >= re.DWH_VALID_FROM_TMSP
        join core_rel.T_STREET_ADDRESS_1 sa on sa.STREET_ADDR_SID = rea.ADDR_SID
                        and sa.DWH_VALID_FROM_TMSP <= least(re.DWH_VALID_TO_TMSP,
                                                            rea.DWH_VALID_TO_TMSP
                                                         )
                        and sa.DWH_VALID_TO_TMSP >= greatest(re.DWH_VALID_FROM_TMSP,
                                                            rea.DWH_VALID_FROM_TMSP
                                                          )
		join core_rel.T_REPORTING_COUNTRY_1 rc on sa.REPORTING_COUNTRY_CD = rc.REPORTING_COUNTRY_CD
)
,re_addr_with_groups as
(
    SELECT 
        re_addr.*
        ,SUM(HAS_CHANGE_FG) OVER (
                    PARTITION BY REAL_ESTATE_SID
                    ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                )                as GROUP_ID
    FROM re_addr
)
SELECT 
    REAL_ESTATE_SID
    ,min(VAL_FROM)         as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)           as DWH_VALID_TO_TMSP
    ,ISO_COUNTRY_CD
    ,COUNTRY_NAME
    ,CITY_NAME
    ,DISTRICT_NAME
    ,ZIP
    ,STREET_NAME
    ,HOUSE_NR
    ,LON
    ,LAT
    ,REP_COUNTRY_CD        as REPORTING_COUNTRY_CD 
    ,REP_COUNTRY_NAME      as REPORTING_COUNTRY_NAME
FROM re_addr_with_groups
GROUP BY
    REAL_ESTATE_SID
    ,ISO_COUNTRY_CD
    ,COUNTRY_NAME
    ,CITY_NAME
    ,DISTRICT_NAME
    ,ZIP
    ,STREET_NAME
    ,HOUSE_NR
    ,LON
    ,LAT
    ,REP_COUNTRY_CD
    ,REP_COUNTRY_NAME
    ,GROUP_ID
;
