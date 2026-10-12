/*



#----------------------------------------------------------------------------



# @ LIDL Stiftung & Co. KG - DWH / MIS



#----------------------------------------------------------------------------



# Interface: DDL



#----------------------------------------------------------------------------



# History:



#  1.0  19.05.2022    Bialek, Aleksander       Initial Version Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item: 291570



#  1.1  02.06.2022    Bachmann, Torsten        Change description of dummy element to '_dmOhne Container-Zuordnung'_dm



#  1.2  21.06.2022    Bialek, Aleksander       Temporary added additional part fixing the ID's generated with negative values



#  1.3  22.06.2022    Bialek, Aleksander       Fix from LDL.1.2 version worked, no more needed, reverting that change.



#



#----------------------------------------------------------------------------



*/



CREATE OR REPLACE PROCEDURE p_lew_mart_lead.p_load_somo_container_art_data()
BEGIN
DECLARE stmnt STRING;
DECLARE rs STRING;
BEGIN TRANSACTION;
SET stmnt  =  '''CREATE TEMPORARY TABLE IF NOT EXISTS t_containerliste_klammern_shrt_file_tmp AS SELECT id,  container_art,  container_art_groesse,  container_art_sortimentsbereich,  container_sortimentsbereich,  id_local,  country,  desc_int,  file_name,  dwh_load_id,  dwh_created,  dwh_updated FROM p_lew_precore.t_cache_containerliste_klammern WHERE dwh_load_id = (SELECT MAX(dwh_load_id)    FROM p_lew_precore.t_cache_containerliste_klammern) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''CREATE TEMPORARY TABLE IF NOT EXISTS t_containerliste_klammern_hist_last_version_tmp AS SELECT id,  container_art,  container_art_groesse,  container_art_sortimentsbereich,  container_sortimentsbereich,  id_local,  country,  desc_int,  file_name,  dwh_load_id,  dwh_created,  dwh_updated FROM p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist WHERE dwh_load_id = (SELECT MAX(dwh_load_id)    FROM p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist WITH DIFF AS (SELECT id,      container_art,      container_art_groesse,      container_art_sortimentsbereich,      container_sortimentsbereich,      id_local,      country,      desc_int     FROM t_containerliste_klammern_hist_last_version_tmp     WHERE (id, container_art, container_art_groesse, container_art_sortimentsbereich, container_sortimentsbereich,        id_local, country, desc_int) NOT IN (SELECT (id, container_art, container_art_groesse,          container_art_sortimentsbereich, container_sortimentsbereich, id_local, country, desc_int)        FROM t_containerliste_klammern_shrt_file_tmp)     UNION ALL     SELECT id,      container_art,      container_art_groesse,      container_art_sortimentsbereich,      container_sortimentsbereich,      id_local,      country,      desc_int     FROM t_containerliste_klammern_shrt_file_tmp     WHERE (id, container_art, container_art_groesse, container_art_sortimentsbereich, container_sortimentsbereich,        id_local, country, desc_int) NOT IN (SELECT (id, container_art, container_art_groesse,          container_art_sortimentsbereich, container_sortimentsbereich, id_local, country, desc_int)        FROM t_containerliste_klammern_hist_last_version_tmp)) (SELECT id,     container_art,     container_art_groesse,     container_art_sortimentsbereich,     container_sortimentsbereich,     id_local,     country,     desc_int,     file_name,     dwh_load_id,     dwh_created,     dwh_updated    FROM t_containerliste_klammern_shrt_file_tmp    WHERE 0 <> (SELECT COUNT(1) AS check_diff       FROM DIFF)) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''DELETE FROM p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist WHERE DATE(dwh_updated) < IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL -24 MONTH)    ), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL -24 MONTH)) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_sm_container_art (SELECT cont_art_id,   container_art  FROM (SELECT c_art.cont_art_id + IFNULL(mx_id.max_id, 0) AS cont_art_id,      c_art.container_art     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art IS NULL, container_art) AS cont_art_id,        container_art       FROM t_containerliste_klammern_shrt_file_tmp AS A       WHERE container_art NOT IN (SELECT container_art          FROM p_lew_mart_lead.t_sm_container_art)       GROUP BY container_art) AS c_art      INNER JOIN (SELECT MAX(cont_art_id) AS max_id       FROM p_lew_mart_lead.t_sm_container_art       WHERE cont_art_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT -99 AS cont_art_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS zero) AS t7     WHERE -99 NOT IN (SELECT cont_art_id        FROM p_lew_mart_lead.t_sm_container_art)) AS t11) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_sm_container_art_gr (SELECT cont_art_gr_id,   container_art_groesse  FROM (SELECT c_art_gr.cont_art_gr_id + IFNULL(mx_id.max_id, 0) AS cont_art_gr_id,      c_art_gr.container_art_groesse     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art_groesse IS NULL, container_art_groesse) AS cont_art_gr_id,        container_art_groesse       FROM t_containerliste_klammern_shrt_file_tmp AS A       WHERE container_art_groesse NOT IN (SELECT container_art_gr          FROM p_lew_mart_lead.t_sm_container_art_gr)       GROUP BY container_art_groesse) AS c_art_gr      INNER JOIN (SELECT MAX(cont_art_gr_id) AS max_id       FROM p_lew_mart_lead.t_sm_container_art_gr       WHERE cont_art_gr_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT -99 AS cont_art_gr_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS zero) AS t7     WHERE -99 NOT IN (SELECT cont_art_gr_id        FROM p_lew_mart_lead.t_sm_container_art_gr)) AS t11) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_sm_container_art_sb (SELECT cont_art_sb_id,   container_art_sortimentsbereich  FROM (SELECT c_art_sb.cont_art_sb_id + IFNULL(mx_id.max_id, 0) AS cont_art_sb_id,      c_art_sb.container_art_sortimentsbereich     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_art_sortimentsbereich IS NULL, container_art_sortimentsbereich)        AS cont_art_sb_id,        container_art_sortimentsbereich       FROM t_containerliste_klammern_shrt_file_tmp AS A       WHERE container_art_sortimentsbereich NOT IN (SELECT container_art_sb          FROM p_lew_mart_lead.t_sm_container_art_sb)       GROUP BY container_art_sortimentsbereich) AS c_art_sb      INNER JOIN (SELECT MAX(cont_art_sb_id) AS max_id       FROM p_lew_mart_lead.t_sm_container_art_sb       WHERE cont_art_sb_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT -99 AS cont_art_sb_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS zero) AS t7     WHERE -99 NOT IN (SELECT cont_art_sb_id        FROM p_lew_mart_lead.t_sm_container_art_sb)) AS t11) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_sm_container_sb (SELECT cont_sb_id,   container_sortimentsbereich  FROM (SELECT c_art_sb.cont_sb_id + IFNULL(mx_id.max_id, 0) AS cont_sb_id,      c_art_sb.container_sortimentsbereich     FROM (SELECT ROW_NUMBER() OVER (ORDER BY container_sortimentsbereich IS NULL, container_sortimentsbereich) AS        cont_sb_id,        container_sortimentsbereich       FROM t_containerliste_klammern_shrt_file_tmp AS A       WHERE container_sortimentsbereich NOT IN (SELECT container_sb          FROM p_lew_mart_lead.t_sm_container_sb)       GROUP BY container_sortimentsbereich) AS c_art_sb      INNER JOIN (SELECT MAX(cont_sb_id) AS max_id       FROM p_lew_mart_lead.t_sm_container_sb       WHERE cont_sb_id > 0) AS mx_id ON TRUE     UNION ALL     SELECT -99 AS cont_sb_id,      "Ohne Container-Zuordnung"     FROM (SELECT 0 AS zero) AS t7     WHERE -99 NOT IN (SELECT cont_sb_id        FROM p_lew_mart_lead.t_sm_container_sb)) AS t11) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''TRUNCATE TABLE p_lew_mart_lead.t_sm_container_cont_art_rel ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''INSERT INTO p_lew_mart_lead.t_sm_container_cont_art_rel WITH V_SM_CONTAINER_BASE_VIEW AS (SELECT ACCH.client_id,      ACCH.assortment_container_sid AS container_id,      AC.assortment_container_nr AS local_container_id,      ACH.assortment_container_int_name AS container_int_desc,      ACCH.assortment_container_name AS container_desc,      ACH.active_fg AS container_status_fg,      C.src_country_lidl_cd AS country_cd     FROM p_lew_core_ac.v_assortment_container_client_hist AS ACCH      INNER JOIN p_lew_core_ac.v_assortment_container_hist AS ACH ON ACCH.assortment_container_sid = ACH.assortment_container_sid          AND CURRENT_DATE("Europe/Berlin") BETWEEN ACCH.dwh_valid_from AND ACCH.dwh_valid_to AND CURRENT_DATE("Europe/Berlin") BETWEEN ACH.dwh_valid_from        AND ACH.dwh_valid_to      INNER JOIN p_lew_core_ac.v_assortment_container AS AC ON ACCH.assortment_container_sid = AC.assortment_container_sid             INNER JOIN p_lew_core_ac.v_client AS C ON AC.container_client_id = C.client_id     UNION ALL     SELECT client_id,      -99 AS container_id,      -99 AS local_container_id,      "Ohne Container-Zuordnung" AS container_int_desc,      "Ohne Container-Zuordnung" AS container_desc,      1 AS container_status_fg,      src_country_lidl_cd AS country_cd     FROM p_lew_core_ac.v_client     WHERE client_online_fg = 0), CTE_BASE AS (SELECT c.container_id,     COALESCE(C_ART.cont_art_id, -99) AS cont_art_id,     COALESCE(C_ART_GR.cont_art_gr_id, -99) AS cont_art_gr_id,     COALESCE(C_CONT_ART_SB.cont_art_sb_id, -99) AS cont_art_sb_id,     COALESCE(C_CONT_SB.cont_sb_id, -99) AS cont_sb_id    FROM V_SM_CONTAINER_BASE_VIEW AS c     LEFT JOIN t_containerliste_klammern_shrt_file_tmp AS SRC ON c.local_container_id = SRC.id_local AND c.country_cd =       SRC.country     LEFT JOIN p_lew_mart_lead.t_sm_container_art AS C_ART ON SRC.container_art = C_ART.container_art     LEFT JOIN p_lew_mart_lead.t_sm_container_art_gr AS C_ART_GR ON SRC.container_art_groesse = C_ART_GR.container_art_gr           LEFT JOIN p_lew_mart_lead.t_sm_container_art_sb AS C_CONT_ART_SB ON SRC.container_art_sortimentsbereich =      C_CONT_ART_SB.container_art_sb     LEFT JOIN p_lew_mart_lead.t_sm_container_sb AS C_CONT_SB ON SRC.container_sortimentsbereich = C_CONT_SB.container_sb          GROUP BY c.container_id,     cont_art_id,     cont_art_gr_id,     cont_art_sb_id,     cont_sb_id) (SELECT container_id,     MIN(cont_art_id),     MIN(cont_art_gr_id),     MIN(cont_art_sb_id),     MIN(cont_sb_id)    FROM CTE_BASE    GROUP BY container_id) ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''DROP TABLE IF EXISTS t_containerliste_klammern_shrt_file_tmp ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
BEGIN TRANSACTION;
SET stmnt  =  '''DROP TABLE IF EXISTS t_containerliste_klammern_hist_last_version_tmp ''';

EXECUTE IMMEDIATE (stmnt);

EXECUTE IMMEDIATE ('COMMIT'
);
END;
