!SET exit_on_error=True;

MERGE INTO meta.t_user AS tgt
USING ( SELECT k.party_nat_key_nr AS user_name
             , k.party_sid AS emp_sid
             , 'CDWH' AS sys_name
             , 'OSO' as dwh_node_cd
          FROM ( SELECT LOWER(mail) AS party_nat_key_nr
                   FROM etl.t_tcache_oso_employees
                  WHERE mail LIKE '%@%.%'
                QUALIFY ROW_NUMBER() OVER (PARTITION BY party_nat_key_nr ORDER BY extraction_timestamp DESC) = 1
               ) AS empl
          join meta.t_party_key as k
            on empl.party_nat_key_nr = k.party_nat_key_nr
         where k.party_key_type_cd = 'PERSON' 
           AND k.dwh_valid_fg
       ) as SRC
    ON tgt.sys_name = src.sys_name 
   AND tgt.user_name = src.user_name
  WHEN MATCHED AND (tgt.emp_sid <> src.emp_sid) THEN UPDATE SET
       tgt.emp_sid = src.emp_sid
     , tgt.dwh_updated_tmsp = CURRENT_TIMESTAMP()
     , tgt.DWH_LOAD_ID = '${LOAD_ID}'
     , tgt.DWH_NODE_CD = src.dwh_node_cd
  WHEN NOT MATCHED THEN 
       INSERT ( sys_name
              , user_name
              , emp_sid
              , dwh_created_tmsp
              , dwh_updated_tmsp
              , dwh_load_id
              , dwh_node_cd)
       VALUES ( src.sys_name
              , src.user_name 
              , src.emp_sid 
              , CURRENT_TIMESTAMP() 
              , CURRENT_TIMESTAMP() 
              , '${LOAD_ID}' 
              , dwh_node_cd);
