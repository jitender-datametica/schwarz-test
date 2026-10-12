DROP TABLE IF EXISTS dbp_etl.ais_wc_vz_werbeart;


CREATE TABLE IF NOT EXISTS dbp_etl.ais_wc_vz_werbeart (
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
kjwo INTEGER NOT NULL,
akt_wo INTEGER NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
art_id INTEGER NOT NULL,
af_1fw_fg INTEGER NOT NULL,
af_2fw_fg INTEGER NOT NULL,
af_3fw_fg INTEGER NOT NULL,
af_1vw_fg INTEGER NOT NULL,
af_2vw_fg INTEGER NOT NULL,
af_3vw_fg INTEGER NOT NULL,
af_4vw_fg INTEGER NOT NULL,
af_5vw_fg INTEGER NOT NULL,
af_6vw_fg INTEGER NOT NULL,
sa_1vw_fg INTEGER NOT NULL,
sa_ww_fg INTEGER NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.ais_wc_werb_dat;


CREATE TABLE IF NOT EXISTS dbp_etl.ais_wc_werb_dat (
min_wo INTEGER NOT NULL,
max_wo INTEGER NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.ais_wc_vz_dat;


CREATE TABLE IF NOT EXISTS dbp_etl.ais_wc_vz_dat (
dat DATE NOT NULL,
akt_wo INTEGER NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.ais_werbecluster_vz_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.ais_werbecluster_vz_tmp (
mandant_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
auftraggeber_id INTEGER NOT NULL,
akt_wo INTEGER NOT NULL,
art_id INTEGER NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
menge_faktura_bme NUMERIC(29,3) NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.besch_fak_werbecluster_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.besch_fak_werbecluster_tmp (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
kjwo INTEGER NOT NULL,
wg_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
faktura_menge_af_1fw NUMERIC(29,3) NOT NULL,
faktura_menge_af_2fw NUMERIC(29,3) NOT NULL,
faktura_menge_af_3fw NUMERIC(29,3) NOT NULL,
faktura_menge_af_6vw NUMERIC(29,3) NOT NULL,
faktura_menge_sa_1vw NUMERIC(29,3) NOT NULL,
faktura_menge_sa_ww NUMERIC(29,3) NOT NULL
);


INSERT INTO dbp_etl.ais_wc_vz_werbeart (mandant_id, nb_id, wup_id, kjwo, akt_wo, aktion_id, art_id,
 af_1fw_fg, af_2fw_fg, af_3fw_fg, af_1vw_fg, af_2vw_fg, af_3vw_fg, af_4vw_fg, af_5vw_fg, af_6vw_fg, sa_1vw_fg, sa_ww_fg
 )
(SELECT A1.mandant_id,
  A2.nb_id,
  A2.wup_id,
  T2.kjwo,
  T2.akt_wo,
  MAX(A1.aktion_id) AS aktion_id,
  A2.art_id,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  1
 FROM dbp_data.aktion AS A1
  INNER JOIN dbp_data.aktion_art_wup_zu AS A2 ON A1.mandant_id = A2.mandant_id AND A1.aktion_id = A2.aktion_id
       AND A1.bewart_id = A2.bewart_id AND A2.grund_sperrung IS NULL
  INNER JOIN dbp_data.tag AS T1 ON A1.dat_von = T1.dat AND T1.akt_wo >= ${ANZWOCHEN} * - 1 AND T1.akt_wo
      <= - 4 AND T1.wtag_id = 7 AND T1.akt_kj >= - 2
  INNER JOIN dbp_data.tag AS T2 ON A1.dat_bis = T2.dat AND T2.wtag_id IN (6) AND T2.akt_wo = T1.akt_wo +
      1 AND T1.akt_kj >= - 2
 WHERE A1.preisaktiviert_fg = 1
  AND A1.mandant_id = 1
 GROUP BY A1.mandant_id,
  A2.art_id,
  A2.wup_id,
  A2.nb_id,
  T2.kjwo,
  T2.akt_wo);


INSERT INTO dbp_etl.ais_wc_vz_werbeart (mandant_id, nb_id, wup_id, kjwo, akt_wo, aktion_id, art_id,
 af_1fw_fg, af_2fw_fg, af_3fw_fg, af_1vw_fg, af_2vw_fg, af_3vw_fg, af_4vw_fg, af_5vw_fg, af_6vw_fg, sa_1vw_fg, sa_ww_fg
 )
(SELECT W.mandant_id,
  W.nb_id,
  W.wup_id,
  W.kjwo,
   W.akt_wo + (x.af_1fw_fg + x.af_2fw_fg * 2 + x.af_3fw_fg * 3 + x.af_1vw_fg * - 1 + x.af_2vw_fg * - 2 + x.af_3vw_fg * -
          3 + x.af_4vw_fg * - 4 + x.af_5vw_fg * - 5 + x.af_6vw_fg * - 6 + x.sa_1vw_fg * - 1) AS akt_wo,
  W.aktion_id,
  W.art_id,
  x.af_1fw_fg,
  x.af_2fw_fg,
  x.af_3fw_fg,
  x.af_1vw_fg,
  x.af_2vw_fg,
  x.af_3vw_fg,
  x.af_4vw_fg,
  x.af_5vw_fg,
  x.af_6vw_fg,
  x.sa_1vw_fg,
  0 AS sa_ww_fg
 FROM dbp_etl.ais_wc_vz_werbeart AS W
  INNER JOIN (SELECT CASE
     WHEN ROUND(CAST(CAST(akt_tag AS NUMERIC) AS NUMERIC), 0) = 1
     THEN 1
     ELSE 0
     END AS af_1fw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 2 = 1
     THEN 1
     ELSE 0
     END AS af_2fw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 3 = 1
     THEN 1
     ELSE 0
     END AS af_3fw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 4 = 1
     THEN 1
     ELSE 0
     END AS af_1vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 5 = 1
     THEN 1
     ELSE 0
     END AS af_2vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 6 = 1
     THEN 1
     ELSE 0
     END AS af_3vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 7 = 1
     THEN 1
     ELSE 0
     END AS af_4vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 8 = 1
     THEN 1
     ELSE 0
     END AS af_5vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 9 = 1
     THEN 1
     ELSE 0
     END AS af_6vw_fg,
     CASE
     WHEN CAST(akt_tag AS NUMERIC) / 10 = 1
     THEN 1
     ELSE 0
     END AS sa_1vw_fg
   FROM dbp_data.tag AS T
   WHERE akt_tag BETWEEN 1 AND 10) AS x ON TRUE);


INSERT INTO dbp_etl.ais_wc_werb_dat (min_wo, max_wo)
(SELECT MIN(kjwo) AS min_wo,
  MAX(kjwo) AS max_wo
 FROM dbp_etl.ais_wc_vz_werbeart
 HAVING min_wo IS NOT NULL AND max_wo IS NOT NULL);


INSERT INTO dbp_etl.ais_wc_vz_dat (dat, akt_wo)
(SELECT DATE_SUB(T1.dat, INTERVAL 1 DAY),
  T1.akt_wo
 FROM dbp_data.tag AS T1
  INNER JOIN (SELECT MIN(T2.akt_wo) - 6 AS akt_wo_min,
     MAX(T3.akt_wo) + 1 AS akt_wo_max
   FROM (SELECT DISTINCT akt_wo
     FROM dbp_etl.ais_wc_vz_werbeart AS T1) AS t1
    INNER JOIN dbp_data.tag AS T2 ON t1.akt_wo = T2.akt_wo
    INNER JOIN dbp_data.tag AS T3 ON t1.akt_wo = T3.akt_wo) AS x1 ON T1.akt_wo BETWEEN x1.akt_wo_min AND
   x1.akt_wo_max);


INSERT INTO dbp_etl.ais_werbecluster_vz_tmp (mandant_id, nb_id, wup_id, auftraggeber_id, akt_wo, art_id,
 aktion_id, menge_faktura_bme)
(SELECT mandant_id,
  nb_id,
  wup_id,
  CAST(auftraggeber_id AS INTEGER) AS auftraggeber_id,
  akt_wo,
  art_id,
  aktion_id,
  menge_faktura_bme
 FROM (SELECT F1.mandant_id,
     F2.nb_id,
     F2.wup_id,
     ROUND(CAST(CASE
        WHEN F1.auftraggeber_id = ''
        THEN SUBSTR(CAST(- 1 AS STRING), 1, 10)
        ELSE F1.auftraggeber_id
        END AS BIGNUMERIC), 0) AS auftraggeber_id,
     D1.akt_wo,
     F2.art_id,
     MAX(F2.aktion_id) AS aktion_id,
     SUM(F2.menge_faktura_bme) AS menge_faktura_bme
    FROM dbp_etl.ais_wc_vz_dat AS D1
     INNER JOIN dbp_data.besch_faktura_det AS F2 ON D1.dat = F2.dat_faktura AND F2.aktion_id <> ''
     INNER JOIN dbp_data.besch_faktura AS F1 ON F2.dat_faktura_sap = F1.dat_faktura_sap AND F2.faktura_beleg_id
         = F1.faktura_beleg_id AND F1.mandant_id = 1
    GROUP BY F1.mandant_id,
     F2.nb_id,
     F2.wup_id,
     auftraggeber_id,
     D1.akt_wo,
     F2.art_id
    UNION ALL
    SELECT F1.mandant_id,
     F2.nb_id,
     F2.wup_id,
     ROUND(CAST(CASE
        WHEN F1.auftraggeber_id = ''
        THEN SUBSTR(CAST(- 1 AS STRING), 1, 10)
        ELSE F1.auftraggeber_id
        END AS BIGNUMERIC), 0) AS auftraggeber_id,
     D1.akt_wo,
     F2.art_id,
     '' AS aktion_id,
     SUM(F2.menge_faktura_bme) AS menge_faktura_bme
    FROM dbp_etl.ais_wc_vz_dat AS D1
     INNER JOIN dbp_data.besch_faktura_det AS F2 ON D1.dat = F2.dat_faktura AND F2.aktion_id = ''
     INNER JOIN dbp_data.besch_faktura AS F1 ON F2.dat_faktura_sap = F1.dat_faktura_sap AND F2.faktura_beleg_id
         = F1.faktura_beleg_id AND F1.mandant_id = 1
    GROUP BY F1.mandant_id,
     F2.nb_id,
     F2.wup_id,
     auftraggeber_id,
     D1.akt_wo,
     F2.art_id) AS t4);


INSERT INTO dbp_etl.besch_fak_werbecluster_tmp (mandant_id, wup_id, nb_id, kjwo, wg_id, art_id,
 faktura_menge_af_1fw, faktura_menge_af_2fw, faktura_menge_af_3fw, faktura_menge_af_6vw, faktura_menge_sa_1vw,
 faktura_menge_sa_ww)
(SELECT W2.mandant_id,
  W2.wup_id,
  W2.nb_id,
  W1.kjwo,
  W3.wg_id,
  W2.art_id,
  CAST(SUM(W1.af_1fw_fg * W2.menge_faktura_bme) AS NUMERIC) AS faktura_menge_af_1fw,
  CAST(SUM(W1.af_2fw_fg * W2.menge_faktura_bme) AS NUMERIC) AS faktura_menge_af_2fw,
  CAST(SUM(W1.af_3fw_fg * W2.menge_faktura_bme) AS NUMERIC) AS faktura_menge_af_3fw,
   SUM(CASE
          WHEN W2.aktion_id = ''
          THEN W1.af_1vw_fg * W2.menge_faktura_bme
          ELSE 0
          END + CASE
          WHEN W2.aktion_id = ''
          THEN W1.af_2vw_fg * W2.menge_faktura_bme
          ELSE 0
          END + CASE
         WHEN W2.aktion_id = ''
         THEN W1.af_3vw_fg * W2.menge_faktura_bme
         ELSE 0
         END + CASE
        WHEN W2.aktion_id = ''
        THEN W1.af_4vw_fg * W2.menge_faktura_bme
        ELSE 0
        END + CASE
       WHEN W2.aktion_id = ''
       THEN W1.af_5vw_fg * W2.menge_faktura_bme
       ELSE 0
       END + CASE
      WHEN W2.aktion_id = ''
      THEN W1.af_6vw_fg * W2.menge_faktura_bme
      ELSE 0
      END) / 6 AS faktura_menge_af_6vw,
  CAST(SUM(CASE
     WHEN W1.aktion_id = W2.aktion_id
     THEN W1.sa_1vw_fg * W2.menge_faktura_bme
     ELSE 0
     END) AS NUMERIC) AS faktura_menge_sa_1vw,
  CAST(SUM(CASE
     WHEN W1.aktion_id = W2.aktion_id
     THEN W1.sa_ww_fg * W2.menge_faktura_bme
     ELSE 0
     END) AS NUMERIC) AS faktura_menge_sa_ww
 FROM dbp_etl.ais_wc_vz_werbeart AS W1
  INNER JOIN dbp_data.art_wg_zu_per AS W3 ON W1.mandant_id = W3.mandant_id AND W1.art_id = W3.art_id AND
     W3.arthiertyp_id = 2 AND W3.dat_bis = PARSE_DATE('%F', '9999-12-31')
  INNER JOIN dbp_etl.ais_werbecluster_vz_tmp AS W2 ON W1.mandant_id = W2.mandant_id AND W1.wup_id = W2.auftraggeber_id
       AND W1.akt_wo = W2.akt_wo AND W1.art_id = W2.art_id
 GROUP BY W2.mandant_id,
  W2.wup_id,
  W2.nb_id,
  W1.kjwo,
  W3.wg_id,
  W2.art_id);


DELETE FROM dbp_data.besch_faktura_werbecluster
WHERE kjwo BETWEEN (SELECT min_wo
  FROM dbp_etl.ais_wc_werb_dat) AND (SELECT max_wo
  FROM dbp_etl.ais_wc_werb_dat);


INSERT INTO dbp_data.besch_faktura_werbecluster
(SELECT mandant_id,
  wup_id,
  nb_id,
  kjwo,
  wg_id,
  art_id,
  faktura_menge_af_1fw,
  faktura_menge_af_2fw,
  faktura_menge_af_3fw,
  faktura_menge_af_6vw,
  faktura_menge_sa_1vw,
  faktura_menge_sa_ww,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM dbp_etl.besch_fak_werbecluster_tmp);