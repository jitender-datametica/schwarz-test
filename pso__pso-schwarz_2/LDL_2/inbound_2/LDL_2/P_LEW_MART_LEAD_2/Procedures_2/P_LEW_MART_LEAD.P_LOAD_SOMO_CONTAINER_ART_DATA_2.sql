CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_LOAD_SOMO_CONTAINER_ART_DATA()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  19.05.2022    Bialek, Aleksander       Initial Version Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item_2: 291570
#  1.1  02.06.2022    Bachmann, Torsten        Change description of dummy_2 element to "Ohne Container-Zuordnung"
#  1.2  21.06.2022    Bialek, Aleksander       Temporary added additional part fixing the ID's generated with negative values
#  1.3  22.06.2022    Bialek, Aleksander       Fix from 1.2 version worked, no more needed, reverting that change.
#
#----------------------------------------------------------------------------
*/
'

var stmnt = `
/* Get the latest veriosn from precore (we could refer to precore directly since it should have only last version  
the temp table its just to make sure
*/
CREATE TEMPORARY TABLE P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp
as 
SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
, FILE_NAME
, DWH_LOAD_ID
, DWH_CREATED
, DWH_UPDATED
FROM P_LEW_PRECORE.T_CACHE_CONTAINERLISTE_KLAMMERN_2
WHERE DWH_LOAD_ID =(SELECT MAX(DWH_LOAD_ID) FROM P_LEW_PRECORE.T_CACHE_CONTAINERLISTE_KLAMMERN_2);
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* Get the last historized version of the file */
CREATE TEMPORARY TABLE P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_HIST_LAST_VERSION_tmp
as 
SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
, FILE_NAME
, DWH_LOAD_ID
, DWH_CREATED
, DWH_UPDATED
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILES_HIST_2
WHERE DWH_LOAD_ID =(SELECT MAX(DWH_LOAD_ID) FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILES_HIST_2);
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();
	
var stmnt = `
/* Compare current precore version with last historized one, if they match do not anything 
if they dont historize the new file 
*/
INSERT INTO P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILES_HIST_2
WITH diff AS (
SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_HIST_LAST_VERSION_tmp
WHERE (  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT) NOT IN (SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp) 
UNION ALL 
SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp
WHERE (  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT) NOT IN (SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_HIST_LAST_VERSION_tmp) 
)
, diff_check AS (SELECT COUNT(1) CHECK_DIFF FROM DIFF )

SELECT 
  ID
, CONTAINER_ART
, CONTAINER_ART_GROESSE
, CONTAINER_ART_SORTIMENTSBEREICH
, CONTAINER_SORTIMENTSBEREICH
, ID_LOCAL	
, COUNTRY_2	
, DESC_INT
, FILE_NAME
, DWH_LOAD_ID
, DWH_CREATED
, DWH_UPDATED
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp
WHERE 0 <> (SELECT CHECK_DIFF FROM DIFF_CHECK);

`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* We decided to store the file hist only for last two years - delete the older
*/
DELETE FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILES_HIST_2
WHERE DATE(DWH_UPDATED) < add_months(CURRENT_DATE(),-24);

`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* If there is new CONTAINER_ART in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2
SELECT cont_art_id+nvl(MAX_ID,0) AS cont_art_id, CONTAINER_ART
FROM (
SELECT ROW_NUMBER() OVER (ORDER BY CONTAINER_ART) cont_art_id, CONTAINER_ART 
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp a 
WHERE CONTAINER_ART NOT IN (SELECT CONTAINER_ART FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2)
GROUP BY CONTAINER_ART
) c_art
CROSS JOIN (SELECT MAX(cont_art_id) MAX_ID FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2 WHERE cont_art_id > 0) mx_id 
WHERE c_art.cont_art_id IS NOT NULL
UNION ALL
SELECT -99 AS cont_art_id, ''Ohne Container-Zuordnung''
WHERE -99 NOT IN (SELECT cont_art_id FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2 );
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* If there is new CONTAINER_ART_GROESSE in the new file generate the id for it 
and write it to its lookup table
*/

