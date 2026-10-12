--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.tag_stunde;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBP_DATA.tag_stunde;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--original statement
--locking table DBX_DATA.tag for access
--locking table DBX_DATA.zeit for access
--INSERT INTO DBX_DATA.tag_stunde
--SELECT DISTINCT
--  v01.dat
--  ,v02.zeit_stunde AS stunde
--  ,CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00'AS stunde_minuten
--  ,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00:00') AS TIMESTAMP(0) FORMAT 'yyyy-mm-ddBhh:mi:ss') AS dat_zeit
--FROM 
--DBX_DATA.tag v01 --dbp_view.v_tag 
--cross join DBX_DATA.zeit v02 --dbp_view.v_zeit
--WHERE v02.zeit_minute = 0
---- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!
--AND EXTRACT(HOUR FROM dat_zeit) = v02.zeit_stunde
--AND dat between date-2000 and date --order by 1 desc
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_DATA.tag_stunde
SELECT DISTINCT
  v01.dat
  ,v02.zeit_stunde AS stunde
  --,CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00'AS stunde_minuten
  --mfialkiewicz
  ,lpad(cast(v02.zeit_stunde AS CHAR(2)),2,0)||':00'AS stunde_minuten
  --,CAST(v01.dat||' '||(CAST((v02.zeit_stunde (FORMAT '99')) AS CHAR(2))||':00:00') AS TIMESTAMP(0) FORMAT 'yyyy-mm-ddBhh:mi:ss') AS dat_zeit
  --mfialkiewicz
  , to_timestamp(CAST(v01.dat||' '||lpad(cast(v02.zeit_stunde AS CHAR(2)),2,0)||':00:00' AS char(19)),'yyyy-mm-dd hh:mi:ss') as dat_zeit 
  ,localtimestamp
  ,localtimestamp
FROM 
DBP_DATA.tag v01 --dbp_view.v_tag 
cross join DBP_DATA.zeit v02 --dbp_view.v_zeit
WHERE v02.zeit_minute = 0
-- Bei Zeitumstellung von Winter- auf Sommerzeit wichtig!
AND EXTRACT(HOUR FROM dat_zeit) = v02.zeit_stunde
AND dat between CURRENT_DATE-2000 and CURRENT_DATE --order by 1 desc
;

