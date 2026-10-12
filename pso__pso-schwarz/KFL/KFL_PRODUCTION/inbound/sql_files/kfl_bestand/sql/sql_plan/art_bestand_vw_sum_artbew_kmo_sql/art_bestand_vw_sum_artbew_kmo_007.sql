--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_best_vw_sum_artbew_kmo_tmp
(
  mandant_id,
  wup_id,
  nb_id,
  art_id,
  gp_id,
  wrg_id,
  relevant_fg,
  bezugsweg_id,
  dat,
  menge_abgang_bme,
  betrag_vk_netto_abgang,
  herkunft
)
SELECT
  m.mandant_id,
  m.wup_id,
  m.nb_id,
  m.art_id,
  a.gp_id,
  a.wrg AS wrg_id,
  m.relevant_fg,
  m.bezugsweg_id,
  d.dat,
  a.menge AS menge_abgang_bme,
  a.umsatz_netto,
  'm' AS herkunft
FROM DBP_DATA.marktbestand_erp m,
  DBP_DATA.artbew a,
  DBP_ETL.art_best_vw_sum_artbew_kmo_dat d
WHERE m.mandant_id = a.mandant_id
  AND m.mandant_id = d.mandant_id
  AND d.dat = m.dat
  AND a.dat = d.dat
  AND m.wup_id = a.wup_id
  AND m.nb_id = a.nb_id
  AND m.art_id = a.art_id
  AND a.mandant_id IN (${MIDKMO})
  -- Fuer KMO keine Einschraenkung der bezugsweg_id
  --AND a.bezugsweg_id IN (1, 4)
  --AND m.bezugsweg_id IN (1, 4)
  AND a.bezugsweg_id = m.bezugsweg_id
;

--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_best_vw_sum_artbew_kmo_tmp
(
  mandant_id,
  wup_id,
  nb_id,
  art_id,
  gp_id,
  wrg_id,
  relevant_fg,
  bezugsweg_id,
  dat,
  menge_abgang_bme,
  betrag_vk_netto_abgang,
  herkunft
)
SELECT
  a.mandant_id,
  a.wup_id,
  a.nb_id,
  a.art_id,
  a.gp_id,
  a.wrg_id,
  a.relevant_fg,
  a.bezugsweg_id,
  a.dat,
  a.menge_abgang_bme,
  a.umsatz_netto,
  'a' AS herkunft
FROM
(
  SELECT
    a.mandant_id,
    a.wup_id,
    a.nb_id,
    a.art_id,
    a.gp_id,
    a.wrg AS wrg_id,
    -1 AS relevant_fg,
    a.bezugsweg_id,
    d.dat,
    a.menge AS menge_abgang_bme,
    a.umsatz_netto
  FROM DBP_DATA.artbew a,
    DBP_ETL.art_best_vw_sum_artbew_kmo_dat d
  WHERE a.mandant_id = d.mandant_id
    AND a.dat = d.dat
    -- Fuer KMO keine Einschraenkung der bezugsweg_id
    --AND a.bezugsweg_id IN (1, 4)
    AND a.mandant_id IN (${MIDKMO})
) a

LEFT OUTER JOIN DBP_ETL.art_best_vw_sum_artbew_kmo_tmp m
   ON m.mandant_id   = a.mandant_id
  AND m.dat          = a.dat
  AND m.wup_id       = a.wup_id
  AND m.nb_id        = a.nb_id
  AND m.art_id       = a.art_id
  AND a.bezugsweg_id = m.bezugsweg_id

WHERE m.mandant_id IS NULL
;

--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_best_vw_sum_artbew_tmpk2
(
  mandant_id,
  wup_id,
  nb_id,
  art_id,
  gp_id,
  vw_id,
  relevant_fg,
  bezugsweg_id,
  dat,
  wrg_id,
  menge_abgang_bme,
  betrag_vk_netto_abgang,
  herkunft
)
SELECT
   t.mandant_id
  ,-1     AS wup_id_neu
  ,-1     AS nb_id_neu
  ,t.art_id
  ,t.gp_id
  ,w.vw_id
  ,t.relevant_fg
  ,t.bezugsweg_id
  ,t.dat
  ,t.wrg_id
  ,SUM(t.menge_abgang_bme)
  ,SUM(t.betrag_vk_netto_abgang)
  ,t.herkunft
