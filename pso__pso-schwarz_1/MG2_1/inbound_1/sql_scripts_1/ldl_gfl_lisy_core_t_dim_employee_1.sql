DELETE FROM core_dim.t_dim_employee_1;


-- Dummy_1 row
INSERT INTO core_dim.T_DIM_EMPLOYEE_1 
(
    EMP_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    
    ,FIRST_NAME
    ,FAMILY_NAME
    ,GENDER_CD
    ,GENDER_NAME
    
    ,EMP_NR
    ,BUYER_NR
    ,CASHIER_NR

    ,EMP_STATUS_TYPE_CD
    ,EMP_STATUS_TYPE_DESCR
    ,HIRE_DT
    ,TERM_DT
    
    ,MGR_EMP_SID
    ,MGR_FIRST_NAME
    ,MGR_FAMILY_NAME
    
    ,IS_BUYER_FG
    ,IS_DATA_STEWARD_FG
    ,IS_CASHIER_FG
    
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
VALUES
(
    -1,
    to_timestamp('1900-01-01'),
    to_timestamp('9999-12-31 23:59:59.999999999'),
    true,
    
    'Unbekannt',
    'Unbekannt',
    'U',
    'Unbekannt',
    
    '@',
    '@',
    '@',
    
    '@',
    'Unbekannt',
    '0001-01-01',
    null,
    
    -1,
    'Unbekannt',
    'Unbekannt',
    
    false,
    false,
    false,
    
    current_timestamp,
    current_timestamp,
    -1,
    'MANUAL'
);

INSERT INTO core_dim.T_DIM_EMPLOYEE_1 
(
    EMP_SID
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    
    ,FIRST_NAME
    ,FAMILY_NAME
    ,GENDER_CD
    ,GENDER_NAME
    
    ,EMP_NR
    ,BUYER_NR
    ,CASHIER_NR

    ,EMP_STATUS_TYPE_CD
    ,EMP_STATUS_TYPE_DESCR
    ,HIRE_DT
    ,TERM_DT
    
    ,MGR_EMP_SID
    ,MGR_FIRST_NAME
    ,MGR_FAMILY_NAME
    
    ,IS_BUYER_FG
    ,IS_DATA_STEWARD_FG
    ,IS_CASHIER_FG
    
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with
validity_listing(PERSON_SID, DWH_MAPPING_TMSP) as
(
    -- Employee_1
    SELECT 
        e.PERSON_SID
        ,e.DWH_VALID_FROM_TMSP
    FROM core_rel.T_PERSON_1 e
    WHERE e.IS_EMP_FG = TRUE
    UNION
    SELECT 
        e.PERSON_SID
        ,decode(e.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999',  e.DWH_VALID_TO_TMSP, DATEADD(ns, 1, e.DWH_VALID_TO_TMSP))
    FROM core_rel.T_PERSON_1 e
    WHERE e.IS_EMP_FG = TRUE

    UNION
    
    -- Person's Manager
    SELECT 
        e.EMP_SID
        ,e.DWH_VALID_FROM_TMSP
    FROM etl.T_R2D_EMPLOYEE_MANAGER_1 e
    UNION
    SELECT 
        e.EMP_SID
        ,decode(e.DWH_VALID_TO_TMSP, '9999-12-31 23:59:59.999999999',  e.DWH_VALID_TO_TMSP, DATEADD(ns, 1, e.DWH_VALID_TO_TMSP))
    FROM etl.T_R2D_EMPLOYEE_MANAGER_1 e
    
    UNION

    -- default 
    SELECT 
        e.PERSON_SID
        ,'1900-01-01'::TIMESTAMP
    FROM core_rel.T_PERSON_1 e
    WHERE e.IS_EMP_FG = TRUE
)
SELECT 
    emp.PERSON_SID            as EMP_SID
    
    ,vl.DWH_MAPPING_TMSP      as VAL_FROM
    ,lead(dateadd(ns, -1, vl.DWH_MAPPING_TMSP),1,'9999-12-31 23:59:59.999999999') 
                over (partition by vl.PERSON_SID order by vl.DWH_MAPPING_TMSP asc)    as VAL_TO
    ,(current_timestamp between val_from and val_to) as DWH_VALID_FG

    ,emp.FIRST_NAME
    ,emp.FAMILY_NAME
    ,emp.GENDER_CD
    ,empg_de.GENDER_NAME
    ,nvl(emp.EMP_NR,'@')                                         as EMP_NR
    ,nvl(emp.cashier_nr, '@')                                    as CASHIER_NR
    ,nvl(emp.buyer_nr, '@')                                      as BUYER_NR
    ,nvl(pst_de.PARTY_STATUS_TYPE_CD, '@')                       as EMP_STATUS_TYPE_CD
    ,nvl(pst_de.PARTY_STATUS_TYPE_DESCR, 'Unbekannt')            as EMP_STATUS_TYPE_DESCR
    ,nvl(emp.HIRE_DT, '0001-01-01')                              as HIRE_DT
    ,emp.TERM_DT
    ,nvl(emp_mgr.EMP_MGR_SID, -1)                                     as MANAGER_EMP_SID
    ,nvl(emp_mgr.EMP_MGR_FIRST_NAME, 'Unbekannt')                            as MANAGER_FIRST_NAME
    ,nvl(emp_mgr.EMP_MGR_FAMILY_NAME, 'Unbekannt')                           as MANAGER_FAMILY_NAME
    ,emp.IS_BUYER_FG
    ,emp.IS_DATA_STEWARD_FG
    ,emp.IS_CASHIER_FG
    ,current_timestamp
    ,current_timestamp
    ,-1
    ,'MANUAL'
FROM validity_listing vl
    left join core_rel.T_PERSON_1 emp on vl.PERSON_SID = emp.PERSON_SID
                    and vl.DWH_MAPPING_TMSP between emp.DWH_VALID_FROM_TMSP and emp.DWH_VALID_TO_TMSP
    
    left join etl.T_R2D_EMPLOYEE_MANAGER_1 emp_mgr on vl.PERSON_SID = emp_mgr.EMP_SID
                    and vl.DWH_MAPPING_TMSP between emp_mgr.DWH_VALID_FROM_TMSP and emp_mgr.DWH_VALID_TO_TMSP
                    
    left join core_rel.T_GENDER_1 empg_de on empg_de.GENDER_CD = emp.GENDER_CD
                    and empg_de.LANG_CD = 'DE'
    left join core_rel.T_PARTY_STATUS_1 ps on ps.PARTY_SID = vl.PERSON_SID
                    and vl.DWH_MAPPING_TMSP between ps.DWH_VALID_FROM_TMSP and ps.DWH_VALID_TO_TMSP
    left join core_rel.T_PARTY_STATUS_TYPE_1 pst_de on pst_de.PARTY_STATUS_TYPE_CD = ps.PARTY_STATUS_TYPE_CD
                    and pst_de.LANG_CD = 'DE'
WHERE vl.DWH_MAPPING_TMSP < '9999-12-31 23:59:59.999999999'
;
