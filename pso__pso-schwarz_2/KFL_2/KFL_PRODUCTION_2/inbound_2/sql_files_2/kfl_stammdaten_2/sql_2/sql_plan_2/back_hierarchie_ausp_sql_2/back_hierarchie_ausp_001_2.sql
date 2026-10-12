DROP TABLE IF EXISTS DBP_ETL.bake_final_2;
DROP TABLE IF EXISTS _perf;
DROP TABLE IF EXISTS _JOIN_HELP;
DROP TABLE IF EXISTS DBP_ETL.ausp_work_2;
DROP TABLE IF EXISTS DBP_ETL.cabn_work_2;
DROP TABLE IF EXISTS DBP_ETL.bake_final_de_2;

CREATE TABLE DBP_ETL.bake_final_2  (
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

CREATE TABLE DBP_ETL.bake_final_de_2 (
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

CREATE TABLE DBP_ETL.ausp_work_2 CLONE DBP_ETL.ausp_2;
CREATE TABLE DBP_ETL.cabn_work_2 CLONE DBP_ETL.cabn_2;

CREATE Volatile TABLE _perf AS (
SELECT mandant_id
FROM DBP_ETL.ausp_work_2
GROUP BY 1
);

CREATE Volatile TABLE _join_help  (
  the_type CHAR(1) 
) ;

INSERT INTO _join_help VALUES ('A');
INSERT INTO _join_help VALUES ('B');
INSERT INTO _join_help VALUES ('C');
INSERT INTO _join_help VALUES ('D');
INSERT INTO _join_help VALUES ('E');

INSERT INTO DBP_ETL.bake_final_2 (mandant_id,
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
      FROM DBP_ETL.ausp_work_2 a
      JOIN _join_help b
        ON 1 = 1
      JOIN DBP_DATA.wup_2 c
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
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
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
             to_date(to_char(b.atflv),'YYYYMMDD') as dat_von,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '002' and
            b.atflv <> '3') x3
  ON x1.mandant_id = x3.mandant_id AND
     x1.wup_id     = x3.wup_id     AND
     x1.the_type   = x3.the_type
JOIN (SELECT a.mandant_id,
             b.objek AS wup_id,
             to_date(to_char(b.atflv),'YYYYMMDD') as dat_bis,
             CASE
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00A'
               THEN 'A'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00B'
               THEN 'B'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00C'
               THEN 'C'
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
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
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
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
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
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
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
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
               WHEN SUBSTR(TRIM(a.atnam),12,3) = '00D'
               THEN 'D'
               ELSE 'E'
             END AS the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z30'
      WHERE SUBSTR(TRIM(a.atnam), 8,3) = 'WER' AND
            SUBSTR(TRIM(a.atnam),16,3) = '009') x8
  ON x1.mandant_id = x8.mandant_id AND
     x1.wup_id     = x8.wup_id     AND
     x1.the_type   = x8.the_type
WHERE x7.backplan_fg = 'Y'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

CREATE OR REPLACE TRANSIENT TABLE _art_mix AS (
SELECT a.mandant_id,
             c.art_id,
             b.the_type,
             a.klart
      FROM DBP_ETL.ausp_work_2 a
      JOIN _join_help b
        ON 1 = 1
      JOIN DBP_DATA.art_2 c
        ON a.objek = c.kl_art_id AND
           a.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      WHERE a.klart = 'Z01' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
      GROUP BY 1,2,3,4
);

CREATE Volatile TABLE _snap1 AS (
SELECT a.mandant_id,
             c1.art_id,
             c2.art_id AS bestell_art_id,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn      = b.atinn      AND
           b.klart      = 'Z01'
      JOIN DBP_DATA.art_2 c1
        ON b.objek = c1.kl_art_id AND
           b.mandant_id = c1.mandant_id AND
           CURRENT_DATE BETWEEN c1.dat_von AND c1.dat_bis
      JOIN DBP_DATA.art_2 c2
        ON b.atwrt = c2.kl_art_id AND
           b.mandant_id = c2.mandant_id AND
           CURRENT_DATE BETWEEN c2.dat_von AND c2.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '001' AND
            LENGTH(TRANSLATE(TRIM(b.atwrt),'a1234567890','a')) = 0 AND
            c1.mandant_id IN (SELECT mandant_id FROM _perf) AND
            c2.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE Volatile TABLE _snap2 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS DECIMAL(9,3)) AS inhalt_menge,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '003' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile table _snap3 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_aufbereitung_id,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '004' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap4 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_hinweis_id,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '005' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap5 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS back_programm_id,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 1 = 1
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,3) = '006' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap6 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_a,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'A' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00A2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap7 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_b,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'B' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00B2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap8 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_c,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'C' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00C2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap9 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_d,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'D' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00D2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

CREATE volatile TABLE _snap10 AS (
SELECT a.mandant_id,
             c.art_id,
             CAST(b.atflv AS INTEGER) AS blechbelegung_e,
             d.the_type
      FROM DBP_ETL.cabn_work_2 a
      JOIN DBP_ETL.ausp_work_2 b
        ON a.mandant_id = b.mandant_id AND
           a.atinn = b.atinn AND
           b.klart = 'Z01'
      JOIN DBP_DATA.art_2 c
        ON b.objek = c.kl_art_id AND
           b.mandant_id = c.mandant_id AND
           CURRENT_DATE BETWEEN c.dat_von AND c.dat_bis
      JOIN _join_help d
        ON 'E' = d.the_type
      WHERE SUBSTR(a.atnam, 8,3) = 'MAT' AND
            SUBSTR(a.atnam,16,4) = '00E2' AND
            c.mandant_id IN (SELECT mandant_id FROM _perf)
);

INSERT INTO DBP_ETL.bake_final_2 (mandant_id,
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
       COALESCE(x7.blechbelegung_a,x8.blechbelegung_b,x9.blechbelegung_c,x10.blechbelegung_d,x11.blechbelegung_e,0) AS blechbelegung,
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
/* Blechbelegung E */
LEFT JOIN _snap10 x11
  ON x1.mandant_id    = x11.mandant_id  AND
     x1.art_id   = x11.art_id AND
     x1.the_type = x11.the_type
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

INSERT INTO DBP_ETL.bake_final_de_2
SELECT *
FROM DBP_ETL.bake_final_2
WHERE mandant_id = 1
;

DELETE FROM DBP_ETL.bake_final_2
WHERE mandant_id = 1
;