INSERT INTO P_LEW_MART_LEAD.T_SM_CONTAINER_ART_GR_2
SELECT cont_art_gr_id+nvl(MAX_ID,0) AS cont_art_gr_id, CONTAINER_ART_GROESSE
FROM (
SELECT ROW_NUMBER() OVER (ORDER BY CONTAINER_ART_GROESSE) cont_art_gr_id, CONTAINER_ART_GROESSE 
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp a 
WHERE CONTAINER_ART_GROESSE NOT IN (SELECT CONTAINER_ART_GR FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_GR_2)
GROUP BY CONTAINER_ART_GROESSE
) c_art_gr
CROSS JOIN (SELECT MAX(cont_art_gr_id) MAX_ID FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_GR_2 WHERE cont_art_gr_id > 0) mx_id
WHERE c_art_gr.cont_art_gr_id IS NOT NULL
UNION ALL
SELECT -99 AS cont_art_gr_id, ''Ohne Container-Zuordnung'' 
WHERE -99 NOT IN (SELECT cont_art_gr_id FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_GR_2 );
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();
	
var stmnt = `
/* If there is new CONTAINER_ART_SORTIMENTSBEREICH in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO P_LEW_MART_LEAD.T_SM_CONTAINER_ART_SB_2
SELECT cont_art_sb_id+nvl(MAX_ID,0) AS cont_art_sb_id, CONTAINER_ART_SORTIMENTSBEREICH
FROM (
SELECT ROW_NUMBER() OVER (ORDER BY CONTAINER_ART_SORTIMENTSBEREICH) cont_art_sb_id, CONTAINER_ART_SORTIMENTSBEREICH 
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp a 
WHERE CONTAINER_ART_SORTIMENTSBEREICH NOT IN (SELECT CONTAINER_ART_SB FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_SB_2)
GROUP BY CONTAINER_ART_SORTIMENTSBEREICH
) c_art_sb
CROSS JOIN (SELECT MAX(cont_art_sb_id) MAX_ID FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_SB_2 WHERE cont_art_sb_id > 0) mx_id
WHERE c_art_sb.cont_art_sb_id IS NOT NULL
UNION ALL
SELECT -99 AS cont_art_sb_id, ''Ohne Container-Zuordnung''
WHERE -99 NOT IN (SELECT cont_art_sb_id FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_SB_2 );
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* If there is new CONTAINER_SORTIMENTSBEREICH in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO P_LEW_MART_LEAD.T_SM_CONTAINER_SB_2
SELECT cont_sb_id+nvl(MAX_ID,0) AS cont_sb_id, CONTAINER_SORTIMENTSBEREICH
FROM (
SELECT ROW_NUMBER() OVER (ORDER BY CONTAINER_SORTIMENTSBEREICH) cont_sb_id, CONTAINER_SORTIMENTSBEREICH 
FROM P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp a 
WHERE CONTAINER_SORTIMENTSBEREICH NOT IN (SELECT CONTAINER_SB FROM P_LEW_MART_LEAD.T_SM_CONTAINER_SB_2)
GROUP BY CONTAINER_SORTIMENTSBEREICH
) c_art_sb
CROSS JOIN (SELECT MAX(cont_sb_id) MAX_ID FROM P_LEW_MART_LEAD.T_SM_CONTAINER_SB_2 WHERE cont_sb_id > 0) mx_id
WHERE c_art_sb.cont_sb_id IS NOT NULL
UNION ALL
SELECT -99 AS cont_sb_id, ''Ohne Container-Zuordnung''
WHERE -99 NOT IN (SELECT cont_sb_id FROM P_LEW_MART_LEAD.T_SM_CONTAINER_SB_2 );

`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();

  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* We always generate the relationship table new (easier/simpler), so truncate it first 
*/
DELETE FROM p_lew_mart_lead.t_sm_container_cont_art_rel_2;

