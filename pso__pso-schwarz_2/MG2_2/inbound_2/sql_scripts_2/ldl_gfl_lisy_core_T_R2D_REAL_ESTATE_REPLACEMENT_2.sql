DELETE FROM etl.T_R2D_REAL_ESTATE_REPLACEMENT_2;

INSERT into etl.T_R2D_REAL_ESTATE_REPLACEMENT_2
(
    REAL_ESTATE_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,REPLACEMENT_REAL_ESTATE_SID
    ,REPLACEMENT_REAL_ESTATE_NR
    ,REPLACEMENT_REAL_ESTATE_NAME
    ,REAL_ESTATE_REPLACEMENT_TYPE_CD
    ,REAL_ESTATE_REPLACEMENT_TYPE_DESCR
)
with 
repl as
(
    SELECT 
		rr.REAL_ESTATE_SID
		,rr.REPLACEMENT_REAL_ESTATE_SID
		,greatest(rr.dwh_valid_from_tmsp,r.dwh_valid_from_tmsp)    as VAL_FROM
    	,least(rr.dwh_valid_to_tmsp ,r.dwh_valid_to_tmsp)          as VAL_TO
		,r.real_estate_nr                                          as REPLACEMENT_REAL_ESTATE_NR
		,r.real_estate_name                                        as REPLACEMENT_REAL_ESTATE_NAME
		,rert.REAL_ESTATE_REPLACEMENT_TYPE_CD
		,rert.REAL_ESTATE_REPLACEMENT_TYPE_DESCR

        ,sha2(
            nvl(to_char(rr.REPLACEMENT_REAL_ESTATE_SID),-1)
            ||'#&#'||nvl(lower(REPLACEMENT_REAL_ESTATE_NR),'@')
            ||'#&#'||nvl(lower(REPLACEMENT_REAL_ESTATE_NAME),'Unbekannt')
            ||'#&#'||nvl(lower(rert.REAL_ESTATE_REPLACEMENT_TYPE_CD),'@')
            ||'#&#'||nvl(lower(rert.REAL_ESTATE_REPLACEMENT_TYPE_DESCR),'Unbekannt')
        )                                        as row_hash_for_diff
        ,lag(row_hash_for_diff) over (partition by rr.REAL_ESTATE_SID order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                           as HAS_CHANGE_FG
	FROM core_rel.t_real_estate_replacement_2 rr
		join core_rel.t_real_estate_2 r
			    on rr.replacement_real_estate_sid = r.real_estate_sid
				and rr.dwh_valid_from_tmsp <= r.dwh_valid_to_tmsp
				and rr.dwh_valid_to_tmsp >= r.dwh_valid_from_tmsp
		join core_rel.t_real_estate_replacement_type_2 rert 
                on rr.real_estate_replacement_type_cd = rert.real_estate_replacement_type_cd
                and rert.lang_cd = 'DE'
)
,repl_with_groups as
(
    SELECT 
        repl.*
        ,SUM(HAS_CHANGE_FG)
            over(PARTITION BY REAL_ESTATE_SID
                ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )                                                as GROUP_ID
    FROM repl

)
SELECT
    REAL_ESTATE_SID
    ,min(VAL_FROM)                as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)                  as DWH_VALID_TO_TMSP
    ,REPLACEMENT_REAL_ESTATE_SID
    ,REPLACEMENT_REAL_ESTATE_NR
    ,REPLACEMENT_REAL_ESTATE_NAME
    ,REAL_ESTATE_REPLACEMENT_TYPE_CD
    ,REAL_ESTATE_REPLACEMENT_TYPE_DESCR
FROM repl_with_groups
GROUP BY
    REAL_ESTATE_SID
    ,REPLACEMENT_REAL_ESTATE_SID
    ,REPLACEMENT_REAL_ESTATE_NR
    ,REPLACEMENT_REAL_ESTATE_NAME
    ,REAL_ESTATE_REPLACEMENT_TYPE_CD
    ,REAL_ESTATE_REPLACEMENT_TYPE_DESCR
    ,GROUP_ID
;