FROM DBP_ETL.art_best_vw_sum_artbew_kmo_tmp t

INNER JOIN DBP_DATA.wup w
   ON t.mandant_id = w.mandant_id
  AND t.wup_id     = w.wup_id
  AND t.nb_id      = w.nb_id

WHERE t.mandant_id IN (${MIDKMO})
GROUP BY
   t.mandant_id
  ,wup_id_neu
  ,nb_id_neu
  ,t.art_id
  ,t.gp_id
  ,w.vw_id
  ,t.relevant_fg
  ,t.bezugsweg_id
  ,t.dat
  ,t.wrg_id
  ,t.herkunft
;

--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_bestand_vw_sum_kmo_tmp
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,herkunft
)
SELECT
   d.mandant_id
  ,d.vw_id
  ,d.bezugsweg_id
  ,d.lagerbestand_fg
  ,d.nb_id
  ,d.art_id
  ,d.wup_id
  ,d.dat
  ,d.gp_id
  ,d.relevant_fg
  ,d.wrg_id
  ,d.menge_lgbest_erp_frei_bme
  ,d.menge_lgbest_erp_gesamt_bme
  ,d.menge_lgbest_erp_qual_bme
  ,d.betrag_vk_netto_frei_bme
  ,d.betrag_vk_netto_gesamt_bme
  ,d.betrag_vk_netto_qual_bme
  ,t.menge_abgang_bme
  ,t.betrag_vk_netto_abgang
  ,t.herkunft
FROM DBP_DATA.art_bestand_vw_sum d

INNER JOIN DBP_ETL.art_best_vw_sum_artbew_tmpk2 t
   ON d.mandant_id   = t.mandant_id
  AND d.wup_id       = t.wup_id
  AND d.nb_id        = t.nb_id
  AND d.art_id       = t.art_id
  AND d.gp_id        = t.gp_id
  AND d.vw_id        = t.vw_id
  AND d.bezugsweg_id = t.bezugsweg_id
  AND d.dat          = t.dat
  AND d.wrg_id       = t.wrg_id
  AND d.relevant_fg  = t.relevant_fg

WHERE d.mandant_id IN (${MIDKMO})
  AND d.lagerbestand_fg = 0
  AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/
;

--[OK] statement fixed-----------------------------------------------------------------
DELETE FROM DBP_ETL.art_best_vw_sum_artbew_tmpk2
WHERE (mandant_id, vw_id, bezugsweg_id, nb_id, art_id, wup_id, gp_id, relevant_fg, wrg_id, dat) IN
  (SELECT mandant_id, vw_id, bezugsweg_id, nb_id, art_id, wup_id, gp_id, relevant_fg, wrg_id, dat
   FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp
  )
  AND mandant_id IN (${MIDKMO})
  AND herkunft   = 'm'
;

--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_bestand_vw_sum_kmo_tmp
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,herkunft
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,herkunft
FROM
(
  SELECT
     d.mandant_id
    ,d.vw_id
    ,d.bezugsweg_id
    ,d.lagerbestand_fg
    ,d.nb_id
    ,d.art_id
    ,d.wup_id
    ,t.dat
    ,d.dat AS csum_dat
    ,d.gp_id
    ,d.relevant_fg
    ,d.wrg_id
    ,0 AS menge_lgbest_erp_frei_bme
    ,0 AS menge_lgbest_erp_gesamt_bme
    ,0 AS menge_lgbest_erp_qual_bme
    ,0 AS betrag_vk_netto_frei_bme
    ,0 AS betrag_vk_netto_gesamt_bme
    ,0 AS betrag_vk_netto_qual_bme
    ,t.menge_abgang_bme
    ,t.betrag_vk_netto_abgang
    ,t.herkunft
  FROM DBP_ETL.art_best_vw_sum_artbew_tmpk2 t

  INNER JOIN DBP_DATA.art_bestand_vw_sum d
     ON d.mandant_id   = t.mandant_id
    AND d.wup_id       = t.wup_id
    AND d.nb_id        = t.nb_id
    AND d.art_id       = t.art_id
    AND d.gp_id        = t.gp_id
    AND d.vw_id        = t.vw_id
    AND d.bezugsweg_id = t.bezugsweg_id
    AND d.relevant_fg  = t.relevant_fg
    AND d.dat         <= t.dat
    AND d.wrg_id       = t.wrg_id
    AND d.mandant_id   IN (${MIDKMO})
    AND d.lagerbestand_fg = 0

  WHERE t.mandant_id IN (${MIDKMO})
    AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/
)  a
QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
                                     art_id, wup_id, gp_id, relevant_fg, wrg_id, dat
                       ORDER BY csum_dat DESC ROWS UNBOUNDED PRECEDING) = 1
