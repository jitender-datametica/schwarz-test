CREATE OR REPLACE TABLE dbp_etl.art_wg_zuordnung_zekp_1 AS
SELECT mandant_id,
 dat_von,
 art_id,
 arthiertyp_id,
 wg_id,
 dat_bis,
 wug_id,
 td_update,
 td_insert
FROM dbp_data.art_wg_zu_per_1 AS A
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178);


UPDATE dbp_etl.de_zekp_1 SET
 werks = - 1
WHERE werks = 0;


UPDATE dbp_etl.de_zekp_1 SET
 zollba = 99999.9999
WHERE ABS(zollba / 100) > 99999.9999;


CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp_1 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
gp_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER,
einkaufsorganisation_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
ek_brutto NUMERIC(29,4),
ek_netto NUMERIC(29,4),
ek_nettonetto NUMERIC(29,4),
ek_kal_basis NUMERIC(29,4),
ek_mep NUMERIC(29,4),
einstandspreis NUMERIC(29,4),
logistikkostenzuschlag NUMERIC(29,4),
bezugsweg_id INTEGER,
wrg_id STRING(3),
komponentenmenge NUMERIC(29,4),
ek_brutto_nrfb_rab NUMERIC(29,4),
bonusbasis NUMERIC(29,4),
bezugsnebenkosten NUMERIC(29,4),
zollwert NUMERIC(29,4),
ek_netto_bnk NUMERIC(29,4),
ek_netto_bnk_sachk NUMERIC(29,4),
cycle_id INTEGER
);


/* 1 fuer dezentral  4 fuer zentral */ INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp_1 (mandant_id, art_id,
 gp_id, wup_id, nb_id, einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis,
 ek_mep, einstandspreis, logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis
 , bezugsnebenkosten, zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id)
(SELECT t3.mandant_id AS mandant_id,
  t3.art_id AS art_id,
  t0.lifnr AS gp_id_,
   CASE
   WHEN t0.werks IS NULL
   THEN - 1
   ELSE t0.werks
   END AS wup_id_,
   CASE
   WHEN t0.werks IS NULL OR t0.werks = - 1
   THEN NULL
   ELSE wp.nb_id
   END AS nb_id_,
  COALESCE(t5.einkaufsorganisation_id, 1000) AS einkaufsorganisation_id_,
  DATE(t0.datab) AS dat_von,
  DATE('9999-12-31') AS dat_bis,
   t0.abrut / 100 AS ek_brutto,
   t0.aknet / 100 AS ek_netto,
   t0.aknne / 100 AS ek_nettonetto,
   t0.ekkba / 100 AS ek_kal_basis,
   t0.mepre / 100 AS ek_mep,
   t0.lsein / 100 AS einstandspreis,
  COALESCE(CASE
     WHEN CASE
        WHEN t0.werks IS NULL
        THEN - 1
        ELSE t0.werks
        END = - 1 OR t0.abrut = 0 AND t0.aknet = 0 AND t0.aknne = 0 AND t0.ekkba = 0 AND t0.mepre = 0 AND t0.lsein = 0
     THEN 0
     ELSE t0.lokau / 100
     END, 0)  AS logistikkostenzuschlag,
   CASE
   WHEN CASE
     WHEN t0.werks IS NULL
     THEN - 1
     ELSE t0.werks
     END = - 1
   THEN 1
   ELSE 4
   END AS bezugsweg_id,
  t0.konwa AS wrg_id,
  t0.kompmeng  AS komponentenmenge,
   t0.abrna / 100 AS ek_brutto_nrfb_rab,
   t0.abonba / 100 AS bonusbasis,
   t0.bnk / 100 AS bezugsnebenkosten,
   t0.zollba / 100 AS zollwert,
   t0.aknb / 100 AS ek_netto_bnk,
   t0.aknbs / 100 AS ek_netto_bnk_sachk,
  t0.cycle_id
 FROM (SELECT 0 AS cycle_id,
    matnr,
    lifnr,
    werks,
    datab,
    abrut,
    aknet,
    aknne,
    ekkba,
    mepre,
    lsein,
    konwa,
     CASE
     WHEN kompmeng IS NULL OR kompmeng = 0
     THEN 1
     ELSE kompmeng
     END AS kompmeng,
    lokau,
    abrna,
    abonba,
    bnk,
    zollba,
    aknb,
    aknbs
   FROM dbp_etl.de_zekp_1
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY matnr, lifnr, werks, datab ORDER BY 1 IS NULL, 1)) = 1) AS t0
  INNER JOIN (SELECT kl_art_id,
    art_id,
    mandant_id
   FROM dbp_data.art_1
   WHERE mandant_id = 1
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t3 ON t0.matnr
     = t3.kl_art_id AND t3.mandant_id = 1
  INNER JOIN (SELECT gp_id,
    einkaufsorganisation_id,
    mandant_id
   FROM dbp_data.gp_1
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY gp_id ORDER BY einkaufsorganisation_id IS NULL, einkaufsorganisation_id)) =
     1) AS t5 ON t0.lifnr = t5.gp_id AND t5.mandant_id = 1
  LEFT JOIN (SELECT wup_id,
    mandant_id,
    nb_id
   FROM dbp_data.wup_1) AS wp ON t0.werks = wp.wup_id AND wp.mandant_id = 1);


CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 LIKE dbp_etl.art_gp_wup_zu_per_tmp_1;


INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 (mandant_id, art_id, gp_id, wup_id, nb_id,
 einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
 logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
 zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id)
(SELECT mandant_id,
  art_id,
  gp_id,
  wup_id,
  nb_id,
  einkaufsorganisation_id,
  dat_von,
  dat_bis,
  ek_brutto,
  ek_netto,
  ek_nettonetto,
  ek_kal_basis,
  ek_mep,
  einstandspreis,
  logistikkostenzuschlag,
  bezugsweg_id,
  wrg_id,
  komponentenmenge,
  ek_brutto_nrfb_rab,
  bonusbasis,
  bezugsnebenkosten,
  zollwert,
  ek_netto_bnk,
  ek_netto_bnk_sachk,
  cycle_id
 FROM dbp_etl.art_gp_wup_zu_per_tmp_1);


DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE dat_von >= DATE '2021-09-25';


DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE dat_bis <= DATE '2020-12-31';


DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
WHERE ek_brutto = 0;


UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 SET
 ek_mep = art_gp_wup_zu_per_tmp_xxx.ek_mep + art_gp_wup_zu_per_tmp_xxx.logistikkostenzuschlag FROM (SELECT *
  FROM dbp_etl.art_wg_zuordnung_zekp_1
  WHERE arthiertyp_id = 2
   AND dat_bis = DATE '9999-12-31') AS b
WHERE art_gp_wup_zu_per_tmp_xxx.mandant_id = b.mandant_id AND art_gp_wup_zu_per_tmp_xxx.art_id = b.art_id;


UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 SET
 dat_bis = dt1.dat_bis FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat_von,
   gp_id,
   bezugsweg_id,
   einkaufsorganisation_id,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id, nb_id
          , art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL,
            dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
         , 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis
  FROM (SELECT mandant_id,
     wup_id,
     nb_id,
     art_id,
     dat_von,
     gp_id,
     bezugsweg_id,
     einkaufsorganisation_id
    FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1 AS L
    WHERE mandant_id = 1
    GROUP BY mandant_id,
     art_id,
     gp_id,
     wup_id,
     nb_id,
     einkaufsorganisation_id,
     dat_von,
     bezugsweg_id) AS t1_1) AS dt1
