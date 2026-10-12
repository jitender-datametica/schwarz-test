--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_lagerort
(
  mandant_id,
  lagerort_id,
  wup_id,
  nb_id,
  lagernummer_id
)
SELECT
  mandant_id,
  '' as lagerort_id,
  wup_id,
  nb_id,
  ''
FROM ${TEMP_TABLE}/*DBP_ETL.l_lagerort_temp*/ t1
WHERE nb_id in (99,-111)
AND (mandant_id,lagerort_id,wup_id)
NOT IN
   (SELECT  mandant_id,lagerort_id,wup_id
    FROM   DBP_DATA.l_lagerort t2
    WHERE nb_id in (99,-111)    
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_lagerort
(
  mandant_id,
  lagerort_id,
  wup_id,
  nb_id,
  lagernummer_id
)
SELECT
  mandant_id,
  '-1' as lagerort_id,
  wup_id,
  nb_id,
  ''
FROM ${TEMP_TABLE}/*DBP_ETL.l_lagerort_temp*/ t1
WHERE nb_id in (99,-111)
AND (mandant_id,lagerort_id,wup_id)
NOT IN
   (SELECT  mandant_id,lagerort_id,wup_id
    FROM   DBP_DATA.l_lagerort t2
    WHERE nb_id in (99,-111)    
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_lagerort
(
  mandant_id,
  lagerort_id,
  wup_id,
  nb_id,
  lagernummer_id
)
SELECT
  mandant_id,
  '-2' as lagerort_id,
  wup_id,
  nb_id,
  ''
FROM ${TEMP_TABLE} /*DBP_ETL.l_lagerort_temp*/ t1
WHERE nb_id in (99,-111)
AND (mandant_id,lagerort_id,wup_id)
NOT IN
   (SELECT  mandant_id,lagerort_id,wup_id
    FROM   DBP_DATA.l_lagerort t2
    WHERE nb_id in (99,-111)    
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_lagerort
(
  mandant_id,
  lagerort_id,
  wup_id,
  nb_id,
  lagernummer_id
)
SELECT
  mandant_id,
  '-3' as lagerort_id,
  wup_id,
  nb_id,
  ''
FROM ${TEMP_TABLE} /*DBP_ETL.l_lagerort_temp*/ t1
WHERE nb_id in (99,-111)
AND (mandant_id,lagerort_id,wup_id)
NOT IN
   (SELECT  mandant_id,lagerort_id,wup_id
    FROM   DBP_DATA.l_lagerort t2
    WHERE nb_id in (99,-111)    
);