;

--[OK] statement fixed-----------------------------------------------------------------
INSERT INTO DBP_ETL.art_bestand_vw_sum_kmo_tmp
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,herkunft
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
  ,herkunft
FROM
(
  SELECT
     d.mandant_id
    ,d.vw_id
    ,d.bezugsweg_id
    ,d.lagerbestand_fg
    ,d.nb_id
    ,d.art_id
    ,d.wup_id
    ,t.dat
    ,d.dat AS csum_dat
    ,d.gp_id
    ,d.relevant_fg
    ,d.wrg_id
    ,0 AS menge_lgbest_erp_frei_bme
    ,0 AS menge_lgbest_erp_gesamt_bme
    ,0 AS menge_lgbest_erp_qual_bme
    ,0 AS betrag_vk_netto_frei_bme
    ,0 AS betrag_vk_netto_gesamt_bme
    ,0 AS betrag_vk_netto_qual_bme
    ,t.menge_abgang_bme
    ,t.betrag_vk_netto_abgang
    ,t.herkunft
  FROM DBP_ETL.art_best_vw_sum_artbew_tmpk2 t

  INNER JOIN DBP_DATA.art_bestand_vw_sum d
     ON d.mandant_id   = t.mandant_id
    AND d.wup_id       = t.wup_id
    AND d.nb_id        = t.nb_id
    AND d.art_id       = t.art_id
    AND d.gp_id        = t.gp_id
    AND d.vw_id        = t.vw_id
    AND d.bezugsweg_id = t.bezugsweg_id
    AND d.dat         <= t.dat
    AND d.wrg_id       = t.wrg_id

  WHERE d.mandant_id IN (${MIDKMO})
    AND d.lagerbestand_fg = 0
    AND t.herkunft = 'a' /*Herkunft artbew*/
)  a
QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
                                     art_id, wup_id, gp_id, wrg_id, dat
                       ORDER BY csum_dat DESC, relevant_fg ASC ROWS UNBOUNDED PRECEDING) = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_kmo_tmp2
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,SUM(menge_lgbest_erp_frei_bme)
  ,SUM(menge_lgbest_erp_gesamt_bme)
  ,SUM(menge_lgbest_erp_qual_bme)
  ,SUM(betrag_vk_netto_frei_bme)
  ,SUM(betrag_vk_netto_gesamt_bme)
  ,SUM(betrag_vk_netto_qual_bme)
  ,SUM(menge_abgang_bme)
  ,SUM(betrag_vk_netto_abgang)
FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_bestand_vw_sum
WHERE (mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id) IN
   (SELECT mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id
    FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp2
   )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bestand_vw_sum
(
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
)
SELECT
   mandant_id
  ,vw_id
  ,bezugsweg_id
  ,lagerbestand_fg
  ,nb_id
  ,art_id
  ,wup_id
  ,dat
  ,gp_id
  ,relevant_fg
  ,wrg_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_gesamt_bme
  ,menge_lgbest_erp_qual_bme
  ,betrag_vk_netto_frei_bme
  ,betrag_vk_netto_gesamt_bme
  ,betrag_vk_netto_qual_bme
  ,menge_abgang_bme
  ,betrag_vk_netto_abgang
FROM DBP_ETL.art_bestand_vw_sum_kmo_tmp2
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_best_vw_sum_artbew_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_best_vw_sum_artbew_tmpk2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_bestand_vw_sum_kmo_tmp2;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.marktbestand_erp 
SET bezugsweg_id = _bezugsweg_id

