--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM KFL_PRODUCTION.DBX_DATA.tag_stunde_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated stateme nt



TRUNCATE TABLE KFL_PRODUCTION_DBP_DATA.TAG_STUNDE_2;


--[not OK] statement is not translated correctly-----------------------------------------------------------------


--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


--original statement


--locking table DBX_DATA.tag_2 for access


--locking table DBX_DATA.zeit_2 for access


--INSERT INTO KFL_PRODUCTION.DBX_DATA.tag_stunde_2


--SELECT DISTINCT


--  v01.dat


--  ,v02.zeit_stunde AS stunde


--  ,CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00'AS stunde_minuten


--  ,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00:00') AS TIMESTAMP(0) FORMAT 'yyyy-mm_2-ddBhh:mi:ss') AS dat_zeit


--FROM 


--DBX_DATA.tag_2 v01 --dbp_view.v_tag_2 


--cross join KFL_PRODUCTION.DBX_DATA.zeit_2 v02 --dbp_view.v_zeit_2


--WHERE v02.zeit_minute = 0


---- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!


--AND EXTRACT(HOUR FROM dat_zeit) = v02.zeit_stunde


--AND dat between date-2000 and date --order by 1 desc


--;


--


--Comment from validation checker


--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.


--translated statement


INSERT INTO KFL_PRODUCTION_DBP_DATA.TAG_STUNDE_2
(SELECT DISTINCT V01.DAT,
  V02.ZEIT_STUNDE AS STUNDE,
  --,CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00'AS stunde_minuten


--mfialkiewicz
   LPAD(SUBSTR(CAST(V02.ZEIT_STUNDE AS STRING), 1, 2), 2, '0') || ':00' AS STUNDE_MINUTEN,
   --,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00:00') AS TIMESTAMP(0) FORMAT 'yyyy-mm_2-ddBhh:mi:ss') AS dat_zeit


--mfialkiewicz
  PARSE_DATETIME('%F %I:%M:%S', SUBSTR(CAST(CAST(V01.DAT AS STRING) || ' ' || LPAD(SUBSTR(CAST(V02.ZEIT_STUNDE AS STRING)
         , 1, 2), 2, '0') || ':00:00' AS STRING), 1, 19)) AS DAT_ZEIT,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM KFL_PRODUCTION_DBP_DATA.TAG_2 AS V01--dbp_view.v_tag_2 
  INNER JOIN KFL_PRODUCTION_DBP_DATA.ZEIT_2 AS V02 ON TRUE --dbp_view.v_zeit_2
 WHERE V02.ZEIT_MINUTE = 0
-- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!
  AND EXTRACT(HOUR FROM PARSE_DATETIME('%F %I:%M:%S', SUBSTR(CAST(CAST(V01.DAT AS STRING) || ' ' || LPAD(SUBSTR(CAST(V02.ZEIT_STUNDE AS STRING)
           , 1, 2), 2, '0') || ':00:00' AS STRING), 1, 19))) = V02.ZEIT_STUNDE
  AND V01.DAT BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2000 DAY) AND (CURRENT_DATE));
--order by 1 desc