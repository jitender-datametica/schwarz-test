--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.bake_final_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.bake_final_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.bake_final_1 ,NO FALLBACK ,
--     NO BEFORE JOURNAL,
--     NO AFTER JOURNAL,
--     CHECKSUM = DEFAULT,
--     DEFAULT MERGEBLOCKRATIO
--     (
--      mandant_id BYTEINT,
--      wup_id INTEGER,
--      nb_id SMALLINT,
--      the_type CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
--      oventype VARCHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
--      dat_von DATE FORMAT 'YYYY-MM_1-DD',
--      dat_bis DATE FORMAT 'YYYY-MM_1-DD',
--      anz_blech INTEGER,
--      anz_ofen INTEGER,
--      gp_backen_bez VARCHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC,
--      klart CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
--      art_id INTEGER,
--      bestell_art_id INTEGER,
--      inhalt_menge DECIMAL(9,3),
--      back_aufbereitung_id BYTEINT,
--      back_hinweis_id BYTEINT,
--      back_programm_id SMALLINT,
--      blechbelegung BYTEINT)
--PRIMARY INDEX ( mandant_id , art_id )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.bake_final_1  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      the_type CHAR(1) COLLATE 'de-ci',
      oventype VARCHAR(2) COLLATE 'de-ci',
      dat_von DATE,
      dat_bis DATE,
      anz_blech INTEGER,
      anz_ofen INTEGER,
      gp_backen_bez VARCHAR(20) COLLATE 'de-ci',
      klart CHAR(3) COLLATE 'de-ci',
      art_id INTEGER,
      bestell_art_id INTEGER,
      inhalt_menge DECIMAL(9,3),
      back_aufbereitung_id BYTEINT,
      back_hinweis_id BYTEINT,
      back_programm_id SMALLINT,
      blechbelegung BYTEINT)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.ausp_work_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.ausp_work_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE TABLE DBX_LOAD.ausp_work_1 AS DBX_LOAD.ausp_1 WITH DATA AND STATS;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE TABLE DBP_ETL.ausp_work_1 CLONE DBP_ETL.ausp_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.cabn_work_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.cabn_work_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE TABLE DBX_LOAD.cabn_work_1 AS DBX_LOAD.cabn_1 WITH DATA AND STATS;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE TABLE DBP_ETL.cabn_work_1 CLONE DBP_ETL.cabn_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #perf AS (