FROM (SELECT t01.mandant_id _mandant_id
                                             ,t01.dat _dat
                                             ,t01.wup_id _wup_id
                                             ,t01.art_id _art_id
                                             ,t02.bezugsweg_id _bezugsweg_id
                                       FROM DBP_DATA.marktbestand_erp t01
                                       JOIN DBP_DATA.art_wup_zu_per t02
                                         ON t01.mandant_id = t02.mandant_id AND 
                                            t01.art_id = t02.art_id AND 
                                            t01.wup_id = t02.wup_id
                                       WHERE t01.dat BETWEEN t02.dat_von AND t02.dat_bis AND
                                             t01.dat IN (SELECT dat FROM DBP_ETL.art_best_vw_sum_artbew_kmo_dat) AND
                                             t01.mandant_id > 1) b
 WHERE mandant_id = _mandant_id AND
      wup_id = _wup_id AND 
      art_id = _art_id AND
      dat = _dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _mard_erp_${TRANSIENT_TABLE_SUFFIX} AS (
SELECT a.mandant_id,
       a.dat,
       a.art_id,
       a.relevant_fg,
       a.bezugsweg_id,
       COALESCE(c.gp_id,-1) AS gp_id,
       SUM(a.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
       SUM(a.menge_lgbest_erp_frei_bme + a.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_gesamt_bme,
       SUM(a.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
       CAST(SUM(CAST(b.vk_netto*a.menge_lgbest_erp_frei_bme AS FLOAT)) AS DECIMAL(18,4)) AS betrag_vk_netto_frei_bme,
       CAST(SUM(CAST(b.vk_netto*(a.menge_lgbest_erp_frei_bme + a.menge_lgbest_erp_qual_bme) AS FLOAT)) AS DECIMAL(18,4)) AS betrag_vk_netto_gesamt_bme,
       CAST(SUM(CAST(b.vk_netto*a.menge_lgbest_erp_qual_bme AS FLOAT)) AS DECIMAL(18,4))   AS betrag_vk_netto_qual_bme
FROM DBP_DATA.marktbestand_erp a
LEFT JOIN DBP_DATA.marktbestand_erp_zu b
  ON a.bestand_id = b.bestand_id and
     a.mandant_id = b.mandant_id
LEFT JOIN DBP_DATA.art_gp_nm_zu_per c
  ON a.mandant_id = c.mandant_id AND
     a.dat BETWEEN c.dat_von AND c.dat_bis AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id
WHERE a.mandant_id > 1 AND
      a.dat IN (SELECT dat FROM DBP_ETL.art_best_vw_sum_artbew_kmo_dat) AND
      a.nb_id = 0 
GROUP BY 1,2,3,4,5,6
HAVING SUM(a.menge_lgbest_erp_frei_bme) <> 0
);

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_bestand_vw_sum SET menge_lgbest_erp_frei_bme = 0,
                                        menge_lgbest_erp_qual_bme = 0,
                                        menge_lgbest_erp_gesamt_bme = 0,
                                        betrag_vk_netto_frei_bme = 0,
                                        betrag_vk_netto_qual_bme = 0,
                                        betrag_vk_netto_gesamt_bme = 0
WHERE mandant_id > 1 AND
      dat IN (SELECT dat FROM DBP_ETL.art_best_vw_sum_artbew_kmo_dat) AND
      wup_id = -1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_bestand_vw_sum 
SET menge_lgbest_erp_frei_bme = b.menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme = b.menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme = b.menge_lgbest_erp_gesamt_bme,
    betrag_vk_netto_frei_bme = b.betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme = b.betrag_vk_netto_qual_bme,
    betrag_vk_netto_gesamt_bme = b.betrag_vk_netto_gesamt_bme

FROM (SELECT *
      FROM _mard_erp_${TRANSIENT_TABLE_SUFFIX}) b
      WHERE DBP_DATA.art_bestand_vw_sum.mandant_id = b.mandant_id AND
          DBP_DATA.art_bestand_vw_sum.dat = b.dat AND
          DBP_DATA.art_bestand_vw_sum.art_id = b.art_id AND
          DBP_DATA.art_bestand_vw_sum.relevant_fg = b.relevant_fg AND
          DBP_DATA.art_bestand_vw_sum.gp_id = b.gp_id AND
          DBP_DATA.art_bestand_vw_sum.bezugsweg_id = b.bezugsweg_id AND
          DBP_DATA.art_bestand_vw_sum.wup_id = -1 AND
          DBP_DATA.art_bestand_vw_sum.menge_lgbest_erp_frei_bme <> b.menge_lgbest_erp_frei_bme
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.art_best_vw_sum_artbew_kmo_dat;

