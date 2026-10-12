INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
	STORE_NATURAL_KEY,
        STORE_KEY_TYPE_CD,
	DAY_OF_WEEK,
	OPEN_TM,
	CLOSE_TM,
        BREAK_START_TM,
        BREAK_END_TM,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
WITH OSO_SEL AS (
select
   ods.countrycode
   , flat.value:date::varchar as cal_dt
   , flat.value:isOpen::boolean as open_fg
   , flat.value:timeRanges[0].fromTime::varchar as open_from_tmsp
   , case 
   when flat.value:timeRanges[1].toTime::varchar is not null
   then flat.value:timeRanges[1].toTime::varchar
   else flat.value:timeRanges[0].toTime::varchar
   END as open_until_tmsp
   ,case when flat.value:timeRanges[1].fromTime::varchar is not null
   then flat.value:timeRanges[0].toTime::varchar
   else NULL 
   end as break_start_tm
   , 
   case when flat.value:timeRanges[1].fromTime::varchar is not null
   then flat.value:timeRanges[1].fromTime::varchar
   else NULL 
   end  as break_end_tm
   , flat.value:weekday::varchar as weekday
   , ods.storeorganumber
   , ods.timezone
   , ods.warehouseorganumber
   , ods.extraction_timestamp
from etl.t_tcache_oso_openinghours_2 as ods
, LATERAL FLATTEN(ods.openinghours) as flat
where open_fg
qualify row_number() over (partition by countrycode, cal_dt, storeorganumber order by extraction_timestamp desc) = 1
)
SELECT 
        COUNTRYCODE || '|' || STOREORGANUMBER AS STORE_NATURAL_KEY,
        'STORE' AS STORE_KEY_TYPE_CD,
        CASE
        WHEN WEEKDAY = 'MONDAY' THEN 1
        WHEN WEEKDAY = 'TUESDAY' THEN 2
        WHEN WEEKDAY = 'WEDNESDAY' THEN 3
        WHEN WEEKDAY = 'THURSDAY' THEN 4
        WHEN WEEKDAY = 'FRIDAY' THEN 5
        WHEN WEEKDAY = 'SATURDAY' THEN 6
        WHEN WEEKDAY = 'SUNDAY' THEN 7
        END AS DAY_OF_WEEK,
        OPEN_FROM_TMSP AS OPEN_TM,
        OPEN_UNTIL_TMSP AS CLOSE_TM,
        BREAK_START_TM,
        BREAK_END_TM,
        'OSO' AS SOURCE_SYSTEM,
        CURRENT_DATE AS EXTRACTION_DT,
        MIN(CAL_DT) AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
       't_${SRC_INPUT_TABLE}' AS FILENAME,
       'OSO' AS DWH_NODE_CD,
       '${LOAD_ID}' AS DWH_LOAD_ID
FROM OSO_SEL
    INNER JOIN CORE_REL.T_INTERNAL_ORGANIZATION_2 IO
        ON OSO_SEL.COUNTRYCODE || STOREORGANUMBER = IO.INT_ORG_NR
        AND IO.DWH_VALID_FG
GROUP BY
        STORE_NATURAL_KEY
        , DAY_OF_WEEK
        , OPEN_TM
        , CLOSE_TM
        , BREAK_START_TM
        , BREAK_END_TM;
