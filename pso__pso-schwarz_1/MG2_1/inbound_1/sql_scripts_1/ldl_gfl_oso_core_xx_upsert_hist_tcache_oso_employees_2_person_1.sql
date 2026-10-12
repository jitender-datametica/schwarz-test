INSERT INTO   ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
      party_nat_key_nr,
      person_key_type_cd,
      FIRST_NAME,
      FAMILY_NAME,
	  GENDER_CD,
      BIRTH_DT,
      IS_CUST_FG,
      IS_EMP_FG,
      IS_BUYER_FG,
      IS_DATA_STEWARD_FG,
      IS_CASHIER_FG,
      EMP_NR,
      BUYER_NR,
      HIRE_DT,
      TERM_DT,
      MGR_EMP_SID,
--    FRAMEWORK AND TECHNICAL COLUMNS
      SOURCE_SYSTEM,
      EXTRACTION_DT,
      DWH_MAPPING_TMSP,      
      TF_ERROR_FG,
      DELETED_FG,
      RECORD_ID,
      FILENAME,
      DWH_NODE_CD,
      DWH_LOAD_ID)
  select lower(empl.mail) as party_nat_key_nr -- look up PERSON_SID in t_party_sid where party_key_type_cd = 'PERSON'
     , 'PERSON' as person_key_type_cd
     , translate(empl.firstname , sc.country_from_special_char_list || lower(sc.country_from_special_char_list)
                                , sc.country_to_special_char_list || lower(sc.country_to_special_char_list)) as FIRST_NAME
     , translate(empl.lastname, sc.country_from_special_char_list || lower(sc.country_from_special_char_list)
                              , sc.country_to_special_char_list || lower(sc.country_from_special_char_list)) as FAMILY_NAME
     , 'U' as GENDER_CD
     , null as BIRTH_DT
     , false as IS_CUST_FG
     , true as IS_EMP_FG
     , false as IS_BUYER_FG
     , false as IS_DATA_STEWARD_FG
     , false as IS_CASHIER_FG
     , empl.workforceid as EMP_NR
     , null as BUYER_NR
     , null as HIRE_DT
     , null as TERM_DT
     , null as MGR_EMP_SID
       /*  */
     , 'OSO' AS SOURCE_SYSTEM
     , CURRENT_DATE AS EXTRACTION_DT
     , CURRENT_TIMESTAMP AS DWH_MAPPING_TMSP 
     , 0 AS TF_ERROR_FG
     , 0 AS DELETED_FG
     , 0 AS RECORD_ID
     , 't_${SRC_INPUT_TABLE}' AS FILENAME
     , 'OSO' AS DWH_NODE_CD
     , '${LOAD_ID}' AS DWH_LOAD_ID
from etl.t_tcache_oso_employees_1 as empl
   , etl_process.t_country_special_char_1 as sc
where empl.mail like '%@%'
qualify row_number() over (partition by party_nat_key_nr order by empl.extraction_timestamp desc) = 1
;