`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();
  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

var stmnt = `
/* Populate the relationship table 
assuring that we do not cut out nor multiply the data (the table is used within p_lew_mart_lead.v_sm_container_2 view)
*/
INSERT INTO p_lew_mart_lead.t_sm_container_cont_art_rel_2
WITH V_SM_CONTAINER_base_view AS (
SELECT
  acch.client_id
, acch.assortment_container_sid       AS container_id
, ac.assortment_container_nr          AS local_container_id
, ach.assortment_container_int_name   AS container_int_desc
, acch.assortment_container_name      AS container_desc
, ach.active_fg                       AS container_status_fg
, c.src_country_lidl_cd               AS country_cd
FROM P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_CLIENT_HIST_2 acch
  INNER JOIN P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_HIST_2 ach
    ON acch.assortment_container_sid = ach.assortment_container_sid
   AND CURRENT_DATE BETWEEN acch.dwh_valid_from AND acch.dwh_valid_to
   AND CURRENT_DATE BETWEEN ach.dwh_valid_from AND ach.dwh_valid_to
  INNER JOIN P_LEW_CORE_AC.V_ASSORTMENT_CONTAINER_2 ac
    ON acch.assortment_container_sid = ac.assortment_container_sid
  INNER JOIN P_LEW_CORE_AC.v_client_2 c
    ON ac.container_client_id = c.client_id
  UNION ALL
SELECT
  client_id
, -99                        AS container_id
, -99                        AS local_container_id
, ''Ohne Container-Zuordnung'' AS container_int_desc
, ''Ohne Container-Zuordnung'' AS container_desc
, 1                          AS container_status_fg
, src_country_lidl_cd        AS country_cd
FROM P_LEW_CORE_AC.v_client_2
WHERE client_online_fg = 0
), cte_base AS (
SELECT  
  c.container_id
, COALESCE(c_art.cont_art_id,-99) cont_art_id
, COALESCE(c_art_gr.cont_art_gr_id,-99) cont_art_gr_id
, COALESCE(c_cont_art_sb.cont_art_sb_id,-99) cont_art_sb_id 
, COALESCE(c_cont_sb.cont_sb_id,-99) cont_sb_id 
FROM V_SM_CONTAINER_base_view c
LEFT OUTER JOIN P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp src
ON c.local_container_id = src.id_local
AND c.country_cd = src.country_2
LEFT OUTER JOIN P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2 c_art
ON SRC.CONTAINER_ART = C_ART.CONTAINER_ART
LEFT OUTER JOIN P_LEW_MART_LEAD.T_SM_CONTAINER_ART_GR_2 c_art_gr
ON SRC.CONTAINER_ART_GROESSE = C_ART_GR.CONTAINER_ART_GR
LEFT OUTER JOIN P_LEW_MART_LEAD.T_SM_CONTAINER_ART_SB_2 c_cont_art_sb
ON SRC.CONTAINER_ART_SORTIMENTSBEREICH = c_cont_art_sb.CONTAINER_ART_SB
LEFT OUTER JOIN P_LEW_MART_LEAD.T_SM_CONTAINER_SB_2 c_cont_sb
ON SRC.CONTAINER_SORTIMENTSBEREICH = c_cont_sb.CONTAINER_SB
GROUP BY 1,2,3,4,5)
SELECT container_id
, MIN(cont_art_id)
, MIN(cont_art_gr_id)
, MIN(cont_art_sb_id)
, MIN(cont_sb_id)
from cte_base
GROUP BY 1;
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();
  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();


var stmnt = `
/* TEMP tab cleanup 
*/
DROP TABLE P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_SHRT_FILE_tmp;
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();
  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();


var stmnt = `
/* TEMP tab cleanup 
*/

DROP TABLE P_LEW_MART_LEAD.T_CONTAINERLISTE_KLAMMERN_HIST_LAST_VERSION_tmp;
`
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt
	}).execute();
  var rs_2 = snowflake.createStatement({
	   sqlText : ''COMMIT''
	}).execute();

';