--SELECT mandant_id
--FROM DBX_LOAD.ausp_work_1
--GROUP BY 1
--) WITH DATA
--  ON COMMIT PRESERVE ROWS;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _perf AS (
SELECT mandant_id
FROM DBP_ETL.ausp_work_1
GROUP BY 1
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #join_help (
--  the_type CHAR(1) 
--) PRIMARY INDEX (the_type)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _join_help (
  the_type CHAR(1) 
) ;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #join_help VALUES ('A');
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO _join_help VALUES ('A');

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #join_help VALUES ('B');
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO _join_help VALUES ('B');

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #join_help VALUES ('C');
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO _join_help VALUES ('C');

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #join_help VALUES ('D');
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO _join_help VALUES ('D');

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.bake_final_1 (mandant_id,
--                                               wup_id,
--                                               nb_id,
--                                               the_type,
--                                               oventype,
--                                               dat_von,
--                                               dat_bis,
--                                               anz_blech,
--                                               anz_ofen,
--                                               gp_backen_bez,
--                                               klart)
--SELECT x1.mandant_id,
--       x1.wup_id,
--       x1.nb_id,
--       TRIM(x1.the_type) AS the_type,
--       TRIM(x2.oventype) AS oventype,
--       x3.dat_von,
--       x4.dat_bis,
--       x5.anz_blech,
--       x6.anz_ofen,
--       COALESCE(x8.gp_backen_bez,'N.N.') AS gp_backen_bez,
--       x1.klart
--FROM (SELECT a.mandant_id,
--             c.wup_id,
--             c.nb_id,
--             b.the_type,
--             a.klart
--      FROM DBX_LOAD.ausp_work_1 a
--      JOIN #join_help b
--        ON 1 = 1
--      JOIN DBX_DATA.wup_1 c
--        ON a.objek = c.wup_id AND
--           a.mandant_id = c.mandant_id
--      WHERE a.klart = 'Z30'
--      GROUP BY 1,2,3,4,5) x1
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             TRIM(b.atwrt) AS oventype,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '001') x2
--  ON x1.mandant_id = x2.mandant_id AND
--     x1.wup_id     = x2.wup_id     AND
--     x1.the_type   = x2.the_type
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             CAST(b.atflv - 19000000 AS DATE FORMAT 'YYYY-MM_1-DD') AS dat_von,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '002') x3
--  ON x1.mandant_id = x3.mandant_id AND
--     x1.wup_id     = x3.wup_id     AND
--     x1.the_type   = x3.the_type
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             CAST(b.atflv - 19000000 AS DATE FORMAT 'YYYY-MM_1-DD') AS dat_bis,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '003') x4
--  ON x1.mandant_id = x4.mandant_id AND
--     x1.wup_id     = x4.wup_id     AND
--     x1.the_type   = x4.the_type
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             CAST(b.atflv AS INTEGER) AS anz_blech,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '004') x5
--  ON x1.mandant_id = x5.mandant_id AND
--     x1.wup_id     = x5.wup_id     AND
--     x1.the_type   = x5.the_type
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             CAST(b.atflv AS INTEGER) AS anz_ofen,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '005') x6
--  ON x1.mandant_id = x6.mandant_id AND
--     x1.wup_id     = x6.wup_id     AND
--     x1.the_type   = x6.the_type
--JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             TRIM(b.atwrt) AS backplan_fg,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '006') x7
--  ON x1.mandant_id = x7.mandant_id AND
--     x1.wup_id     = x7.wup_id     AND
--     x1.the_type   = x7.the_type
--LEFT JOIN (SELECT a.mandant_id,
--             b.objek AS wup_id,
--             UPPER(TRIM(b.atwrt)) AS gp_backen_bez,
--             CASE
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
--               THEN 'A'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
--               THEN 'B'
--               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
--               THEN 'C'
--               ELSE 'D'
--             END AS the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z30'
--      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
--            SUBSTR(TRIM(a.atnam),16,3) = '009') x8
--  ON x1.mandant_id = x8.mandant_id AND
--     x1.wup_id     = x8.wup_id     AND
--     x1.the_type   = x8.the_type
--WHERE x7.backplan_fg = 'Y'
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.bake_final_1 (mandant_id,
                                               wup_id,
                                               nb_id,
                                               the_type,
                                               oventype,
                                               dat_von,
                                               dat_bis,
                                               anz_blech,
                                               anz_ofen,
                                               gp_backen_bez,
                                               klart)
SELECT x1.mandant_id,
       x1.wup_id,
       x1.nb_id,
       TRIM(x1.the_type) AS the_type,
       TRIM(x2.oventype) AS oventype,
       x3.dat_von,
       x4.dat_bis,
       x5.anz_blech,
       x6.anz_ofen,
       COALESCE(x8.gp_backen_bez,'N.N.') AS gp_backen_bez,
       x1.klart