WHERE art_gp_wup_zu_per_tmp_xxx.mandant_id = dt1.mandant_id AND art_gp_wup_zu_per_tmp_xxx.wup_id = dt1.wup_id AND
        COALESCE(art_gp_wup_zu_per_tmp_xxx.nb_id, - 999) = COALESCE(dt1.nb_id, - 999) AND art_gp_wup_zu_per_tmp_xxx.art_id
        = dt1.art_id AND art_gp_wup_zu_per_tmp_xxx.dat_von = dt1.dat_von AND art_gp_wup_zu_per_tmp_xxx.gp_id = dt1.gp_id
      AND art_gp_wup_zu_per_tmp_xxx.einkaufsorganisation_id = dt1.einkaufsorganisation_id AND art_gp_wup_zu_per_tmp_xxx_1
   .bezugsweg_id = dt1.bezugsweg_id AND art_gp_wup_zu_per_tmp_xxx.dat_bis <> dt1.dat_bis;


DELETE FROM dbp_data.art_gp_wup_zu_per_1
WHERE mandant_id = 1 AND dat_bis >= DATE '2021-01-01';


INSERT INTO dbp_data.art_gp_wup_zu_per_1 (mandant_id, gp_id, wup_id, dat_von, bezugsweg_id, art_id, nb_id,
 einkaufsorganisation_id, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, ek_mep_vor_fwu,
 einstandspreis, logistikkostenzuschlag, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
 zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id)
(SELECT mandant_id,
  gp_id,
  wup_id,
  dat_von,
  bezugsweg_id,
  art_id,
  nb_id,
  einkaufsorganisation_id,
  dat_bis,
  ek_brutto,
  ek_netto,
  ek_nettonetto,
  ek_kal_basis,
  ek_mep,
  ek_mep AS ek_mepol,
  einstandspreis,
  logistikkostenzuschlag,
  wrg_id,
  komponentenmenge,
  ek_brutto_nrfb_rab,
  bonusbasis,
  bezugsnebenkosten,
  zollwert,
  ek_netto_bnk,
  ek_netto_bnk_sachk,
  cycle_id
 FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx_1
 WHERE mandant_id = 1);


UPDATE dbp_data.art_gp_wup_zu_per_1 SET
 dat_bis = DATE('2021-09-24')
WHERE dat_bis >= DATE '2021-09-25' AND mandant_id = 1;


UPDATE dbp_data.art_gp_wup_zu_per_1 SET
 dat_bis = dt1.dat_bis FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat_von,
   gp_id,
   bezugsweg_id,
   einkaufsorganisation_id,
    CASE
    WHEN (SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY mandant_id, wup_id, nb_id
          , art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
    THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL,
            dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC)
         , 0) AS STRING)), INTERVAL - 1 DAY)
    END AS dat_bis
  FROM (SELECT mandant_id,
     wup_id,
     nb_id,
     art_id,
     dat_von,
     gp_id,
     bezugsweg_id,
     einkaufsorganisation_id
    FROM dbp_data.art_gp_wup_zu_per_1 AS L
    WHERE mandant_id = 1
    GROUP BY mandant_id,
     gp_id,
     wup_id,
     dat_von,
     bezugsweg_id,
     art_id,
     nb_id,
     einkaufsorganisation_id) AS t1_1) AS dt1
WHERE art_gp_wup_zu_per.mandant_id = dt1.mandant_id AND art_gp_wup_zu_per.wup_id = dt1.wup_id AND COALESCE(art_gp_wup_zu_per_1
         .nb_id, - 999) = COALESCE(dt1.nb_id, - 999) AND art_gp_wup_zu_per.art_id = dt1.art_id AND art_gp_wup_zu_per.dat_von
       = dt1.dat_von AND art_gp_wup_zu_per.gp_id = dt1.gp_id AND art_gp_wup_zu_per.einkaufsorganisation_id = dt1.einkaufsorganisation_id
     AND art_gp_wup_zu_per.bezugsweg_id = dt1.bezugsweg_id AND art_gp_wup_zu_per.dat_bis <> dt1.dat_bis;