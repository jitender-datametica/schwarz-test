
DELETE FROM  etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2;

INSERT into etl.T_R2D_REAL_ESTATE_INTERNAL_ORGANIZATION_2
(
    REAL_ESTATE_SID
    ,INT_ORG_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,CURR_INT_ORG_NR
    ,INT_ORG_NAME
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
)
with
reio as
(
	SELECT
        iore.REAL_ESTATE_SID
		,io.INT_ORG_SID
		,greatest(iore.DWH_VALID_FROM_TMSP, 
					io.DWH_VALID_FROM_TMSP, 
					nvl(re.DWH_VALID_FROM_TMSP, iore.DWH_VALID_FROM_TMSP) 
					) as VAL_FROM
		,least(iore.DWH_VALID_TO_TMSP, 
				io.DWH_VALID_TO_TMSP, 
				nvl(re.DWH_VALID_TO_TMSP, iore.DWH_VALID_TO_TMSP)
				) as VAL_TO
		,io.INT_ORG_NR as CURR_INT_ORG_NR
		,io.INT_ORG_NAME
		,io.INT_ORG_TYPE_CD
		,iot.INT_ORG_TYPE_DESCR
		,CASE	
			WHEN count(distinct ret.REAL_ESTATE_TYPE_CD) over (partition by iore.int_org_sid, iore.dwh_valid_from_tmsp) > 1 then 'BOTH'
			ELSE nvl(ret.REAL_ESTATE_TYPE_CD, '@')
		END AS STORE_REAL_ESTATE_TYPE_CD
		,CASE
			WHEN count(distinct ret.REAL_ESTATE_TYPE_CD) over (partition by iore.int_org_sid, iore.dwh_valid_from_tmsp) > 1 then 'Filiale und Sonderverkauf'
			ELSE nvl(ret.REAL_ESTATE_TYPE_DESCR, 'Unbekannt')
		END AS STORE_REAL_ESTATE_TYPE_DESCR
	    
        ,sha2(
            nvl(to_char(io.INT_ORG_SID),-1)
            ||'#&#'||nvl(lower(CURR_INT_ORG_NR),'@')
            ||'#&#'||nvl(lower(INT_ORG_NAME),'Unbekannt')
            ||'#&#'||nvl(lower(io.INT_ORG_TYPE_CD),'@')
            ||'#&#'||nvl(lower(INT_ORG_TYPE_DESCR),'Unbekannt')
			||'#&#'||nvl(lower(ret.REAL_ESTATE_TYPE_CD),'@')
            ||'#&#'||nvl(lower(ret.REAL_ESTATE_TYPE_DESCR),'Unbekannt')
        )                                        as row_hash_for_diff
        ,lag(row_hash_for_diff) over (partition by iore.REAL_ESTATE_SID order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                           as HAS_CHANGE_FG
	FROM core_rel.T_INTERNAL_ORGANIZATION_REAL_ESTATE_2 iore
        join core_rel.T_INTERNAL_ORGANIZATION_2 io
                    on io.INT_ORG_SID = iore.INT_ORG_SID
                    and io.DWH_VALID_FROM_TMSP <= iore.DWH_VALID_TO_TMSP
                    and io.DWH_VALID_TO_TMSP >= iore.DWH_VALID_FROM_TMSP
					and iore.INT_ORG_REAL_ESTATE_USG_TYPE_CD = 'USED_BY'
		join core_rel.t_internal_organization_type_2 iot
			        on io.int_org_type_cd = iot.int_org_type_cd
			        and iot.lang_cd = 'DE'
		left join core_rel.T_REAL_ESTATE_2 re_2
					on re.REAL_ESTATE_SID = iore.REAL_ESTATE_SID
					and re.DWH_VALID_FROM_TMSP <= least(iore.DWH_VALID_TO_TMSP, io.DWH_VALID_TO_TMSP)
					and re.DWH_VALID_TO_TMSP >= greatest(iore.DWH_VALID_FROM_TMSP, io.DWH_VALID_FROM_TMSP)
		left join core_rel.T_REAL_ESTATE_TYPE_2 ret
					on ret.REAL_ESTATE_TYPE_CD = re.REAL_ESTATE_TYPE_CD
					and ret.LANG_CD = 'DE'
    --temp just for test_2 to see how lisy-only data looks 
	-- WHERE 1=1
		-- and (
				-- (io.INT_ORG_TYPE_CD in ('STORE', 'COMPANY') and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD not in ('STORE', 'COMPANY')
			-- )
)
,reio_with_groups as
(
    SELECT 
        reio.*
        ,SUM(HAS_CHANGE_FG)
            over(PARTITION BY REAL_ESTATE_SID
                ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )                                                as GROUP_ID
    FROM reio
)
SELECT
    REAL_ESTATE_SID
    ,INT_ORG_SID
    ,min(VAL_FROM)        as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)          as DWH_VALID_TO_TMSP
    ,CURR_INT_ORG_NR
    ,INT_ORG_NAME
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
FROM reio_with_groups
GROUP BY
    REAL_ESTATE_SID
    ,INT_ORG_SID
    ,CURR_INT_ORG_NR
    ,INT_ORG_NAME
    ,INT_ORG_TYPE_CD
    ,INT_ORG_TYPE_DESCR
	,STORE_REAL_ESTATE_TYPE_CD
	,STORE_REAL_ESTATE_TYPE_DESCR
    ,GROUP_ID
;