FROM (SELECT a.mandant_id,
             c.wup_id,
             c.nb_id,
             b.the_type,
             a.klart
      FROM DBP_ETL.ausp_work_1 a
      JOIN _join_help b
        ON 1 = 1
      JOIN DBP_DATA.wup_1 c
        ON a.objek = c.wup_id AND
           a.mandant_id = c.mandant_id
      WHERE a.klart = 'Z30'
      GROUP BY 1,2,3,4,5) x1
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             TRIM(b.atwrt) AS oventype,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '001') x2
  ON x1.mandant_id = x2.mandant_id AND
     x1.wup_id     = x2.wup_id     AND
     x1.the_type   = x2.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             CAST(b.atflv - 19000000 AS CURRENT_DATE FORMAT 'YYYY-MM_1-DD') AS dat_von,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '002') x3
  ON x1.mandant_id = x3.mandant_id AND
     x1.wup_id     = x3.wup_id     AND
     x1.the_type   = x3.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             CAST(b.atflv - 19000000 AS CURRENT_DATE FORMAT 'YYYY-MM_1-DD') AS dat_bis,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '003') x4
  ON x1.mandant_id = x4.mandant_id AND
     x1.wup_id     = x4.wup_id     AND
     x1.the_type   = x4.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             CAST(b.atflv AS INTEGER) AS anz_blech,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '004') x5
  ON x1.mandant_id = x5.mandant_id AND
     x1.wup_id     = x5.wup_id     AND
     x1.the_type   = x5.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             CAST(b.atflv AS INTEGER) AS anz_ofen,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '005') x6
  ON x1.mandant_id = x6.mandant_id AND
     x1.wup_id     = x6.wup_id     AND
     x1.the_type   = x6.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             TRIM(b.atwrt) AS backplan_fg,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '006') x7
  ON x1.mandant_id = x7.mandant_id AND
     x1.wup_id     = x7.wup_id     AND
     x1.the_type   = x7.the_type
LEFT JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             UPPER(TRIM(b.atwrt)) AS gp_backen_bez,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               ELSE 'D'
             END AS the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '009') x8
  ON x1.mandant_id = x8.mandant_id AND
     x1.wup_id     = x8.wup_id     AND
     x1.the_type   = x8.the_type
