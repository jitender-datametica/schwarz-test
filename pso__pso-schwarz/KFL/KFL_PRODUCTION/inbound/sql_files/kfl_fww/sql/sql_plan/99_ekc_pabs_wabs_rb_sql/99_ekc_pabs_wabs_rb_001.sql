--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ekc_preis_abschriften;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE dbp_etl.ekc_preis_abschriften  (
      mandant_id BYTEINT,
      art_id INTEGER,
      bewart_id SMALLINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      dat DATE,
      wrg_id CHAR(3) COLLATE 'en-ci',
      zek_id SMALLINT,
      eigenmarke_fg BYTEINT,
      wup_bereinigt_fg BYTEINT,
      preis_abschrift_netto FLOAT)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.ekc_werbe_abschriften;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE dbp_etl.ekc_werbe_abschriften  (
      mandant_id BYTEINT,
      art_id INTEGER,
      bewart_id SMALLINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      dat DATE,
      wrg_id CHAR(3) COLLATE 'en-ci',
      zek_id SMALLINT,
      eigenmarke_fg BYTEINT,
      wup_bereinigt_fg BYTEINT,
      werbe_abschrift_netto DECIMAL(18,2))
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK' does not exist or not authorized.
INSERT INTO DBP_ETL.ekc_preis_abschriften
SELECT a.mandant_id,
       a.art_id,
       COALESCE(b.bewart_id,1002) AS bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       ROUND(SUM(CAST(a.abschriftbetrag_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))),2) AS preis_abschrift_netto
FROM dbp_data.marktabschriften a
JOIN dbp_etl_process.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN dbp_etl_process.ekc_artbew_flagging b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat
WHERE a.abschriftart_id IN (5,7) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
UNION ALL
SELECT a.mandant_id,
       a.art_id,
       COALESCE(b.bewart_id,1002) AS bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat_umbew AS dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       ROUND(SUM(CASE
             WHEN a.mandant_id IN (2,5) AND a.preis_aend_grund_id IN (7,10)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (6) AND a.preis_aend_grund_id IN (2)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (3) AND a.preis_aend_grund_id IN (11)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             WHEN a.mandant_id IN (4,7,8) AND a.preis_aend_grund_id IN (7)
             THEN CAST(a.diff_wert_bestand_netto AS FLOAT)*COALESCE(CAST(b.anteil AS FLOAT),CAST(1.0000 AS FLOAT))
             ELSE 0
           END),2) AS preis_abschrift_netto
FROM dbp_data.art_umbewertung a
JOIN dbp_etl_process.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
LEFT JOIN dbp_etl_process.ekc_artbew_flagging b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat_umbew = b.dat
WHERE a.mandant_id > 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.EKC_ZEK' does not exist or not authorized.
INSERT INTO DBP_ETL.ekc_werbe_abschriften
SELECT a.mandant_id,
       a.art_id,
       1002 AS bewart_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       SUM(a.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM dbp_data.marktabschriften a
JOIN dbp_etl_process.ekc_zek c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.abschriftart_id = -1 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
UNION ALL
SELECT x.mandant_id,
       x.art_id,
       x.bewart_id,
       x.wup_id,
       x.nb_id,
       x.dat,
       x.wrg_id,
       c.zek_id,
       c.eigenmarke_fg,
       0 AS wup_bereinigt_fg,
       SUM(x.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             1002 AS bewart_id,
             a.dat,
             a.wrg_id,
             SUM(a.abschriftbetrag_netto) AS abschriftbetrag_netto
      FROM dbp_data.marktabschriften_kmo_aktion a
      JOIN dbp_data.art_wg_zu_per b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           b.arthiertyp_id = 2 AND
           b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
      WHERE a.mandant_id > 1 AND
            a.aktion_relevant_fg = 1 AND
           (b.mandant_id, b.wg_id) NOT IN (SELECT mandant_id, wg_id FROM dbp_data.wg_filter_zu WHERE arthiertyp_id = 2 AND wg_filter_id = 2)
      GROUP BY 1,2,3,4,5,6,7
      UNION ALL
      SELECT a.mandant_id,
             a.wup_id,
             a.nb_id,
             a.art_id,
             1002 AS bewart_id,
             a.dat_umbew AS dat,
             a.wrg_id,
             SUM((-1)*a.diff_wert_bestand_netto) AS abschriftbetrag_netto
      FROM dbp_data.art_umbewertung a
      JOIN dbp_data.art_wg_zu_per b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           b.arthiertyp_id = 2 AND
           b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
      WHERE a.mandant_id > 1 AND
            a.preis_aend_grund_id = 6 AND
           (b.mandant_id, b.wg_id) NOT IN (SELECT mandant_id, wg_id FROM dbp_data.wg_filter_zu WHERE arthiertyp_id = 2 AND wg_filter_id = 2)
      GROUP BY 1,2,3,4,5,6,7) x
JOIN dbp_etl_process.ekc_zek c
  ON x.mandant_id = c.mandant_id AND
     x.art_id = c.art_id
GROUP BY 1,2,3,4,5,6,7,8,9,10
;

