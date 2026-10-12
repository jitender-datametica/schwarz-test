/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  19.05.2022    Bialek, Aleksander       Initial Version Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item_1: 291570
#  1.1  02.06.2022    Bachmann, Torsten        Change description of dummy_1 element to "Ohne Container-Zuordnung"
#  1.2  21.06.2022    Bialek, Aleksander       Temporary added additional part fixing the ID's generated with negative values
#  1.3  22.06.2022    Bialek, Aleksander       Fix from ldl_production.1.2 version worked, no more needed, reverting that change.
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_lead.p_load_somo_container_art_data()
BEGIN
DECLARE stmnt STRING;
DECLARE rs_1 STRING;
BEGIN TRANSACTION;

SET stmnt  =  '''/* Get the latest veriosn from precore (we could refer to precore directly since it should have only last version  
the temp table its just to make sure
*/
CREATE TEMPORARY TABLE IF NOT EXISTS t_containerliste_klammern_shrt_file_tmp AS SELECT id,  container_art,  container_art_groesse,  container_art_sortimentsbereich,  container_sortimentsbereich,  id_local,  country_1,  desc_int,  file_name,  dwh_load_id,  dwh_created,  dwh_updated FROM ldl_production_p_lew_precore.t_cache_containerliste_klammern_1 WHERE dwh_load_id = (SELECT MAX(dwh_load_id)    FROM ldl_production_p_lew_precore.t_cache_containerliste_klammern_1);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''/* Get the last historized version of the file */
CREATE TEMPORARY TABLE IF NOT EXISTS t_containerliste_klammern_hist_last_version_tmp AS SELECT id,  container_art,  container_art_groesse,  container_art_sortimentsbereich,  container_sortimentsbereich,  id_local,  country_1,  desc_int,  file_name,  dwh_load_id,  dwh_created,  dwh_updated FROM ldl_production_p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist_1 WHERE dwh_load_id = (SELECT MAX(dwh_load_id)    FROM ldl_production_p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist_1);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* Compare current precore version with last historized one, if they match do not anything 
if they dont historize the new file 
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist_1 WITH diff AS (SELECT id,      container_art,      container_art_groesse,      container_art_sortimentsbereich,      container_sortimentsbereich,      id_local,      country_1,      desc_int     FROM t_containerliste_klammern_hist_last_version_tmp     WHERE (id, container_art, container_art_groesse, container_art_sortimentsbereich, container_sortimentsbereich,        id_local, country_1, desc_int) NOT IN (SELECT (id, container_art, container_art_groesse,          container_art_sortimentsbereich, container_sortimentsbereich, id_local, country_1, desc_int)        FROM t_containerliste_klammern_shrt_file_tmp)     UNION ALL     SELECT id,      container_art,      container_art_groesse,      container_art_sortimentsbereich,      container_sortimentsbereich,      id_local,      country_1,      desc_int     FROM t_containerliste_klammern_shrt_file_tmp     WHERE (id, container_art, container_art_groesse, container_art_sortimentsbereich, container_sortimentsbereich,        id_local, country_1, desc_int) NOT IN (SELECT (id, container_art, container_art_groesse,          container_art_sortimentsbereich, container_sortimentsbereich, id_local, country_1, desc_int)        FROM t_containerliste_klammern_hist_last_version_tmp)) (SELECT id,     container_art,     container_art_groesse,     container_art_sortimentsbereich,     container_sortimentsbereich,     id_local,     country_1,     desc_int,     file_name,     dwh_load_id,     dwh_created,     dwh_updated    FROM t_containerliste_klammern_shrt_file_tmp    WHERE 0 <> (SELECT COUNT(1) AS check_diff       FROM diff));''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* We decided to store the file hist only for last two years - delete the older
*/
DELETE FROM ldl_production_p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist_1 WHERE DATE(dwh_updated) < IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 24 MONTH)    ), DATE_ADD(CURRENT_DATE, INTERVAL - 24 MONTH));''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* If there is new CONTAINER_ART in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_sm_container_art_1 (SELECT cont_art_id,   container_art  FROM (SELECT c_art.cont_art_id + IFNULL(mx_id.max_id, 0) AS cont_art_id,      c_art.container_art     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art IS NULL, container_art) AS cont_art_id,        container_art       FROM t_containerliste_klammern_shrt_file_tmp AS a       WHERE container_art NOT IN (SELECT container_art          FROM ldl_production_p_lew_mart_lead.t_sm_container_art_1)       GROUP BY container_art) AS c_art      INNER JOIN (SELECT MAX(cont_art_id) AS max_id       FROM ldl_production_p_lew_mart_lead.t_sm_container_art_1       WHERE cont_art_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT - 99 AS cont_art_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS ZERO) AS t7     WHERE - 99 NOT IN (SELECT cont_art_id        FROM ldl_production_p_lew_mart_lead.t_sm_container_art_1)) AS t11);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* If there is new CONTAINER_ART_GROESSE in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_sm_container_art_gr_1 (SELECT cont_art_gr_id,   container_art_groesse  FROM (SELECT c_art_gr.cont_art_gr_id + IFNULL(mx_id.max_id, 0) AS cont_art_gr_id,      c_art_gr.container_art_groesse     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art_groesse IS NULL, container_art_groesse) AS cont_art_gr_id,        container_art_groesse       FROM t_containerliste_klammern_shrt_file_tmp AS a       WHERE container_art_groesse NOT IN (SELECT container_art_gr          FROM ldl_production_p_lew_mart_lead.t_sm_container_art_gr_1)       GROUP BY container_art_groesse) AS c_art_gr      INNER JOIN (SELECT MAX(cont_art_gr_id) AS max_id       FROM ldl_production_p_lew_mart_lead.t_sm_container_art_gr_1       WHERE cont_art_gr_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT - 99 AS cont_art_gr_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS ZERO) AS t7     WHERE - 99 NOT IN (SELECT cont_art_gr_id        FROM ldl_production_p_lew_mart_lead.t_sm_container_art_gr_1)) AS t11);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* If there is new CONTAINER_ART_SORTIMENTSBEREICH in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_sm_container_art_sb_1 (SELECT cont_art_sb_id,   container_art_sortimentsbereich  FROM (SELECT c_art_sb.cont_art_sb_id + IFNULL(mx_id.max_id, 0) AS cont_art_sb_id,      c_art_sb.container_art_sortimentsbereich     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art_sortimentsbereich IS NULL, container_art_sortimentsbereich)        AS cont_art_sb_id,        container_art_sortimentsbereich       FROM t_containerliste_klammern_shrt_file_tmp AS a       WHERE container_art_sortimentsbereich NOT IN (SELECT container_art_sb          FROM ldl_production_p_lew_mart_lead.t_sm_container_art_sb_1)       GROUP BY container_art_sortimentsbereich) AS c_art_sb      INNER JOIN (SELECT MAX(cont_art_sb_id) AS max_id       FROM ldl_production_p_lew_mart_lead.t_sm_container_art_sb_1       WHERE cont_art_sb_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT - 99 AS cont_art_sb_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS ZERO) AS t7     WHERE - 99 NOT IN (SELECT cont_art_sb_id        FROM ldl_production_p_lew_mart_lead.t_sm_container_art_sb_1)) AS t11);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* If there is new CONTAINER_SORTIMENTSBEREICH in the new file generate the id for it 
and write it to its lookup table
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_sm_container_sb_1 (SELECT cont_sb_id,   container_sortimentsbereich  FROM (SELECT c_art_sb.cont_sb_id + IFNULL(mx_id.max_id, 0) AS cont_sb_id,      c_art_sb.container_sortimentsbereich     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_sortimentsbereich IS NULL, container_sortimentsbereich) AS        cont_sb_id,        container_sortimentsbereich       FROM t_containerliste_klammern_shrt_file_tmp AS a       WHERE container_sortimentsbereich NOT IN (SELECT container_sb          FROM ldl_production_p_lew_mart_lead.t_sm_container_sb_1)       GROUP BY container_sortimentsbereich) AS c_art_sb      INNER JOIN (SELECT MAX(cont_sb_id) AS max_id       FROM ldl_production_p_lew_mart_lead.t_sm_container_sb_1       WHERE cont_sb_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT - 99 AS cont_sb_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS ZERO) AS t7     WHERE - 99 NOT IN (SELECT cont_sb_id        FROM ldl_production_p_lew_mart_lead.t_sm_container_sb_1)) AS t11);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* We always generate the relationship table new (easier/simpler), so truncate it first 
*/
TRUNCATE TABLE ldl_production_p_lew_mart_lead.t_sm_container_cont_art_rel_1;''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* Populate the relationship table 
assuring that we do not cut out nor multiply the data (the table is used within p_lew_mart_lead.v_sm_container_1 view)
*/
INSERT INTO ldl_production_p_lew_mart_lead.t_sm_container_cont_art_rel_1 WITH v_sm_container_base_view AS (SELECT acch.client_id,      acch.assortment_container_sid AS container_id,      ac.assortment_container_nr AS local_container_id,      ach.assortment_container_int_name AS container_int_desc,      acch.assortment_container_name AS container_desc,      ach.active_fg AS container_status_fg,      c.src_country_lidl_cd AS country_cd     FROM ldl_production_p_lew_core_ac.v_assortment_container_client_hist_1 AS acch      INNER JOIN ldl_production_p_lew_core_ac.v_assortment_container_hist_1 AS ach ON acch.assortment_container_sid = ach.assortment_container_sid          AND CURRENT_DATE BETWEEN acch.dwh_valid_from AND acch.dwh_valid_to AND CURRENT_DATE BETWEEN ach.dwh_valid_from        AND ach.dwh_valid_to      INNER JOIN ldl_production_p_lew_core_ac.v_assortment_container_1 AS ac ON acch.assortment_container_sid = ac.assortment_container_sid             INNER JOIN ldl_production_p_lew_core_ac.v_client_1 AS c ON ac.container_client_id = c.client_id     UNION ALL     SELECT client_id,      - 99 AS container_id,      - 99 AS local_container_id,      "Ohne Container-Zuordnung" AS container_int_desc,      "Ohne Container-Zuordnung" AS container_desc,      1 AS container_status_fg,      src_country_lidl_cd AS country_cd     FROM ldl_production_p_lew_core_ac.v_client_1     WHERE client_online_fg = 0), cte_base AS (SELECT t3.container_id,     COALESCE(c_art.cont_art_id, - 99) AS cont_art_id,     COALESCE(c_art_gr.cont_art_gr_id, - 99) AS cont_art_gr_id,     COALESCE(c_cont_art_sb.cont_art_sb_id, - 99) AS cont_art_sb_id,     COALESCE(c_cont_sb.cont_sb_id, - 99) AS cont_sb_id    FROM v_sm_container_base_view AS t3     LEFT JOIN t_containerliste_klammern_shrt_file_tmp AS src ON t3.local_container_id = src.id_local AND t3.country_cd =       src.country_1     LEFT JOIN ldl_production_p_lew_mart_lead.t_sm_container_art_1 AS c_art ON src.container_art = c_art.container_art     LEFT JOIN ldl_production_p_lew_mart_lead.t_sm_container_art_gr_1 AS c_art_gr ON src.container_art_groesse = c_art_gr.container_art_gr           LEFT JOIN ldl_production_p_lew_mart_lead.t_sm_container_art_sb_1 AS c_cont_art_sb ON src.container_art_sortimentsbereich       = c_cont_art_sb.container_art_sb     LEFT JOIN ldl_production_p_lew_mart_lead.t_sm_container_sb_1 AS c_cont_sb ON src.container_sortimentsbereich =      c_cont_sb.container_sb    GROUP BY t3.container_id,     cont_art_id,     cont_art_gr_id,     cont_art_sb_id,     cont_sb_id) (SELECT container_id,     MIN(cont_art_id),     MIN(cont_art_gr_id),     MIN(cont_art_sb_id),     MIN(cont_sb_id)    FROM cte_base    GROUP BY container_id);''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* TEMP tab cleanup 
*/
DROP TABLE IF EXISTS t_containerliste_klammern_shrt_file_tmp;''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');
BEGIN TRANSACTION;
SET stmnt  =  '''
/* TEMP tab cleanup 
*/
DROP TABLE IF EXISTS t_containerliste_klammern_hist_last_version_tmp;''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT');

END;