WHERE x7.backplan_fg = 'Y'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #art_mix AS (
--SELECT a.mandant_id,
--             c.art_id,
--             b.the_type,
--             a.klart
--      FROM DBX_LOAD.ausp_work_1 a
--      JOIN #join_help b
--        ON 1 = 1
--      JOIN DBX_DATA.art_1 c
--        ON a.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      WHERE a.klart = 'Z01' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--      GROUP BY 1,2,3,4
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _art_mix AS (
SELECT a.mandant_id,
             c.art_id,
             b.the_type,
             a.klart
      FROM DBP_ETL.ausp_work_1 a
      JOIN _join_help b
        ON 1 = 1
      JOIN DBP_DATA.art_1 c
        ON a.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      WHERE a.klart = 'Z01' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
      GROUP BY 1,2,3,4
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap1 AS (
--SELECT a.mandant_id,
--             c1.art_id,
--             c2.art_id AS bestell_art_id,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn      = b.atinn      AND
--           b.klart      = 'Z01'
--      JOIN DBX_DATA.art_1 c1
--        ON b.objek = c1.kl_art_id AND
--           DATE BETWEEN c1.dat_von AND c1.dat_bis
--      JOIN DBX_DATA.art_1 c2
--        ON b.atwrt = c2.kl_art_id AND
--           DATE BETWEEN c2.dat_von AND c2.dat_bis
--      JOIN #join_help d
--        ON 1 = 1
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,3) = '001' AND
--            CHARACTERS(OTRANSLATE(TRIM(b.atwrt),'a1234567890','a')) = 0 AND
--            c1.mandant_id IN (SELECT mandant_id FROM #perf) AND
--            c2.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap1 AS (
SELECT a.mandant_id,
             c1.art_id,
             c2.art_id AS bestell_art_id,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z01'
      JOIN DBP_DATA.art_1 c1
        ON b.objek = c1.kl_art_id AND
           CURRENT_DATE BETWEEN c1.dat_von AND c1.dat_bis
      JOIN DBP_DATA.art_1 c2
        ON b.atwrt = c2.kl_art_id AND
           CURRENT_DATE BETWEEN c2.dat_von AND c2.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '001' AND
            CHARACTERS(OTRANSLATE(TRIM(b.atwrt),'a1234567890','a')) = 0 AND
            c1.mandant_id IN (SELECT mandant_id FROM _perf) AND
            c2.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap2 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS DECIMAL(9,3)) AS inhalt_menge,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 1 = 1
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,3) = '003' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap2 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS DECIMAL(9,3)) AS inhalt_menge,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '003' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap3 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS back_aufbereitung_id,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 1 = 1
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,3) = '004' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap3 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_aufbereitung_id,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '004' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap4 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS back_hinweis_id,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 1 = 1
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,3) = '005' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap4 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_hinweis_id,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '005' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap5 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS back_programm_id,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 1 = 1
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,3) = '006' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap5 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_programm_id,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '006' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap6 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS blechbelegung_a,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 'A' = d.the_type
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,4) = '00A2' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap6 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_a,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'A' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00A2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap7 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS blechbelegung_b,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 'B' = d.the_type
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,4) = '00B2' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap7 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_b,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'B' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00B2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap8 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS blechbelegung_c,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 'C' = d.the_type
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,4) = '00C2' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap8 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_c,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'C' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00C2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #snap9 AS (
--SELECT a.mandant_id,
--             c.art_id,
--             CAST(b.atflv AS INTEGER) AS blechbelegung_d,
--             d.the_type
--      FROM DBX_LOAD.cabn_work_1 a
--      JOIN DBX_LOAD.ausp_work_1 b
--        ON a.mandant_id = b.mandant_id AND
--           a.atinn = b.atinn AND
--           b.klart = 'Z01'
--      JOIN DBX_DATA.art_1 c
--        ON b.objek = c.kl_art_id AND
--           DATE BETWEEN c.dat_von AND c.dat_bis
--      JOIN #join_help d
--        ON 'D' = d.the_type
--      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
--            SUBSTR(a.atnam,16,4) = '00D2' AND
--            c.mandant_id IN (SELECT mandant_id FROM #perf)
--) WITH DATA
--  PRIMARY INDEX (mandant_id,art_id)
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _snap9 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_d,
             d.the_type
      FROM DBP_ETL.cabn_work_1 a
      JOIN DBP_ETL.ausp_work_1 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_1 c
        ON b.objek = c.kl_art_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'D' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00D2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.bake_final_1 (mandant_id,
--                                               art_id,
--                                               the_type,
--                                               bestell_art_id,
--                                               inhalt_menge,
--                                               back_aufbereitung_id,
--                                               back_hinweis_id,
--                                               back_programm_id,
--                                               blechbelegung,
--                                               klart)
--SELECT x1.mandant_id,
--       x1.art_id,
--       x1.the_type,
--       x2.bestell_art_id,
--       x3.inhalt_menge,
--       x4.back_aufbereitung_id,
--       x5.back_hinweis_id,
--       x6.back_programm_id,
--       COALESCE(x7.blechbelegung_a,x8.blechbelegung_b,x9.blechbelegung_c,x10.blechbelegung_d,0) AS blechbelegung,
--       x1.klart
--FROM #art_mix x1
--/* Bestellartikel */
--JOIN #snap1 x2
--  ON x1.mandant_id = x2.mandant_id AND
--     x1.art_id     = x2.art_id     AND
--     x1.the_type   = x2.the_type
--/* Inhaltsmenge */
--JOIN #snap2 x3
--  ON x1.mandant_id    = x3.mandant_id  AND
--     x1.art_id   = x3.art_id AND
--     x1.the_type = x3.the_type
--/* Veredlungsschritte */    
--JOIN #snap3 x4
--  ON x1.mandant_id    = x4.mandant_id  AND
--     x1.art_id   = x4.art_id AND
--     x1.the_type = x4.the_type
--/* Backhinweis */
--JOIN #snap4 x5
--  ON x1.mandant_id    = x5.mandant_id  AND
--     x1.art_id   = x5.art_id AND
--     x1.the_type = x5.the_type
--/* Backprogramm */
--JOIN #snap5 x6
--  ON x1.mandant_id    = x6.mandant_id  AND
--     x1.art_id   = x6.art_id AND
--     x1.the_type = x6.the_type
--/* Blechbelegung A */
--LEFT JOIN #snap6 x7
--  ON x1.mandant_id    = x7.mandant_id  AND
--     x1.art_id   = x7.art_id AND
--     x1.the_type = x7.the_type
--/* Blechbelegung B */
--LEFT JOIN #snap7 x8
--  ON x1.mandant_id    = x8.mandant_id  AND
--     x1.art_id   = x8.art_id AND
--     x1.the_type = x8.the_type    
--/* Blechbelegung C */
--LEFT JOIN #snap8 x9
--  ON x1.mandant_id    = x9.mandant_id  AND
--     x1.art_id   = x9.art_id AND
--     x1.the_type = x9.the_type  
--/* Blechbelegung D */
--LEFT JOIN #snap9 x10
--  ON x1.mandant_id    = x10.mandant_id  AND
--     x1.art_id   = x10.art_id AND
--     x1.the_type = x10.the_type
--GROUP BY 1,2,3,4,5,6,7,8,9,10
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.bake_final_1 (mandant_id,
                                               art_id,
                                               the_type,
                                               bestell_art_id,
                                               inhalt_menge,
                                               back_aufbereitung_id,
                                               back_hinweis_id,
                                               back_programm_id,
                                               blechbelegung,
                                               klart)
