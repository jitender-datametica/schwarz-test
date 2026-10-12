DELETE FROM ETL.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS;


INSERT INTO ETL.T_R2D_INTERNAL_ORGANIZATION_STREET_ADDRESS
(
    INT_ORG_SID
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
int_org_addr as
(
    SELECT 
        io.INT_ORG_SID
        ,greatest(io.DWH_VALID_FROM_TMSP
            ,pa.DWH_VALID_FROM_TMSP
            ,sa.DWH_VALID_FROM_TMSP
        )                                               as VAL_FROM
        , least(io.DWH_VALID_TO_TMSP
            ,pa.DWH_VALID_TO_TMSP
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
			when io.INT_ORG_NR like 'MT%' then 'MT'
			else sa.REPORTING_COUNTRY_CD						
		END 											as REP_COUNTRY_CD
		,CASE
			when io.INT_ORG_NR like 'MT%' then 'Malta'
			else rc.REPORTING_COUNTRY_NAME						
		END                                             as REP_COUNTRY_NAME

        ,sha2(
            nvl(lower(sa.ISO_COUNTRY_CD), '@')
            ||'#&#'||nvl(sa.COUNTRY_NAME, 'Unbekannt')
            ||'#&#'||nvl(sa.CITY_NAME, '@')
            ||'#&#'||nvl(sa.DISTRICT_NAME, '@')
            ||'#&#'||nvl(sa.ZIP, '@')
            ||'#&#'||nvl(sa.STREET_NAME, '@')
            ||'#&#'||nvl(to_char(sa.HOUSE_NR), '@')
            ||'#&#'||nvl(to_char(sa.LON), '@')
            ||'#&#'||nvl(to_char(sa.LAT), '@')
			||'#&#'||nvl(REP_COUNTRY_CD, '@')
			||'#&#'||nvl(REP_COUNTRY_NAME, 'Unbekannt')
            ) as row_hash_for_diff
            
        ,lag(row_hash_for_diff) over (partition by io.INT_ORG_SID order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                         as HAS_CHANGE_FG
    FROM core_rel.T_INTERNAL_ORGANIZATION io
        join core_rel.T_PARTY_ADDRESS pa
                    on io.INT_ORG_SID = pa.PARTY_SID
                    and pa.ADDR_TYPE_CD = 'STAD'
                    and pa.ADDR_USG_TYPE_CD = 'SA_MN'
                    and pa.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                    and pa.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
        join core_rel.T_STREET_ADDRESS sa on sa.STREET_ADDR_SID = pa.ADDR_SID
                        and sa.DWH_VALID_FROM_TMSP <= least(io.DWH_VALID_TO_TMSP,
                                                            pa.DWH_VALID_TO_TMSP
                                                         )
                        and sa.DWH_VALID_TO_TMSP >= greatest(io.DWH_VALID_FROM_TMSP,
                                                            pa.DWH_VALID_FROM_TMSP
                                                          )
		join core_rel.T_REPORTING_COUNTRY rc on sa.REPORTING_COUNTRY_CD = rc.REPORTING_COUNTRY_CD
    --temp just for test to see how lisy-only data looks 
	-- WHERE 1=1
		-- and (
				-- (io.INT_ORG_TYPE_CD in ('STORE', 'COMPANY') and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD not in ('STORE', 'COMPANY')
			-- )
)
,io_addr_with_groups as
(
    SELECT 
        io_addr.*
        ,SUM(HAS_CHANGE_FG) OVER (
                    PARTITION BY INT_ORG_SID
                    ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                )                as GROUP_ID
    FROM int_org_addr io_addr
)
SELECT 
    INT_ORG_SID
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
FROM io_addr_with_groups
GROUP BY
    INT_ORG_SID
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
