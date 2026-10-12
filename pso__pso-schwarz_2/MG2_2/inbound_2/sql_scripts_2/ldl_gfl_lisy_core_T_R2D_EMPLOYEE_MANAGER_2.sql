DELETE FROM ETL.T_R2D_EMPLOYEE_MANAGER_2;

INSERT INTO ETL.T_R2D_EMPLOYEE_MANAGER_2
with 
employee_manager as
(
    SELECT 
        emp.PERSON_SID                      as EMP_SID
        ,greatest(emp.DWH_VALID_FROM_TMSP, mgr.DWH_VALID_FROM_TMSP) as VAL_FROM
        ,least(emp.DWH_VALID_TO_TMSP, mgr.DWH_VALID_TO_TMSP) as VAL_TO
        ,mgr.PERSON_SID                     as EMP_MGR_SID
        ,mgr.FIRST_NAME                     as MGR_FIRST_NAME
        ,mgr.FAMILY_NAME                    as MGR_FAMILY_NAME
        ,sha2(
                nvl(to_char(EMP_MGR_SID), '@')
                ||'#&#'||nvl(lower(MGR_FIRST_NAME), 'Unbekannt')
                ||'#&#'||nvl(lower(MGR_FAMILY_NAME), 'Unbekannt')
            )                             as row_hash_for_diff
        
        ,lag(row_hash_for_diff) over (partition by emp.PERSON_SID order by VAL_FROM asc) as prev_row_hash_for_diff
        ,CASE
                WHEN row_hash_for_diff = prev_row_hash_for_diff THEN 0
                ELSE 1
            END                           as HAS_CHANGE_FG
    FROM core_rel.T_PERSON_2 emp
        join core_rel.T_PERSON_2 mgr on emp.MGR_EMP_SID = mgr.PERSON_SID
                                and emp.DWH_VALID_FROM_TMSP <= mgr.DWH_VALID_TO_TMSP
                                and emp.DWH_VALID_TO_TMSP >= mgr.DWH_VALID_FROM_TMSP
                                and mgr.IS_EMP_FG = TRUE
    WHERE emp.IS_EMP_FG = TRUE
)
,em_with_group_ids as
(
    SELECT 
        em.*
        ,SUM(HAS_CHANGE_FG)
            over(PARTITION BY EMP_SID
                ORDER BY VAL_FROM asc, HAS_CHANGE_FG desc
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            )                                                as GROUP_ID
    FROM employee_manager em
)
SELECT
    EMP_SID
    ,min(VAL_FROM)      as DWH_VALID_FROM_TMSP
    ,max(VAL_TO)        as DWH_VALID_TO_TMSP
    ,EMP_MGR_SID
    ,MGR_FAMILY_NAME
    ,MGR_FAMILY_NAME
FROM em_with_group_ids
GROUP BY
    EMP_SID
    ,EMP_MGR_SID
    ,MGR_FAMILY_NAME
    ,MGR_FAMILY_NAME
    ,GROUP_ID
;