SELECT x1.mandant_id,
       x1.art_id,
       x1.the_type,
       x2.bestell_art_id,
       x3.inhalt_menge,
       x4.back_aufbereitung_id,
       x5.back_hinweis_id,
       x6.back_programm_id,
       COALESCE(x7.blechbelegung_a,x8.blechbelegung_b,x9.blechbelegung_c,x10.blechbelegung_d,0) AS blechbelegung,
       x1.klart
FROM _art_mix x1
/* Bestellartikel */
JOIN _snap1 x2
  ON x1.mandant_id = x2.mandant_id AND
     x1.art_id     = x2.art_id     AND
     x1.the_type   = x2.the_type
/* Inhaltsmenge */
JOIN _snap2 x3
  ON x1.mandant_id    = x3.mandant_id  AND
     x1.art_id   = x3.art_id AND
     x1.the_type = x3.the_type
/* Veredlungsschritte */    
JOIN _snap3 x4
  ON x1.mandant_id    = x4.mandant_id  AND
     x1.art_id   = x4.art_id AND
     x1.the_type = x4.the_type
/* Backhinweis */
JOIN _snap4 x5
  ON x1.mandant_id    = x5.mandant_id  AND
     x1.art_id   = x5.art_id AND
     x1.the_type = x5.the_type
/* Backprogramm */
JOIN _snap5 x6
  ON x1.mandant_id    = x6.mandant_id  AND
     x1.art_id   = x6.art_id AND
     x1.the_type = x6.the_type
/* Blechbelegung A */
LEFT JOIN _snap6 x7
  ON x1.mandant_id    = x7.mandant_id  AND
     x1.art_id   = x7.art_id AND
     x1.the_type = x7.the_type
/* Blechbelegung B */
LEFT JOIN _snap7 x8
  ON x1.mandant_id    = x8.mandant_id  AND
     x1.art_id   = x8.art_id AND
     x1.the_type = x8.the_type    
/* Blechbelegung C */
LEFT JOIN _snap8 x9
  ON x1.mandant_id    = x9.mandant_id  AND
     x1.art_id   = x9.art_id AND
     x1.the_type = x9.the_type  
/* Blechbelegung D */
LEFT JOIN _snap9 x10
  ON x1.mandant_id    = x10.mandant_id  AND
     x1.art_id   = x10.art_id AND
     x1.the_type = x10.the_type
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

