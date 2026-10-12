DELETE FROM ETL.T_R2D_INTERNAL_ORGANIZATION_STATUS;

INSERT INTO ETL.T_R2D_INTERNAL_ORGANIZATION_STATUS
(
    INT_ORG_SID				
    ,DWH_VALID_FROM_TMSP	
    ,DWH_VALID_TO_TMSP		
    ,INT_ORG_STATUS_CD		
    ,INT_ORG_STATUS_DESCR_DE
)
with 
party_status as
(
    SELECT
        io.INT_ORG_SID
        ,greatest(io.DWH_VALID_FROM_TMSP, ps.DWH_VALID_FROM_TMSP)     as VAL_FROM
        ,least(io.DWH_VALID_TO_TMSP, ps.DWH_VALID_TO_TMSP)            as VAL_TO
        ,pst_de.PARTY_STATUS_TYPE_CD                                  as INT_ORG_STATUS_CD
        ,pst_de.PARTY_STATUS_TYPE_DESCR                               as INT_ORG_STATUS_DESCR_DE
        
        ,lead(pst_de.PARTY_STATUS_TYPE_CD) 
                over (PARTITION BY io.INT_ORG_SID, io.DWH_VALID_TO_TMSP
                    ORDER BY VAL_FROM asc)                            as PREV_INT_ORG_STATUS_CD
        ,CASE
                WHEN PREV_INT_ORG_STATUS_CD = INT_ORG_STATUS_CD THEN 0
                ELSE 1
            END                                                       as HAS_CHANGE_FG
    FROM core_rel.T_INTERNAL_ORGANIZATION io
        join core_rel.T_PARTY_STATUS ps 
                    on ps.PARTY_SID = io.INT_ORG_SID
                    and ps.PARTY_TYPE_CD = 'INT_ORG'
                    and ps.DWH_VALID_FROM_TMSP <= io.DWH_VALID_TO_TMSP
                    and ps.DWH_VALID_TO_TMSP >= io.DWH_VALID_FROM_TMSP
        join core_rel.T_PARTY_STATUS_TYPE pst_de
                    on pst_de.PARTY_STATUS_TYPE_CD = ps.PARTY_STATUS_TYPE_CD
                    and pst_de.LANG_CD = 'DE'
    --temp just for test to see how lisy-only data looks 
	-- WHERE 1=1
		-- and (
				-- (io.INT_ORG_TYPE_CD in ('STORE', 'COMPANY') and io.DWH_NODE_CD <> 'P_LEW_CORE')
				-- or io.INT_ORG_TYPE_CD not in ('STORE', 'COMPANY')
			-- )
)
,ps_with_groups as
(
    SELECT 
        ps.*
        ,SUM(HAS_CHANGE_FG)
            over(PARTITION BY INT_ORG_SID
                ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )                                                as GROUP_ID
    FROM party_status ps
)
SELECT 
    INT_ORG_SID
    ,min(VAL_FROM)             as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)               as DWH_VALID_TO_TMSP
    ,INT_ORG_STATUS_CD
    ,INT_ORG_STATUS_DESCR_DE
FROM ps_with_groups 
GROUP BY 
    INT_ORG_SID
    ,INT_ORG_STATUS_CD
    ,INT_ORG_STATUS_DESCR_DE
    ,GROUP_ID
;
