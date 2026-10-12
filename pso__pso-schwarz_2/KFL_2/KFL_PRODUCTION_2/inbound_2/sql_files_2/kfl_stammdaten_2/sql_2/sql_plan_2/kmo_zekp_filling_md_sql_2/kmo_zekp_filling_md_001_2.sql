--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.art_gp_wup_zu_per_kmo_md_2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.art_gp_wup_zu_per_kmo_md_2;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE DBX_LOAD.art_gp_wup_zu_per_kmo_md_2,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--  mandant_id              BYTEINT NOT NULL,
--  art_id                  INTEGER NOT NULL,
--  gp_id                   INTEGER NOT NULL,
--  wup_id                  INTEGER NOT NULL,
--  nb_id                   SMALLINT ,
--  einkaufsorganisation_id SMALLINT NOT NULL,
--  dat_von                 DATE FORMAT 'YYYY-MM_2-DD' NOT NULL,
--  dat_bis                 DATE FORMAT 'YYYY-MM_2-DD',
--  ek_brutto               DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_netto                DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_nettonetto           DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_kal_basis            DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_mep                  DECIMAL(18,4),    -- DECIMAL(18,4),
--  einstandspreis          DECIMAL(18,4),    -- DECIMAL(18,4),
--  logistikkostenzuschlag  DECIMAL(18,4) COMPRESS 0.0000 ,
--  bezugsweg_id            BYTEINT NOT NULL,
--  wrg_id                  CHAR(3) CHARACTER SET LATIN CASESPECIFIC COMPRESS 'EUR',
--  komponentenmenge        DECIMAL(18,4) COMPRESS 1.0000 ,
--  ek_brutto_nrfb_rab      DECIMAL(18,4),    -- DECIMAL(18,4),
--  bonusbasis              DECIMAL(18,4),    -- DECIMAL(18,4),
--  bezugsnebenkosten       DECIMAL(18,4),    -- DECIMAL(9,4) COMPRESS 0.0000 ,
--  zollwert                DECIMAL(9,4) COMPRESS 0.0000 ,
--  ek_netto_bnk            DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_netto_bnk_sachk      DECIMAL(18,4),    -- DECIMAL(18,4),
--  cycle_id                INTEGER
--)
--PRIMARY INDEX NUPI_art_gp_wup_zu_per (art_id, wup_id);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_gp_wup_zu_per_kmo_md_2  (
  mandant_id              BYTEINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT ,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat_von                 DATE NOT NULL,
  dat_bis                 DATE,
  ek_brutto               DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),    -- DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),    -- DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4)  ,
  bezugsweg_id            BYTEINT NOT NULL,
  wrg_id                  CHAR(3) COLLATE 'de-cs' ,
  komponentenmenge        DECIMAL(18,4)  ,
  ek_brutto_nrfb_rab      DECIMAL(18,4),    -- DECIMAL(18,4),
  bonusbasis              DECIMAL(18,4),    -- DECIMAL(18,4),
  bezugsnebenkosten       DECIMAL(18,4),    -- DECIMAL(9,4)  ,
  zollwert                DECIMAL(9,4)  ,
  ek_netto_bnk            DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),    -- DECIMAL(18,4),
  cycle_id                INTEGER
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_LOAD.kmo_zekp_md_2
--WHERE abrut = 0 /*ek_brutto*/
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.kmo_zekp_md_2
WHERE abrut = 0 /*ek_brutto*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.art_gp_wup_zu_per_kmo_md_2
--(
--   mandant_id
--  ,art_id
--  ,gp_id
--  ,wup_id
--  ,nb_id
--  ,einkaufsorganisation_id
--  ,dat_von
--  ,dat_bis
--  ,ek_brutto
--  ,ek_netto
--  ,ek_nettonetto
--  ,ek_kal_basis
--  ,ek_mep
--  ,einstandspreis
--  ,logistikkostenzuschlag
--  ,bezugsweg_id
--  ,wrg_id
--  ,komponentenmenge
--  ,ek_brutto_nrfb_rab
--  ,bonusbasis
--  ,bezugsnebenkosten
--  ,zollwert
--  ,ek_netto_bnk
--  ,ek_netto_bnk_sachk
--  ,cycle_id
--)
--SELECT
--   mandant_id
--  ,art_id_
--  ,gp_id
--  ,wup_id
--  ,nb_id
--  ,einkaufsorganisation_id
--  ,dat_von
--  ,dat_bis
--  ,(ek_brutto ) AS ek_brutto
--  ,(ek_netto ) AS ek_netto
--  ,(ek_nettonetto ) AS ek_nettonetto
--  ,(ek_kal_basis ) AS ek_kal_basis
--  ,(ek_mep ) AS ek_mep
--  ,(einstandspreis ) AS einstandspreis
--  ,logistikkostenzuschlag
--  ,bezugsweg_id
--  ,wrg_id
--  ,komponentenmenge
--  ,(ek_brutto_nrfb_rab ) AS ek_brutto_nrfb_rab
--  ,(bonusbasis ) AS bonusbasis
--  ,(bezugsnebenkosten ) AS bezugsnebenkosten
--  ,zollwert
--  ,(ek_netto_bnk ) AS ek_netto_bnk
--  ,(ek_netto_bnk_sachk ) AS ek_netto_bnk_sachk
--  ,cycle_id
--FROM
--(
--  SELECT
--     l.mandant_id
--    ,a.art_id_
--    ,g.gp_id
--    ,CASE WHEN werks IS NULL THEN -1 ELSE w.wup_id END AS wup_id
--    ,CASE WHEN werks IS NULL THEN NULL ELSE w.nb_id END nb_id
--    ,g.einkaufsorganisation_id
--    ,datab AS dat_von
--    ,datbis AS dat_bis
--    ,abrut as ek_brutto
--    ,aknet as ek_netto
--    ,aknne as ek_nettonetto
--    ,ekkba AS ek_kal_basis
--    ,mepre AS ek_mep
--    ,lsein AS einstandspreis
--    ,COALESCE
--     (
--       CASE WHEN w.nb_id <> -111 OR
--                (abrut = 0 AND aknet = 0 AND aknne = 0 AND ekkba = 0 AND mepre = 0 AND lsein = 0)
--            THEN 0
--            ELSE lokau
--       END, 0
--     ) AS logistikkostenzuschlag
--    ,0 AS bezugsweg_id      /* 26.03.2010 in KMO keine Unterscheidung der Bezugswege anhand werks !!!*/
--    ,default_wrg AS wrg_id
--    ,1 AS komponentenmenge  /* wird in einem folenden Schritt aktualisiert */
--    ,abrna AS ek_brutto_nrfb_rab
--    ,abonba AS bonusbasis
--    ,bnk AS bezugsnebenkosten
--    ,zollba AS zollwert
--    ,aknb AS ek_netto_bnk
--    ,aknbs AS ek_netto_bnk_sachk
--    ,cycle_id
--  FROM DBX_LOAD.kmo_zekp_md_2 l
--
--  INNER JOIN
--  (
--    SELECT
--       mandant_id
--      ,kl_art_id
--      ,MAX(art_id) AS art_id_
--    FROM DBX_DATA.art_2
--    GROUP BY
--       mandant_id
--      ,kl_art_id
--  ) a
--  ON l.mandant_id = a.mandant_id
--    AND l.matnr   = a.kl_art_id
--
--  INNER JOIN DBX_DATA.gp_2 g
--  ON l.mandant_id = g.mandant_id
--    AND l.lifnr   = g.gp_id
--
--  INNER JOIN DBX_DATA.mandant_2 m
--  ON l.mandant_id = m.mandant_id
--
--  LEFT OUTER JOIN DBX_DATA.wup_2 w
--  ON l.mandant_id = w.mandant_id
--    AND l.werks   = w.wup_id
--) a
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_md_2
(
   mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,cycle_id
)
SELECT
   mandant_id
  ,art_id_
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,(ek_brutto ) AS ek_brutto
  ,(ek_netto ) AS ek_netto
  ,(ek_nettonetto ) AS ek_nettonetto
  ,(ek_kal_basis ) AS ek_kal_basis
  ,(ek_mep ) AS ek_mep
  ,(einstandspreis ) AS einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,(ek_brutto_nrfb_rab ) AS ek_brutto_nrfb_rab
  ,(bonusbasis ) AS bonusbasis
  ,(bezugsnebenkosten ) AS bezugsnebenkosten
  ,zollwert
  ,(ek_netto_bnk ) AS ek_netto_bnk
  ,(ek_netto_bnk_sachk ) AS ek_netto_bnk_sachk
  ,cycle_id
FROM
(
  SELECT
     l.mandant_id
    ,a.art_id_
    ,g.gp_id
    ,CASE WHEN werks IS NULL THEN -1 ELSE w.wup_id END AS wup_id
    ,CASE WHEN werks IS NULL THEN NULL ELSE w.nb_id END nb_id
    ,g.einkaufsorganisation_id
    ,datab AS dat_von
    ,datbis AS dat_bis
    ,abrut as ek_brutto
    ,aknet as ek_netto
    ,aknne as ek_nettonetto
    ,ekkba AS ek_kal_basis
    ,mepre AS ek_mep
    ,lsein AS einstandspreis
    ,COALESCE
     (
       CASE WHEN w.nb_id <> -111 OR
                (abrut = 0 AND aknet = 0 AND aknne = 0 AND ekkba = 0 AND mepre = 0 AND lsein = 0)
            THEN 0
            ELSE lokau
       END, 0
     ) AS logistikkostenzuschlag
    ,0 AS bezugsweg_id      /* 26.03.2010 in KMO keine Unterscheidung der Bezugswege anhand werks !!!*/
    ,default_wrg AS wrg_id
    ,1 AS komponentenmenge  /* wird in einem folenden Schritt aktualisiert */
    ,abrna AS ek_brutto_nrfb_rab
    ,abonba AS bonusbasis
    ,bnk AS bezugsnebenkosten
    ,zollba AS zollwert
    ,aknb AS ek_netto_bnk
    ,aknbs AS ek_netto_bnk_sachk
    ,cycle_id
  FROM DBP_ETL.kmo_zekp_md_2 l

  INNER JOIN
  (
    SELECT
       mandant_id
      ,kl_art_id
      ,MAX(art_id) AS art_id_
    FROM DBP_DATA.art_2
    GROUP BY
       mandant_id
      ,kl_art_id
  ) a
  ON l.mandant_id = a.mandant_id
    AND l.matnr   = a.kl_art_id

  INNER JOIN DBP_DATA.gp_2 g
  ON l.mandant_id = g.mandant_id
    AND l.lifnr   = g.gp_id

  INNER JOIN DBP_DATA.mandant_2 m
  ON l.mandant_id = m.mandant_id

  LEFT OUTER JOIN DBP_DATA.wup_2 w
  ON l.mandant_id = w.mandant_id
    AND l.werks   = w.wup_id
) a
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.art_gp_wup_zu_per_kmo_md_2
--(
--   mandant_id
--  ,art_id
--  ,gp_id
--  ,wup_id
--  ,nb_id
--  ,einkaufsorganisation_id
--  ,dat_von
--  ,dat_bis
--  ,ek_brutto
--  ,ek_netto
--  ,ek_nettonetto
--  ,ek_kal_basis
--  ,ek_mep
--  ,einstandspreis
--  ,logistikkostenzuschlag
--  ,bezugsweg_id
--  ,wrg_id
--  ,komponentenmenge
--  ,ek_brutto_nrfb_rab
--  ,bonusbasis
--  ,bezugsnebenkosten
--  ,zollwert
--  ,ek_netto_bnk
--  ,ek_netto_bnk_sachk
--  ,cycle_id
--)
--SELECT
--   a.mandant_id
--  ,a.art_id
--  ,a.gp_id
--  ,a.wup_id
--  ,a.nb_id
--  ,a.einkaufsorganisation_id
--  ,a.dat_von
--  ,a.dat_bis
--  ,a.ek_brutto
--  ,a.ek_netto
--  ,a.ek_nettonetto
--  ,a.ek_kal_basis
--  ,a.ek_mep
--  ,a.einstandspreis
--  ,a.logistikkostenzuschlag
--  ,a.bezugsweg_id
--  ,a.wrg_id
--  ,a.komponentenmenge
--  ,a.ek_brutto_nrfb_rab
--  ,a.bonusbasis
--  ,a.bezugsnebenkosten
--  ,a.zollwert
--  ,a.ek_netto_bnk
--  ,a.ek_netto_bnk_sachk
--  ,a.cycle_id
--FROM DBX_DATA.art_gp_wup_zu_per_2 a
--
--INNER JOIN
--(
--  SELECT
--     mandant_id
--    ,art_id
--    ,gp_id
--    ,wup_id
--    ,bezugsweg_id
--    ,MIN(dat_von) AS dat_von_
--  FROM DBX_LOAD.art_gp_wup_zu_per_kmo_md_2
--
--  GROUP BY
--     mandant_id
--    ,art_id
--    ,gp_id
--    ,wup_id
--    ,bezugsweg_id
--) b
--ON a.mandant_id = b.mandant_id
--  AND a.art_id = b.art_id
--  AND a.gp_id = b.gp_id
--  AND a.wup_id = b.wup_id
--  AND a.bezugsweg_id = b.bezugsweg_id
--  AND a.dat_bis >= b.dat_von_   /*Datensatz der in den Gueltigekeitsbereich der neuen Saetze reicht*/
--  AND a.dat_von < b.dat_von_    /*Es muss der Vorgaenger sein, alle anderen werden spaeter sowieso geloescht*/
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_md_2
(
   mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,cycle_id
)
SELECT
   a.mandant_id
  ,a.art_id
  ,a.gp_id
  ,a.wup_id
  ,a.nb_id
  ,a.einkaufsorganisation_id
  ,a.dat_von
  ,a.dat_bis
  ,a.ek_brutto
  ,a.ek_netto
  ,a.ek_nettonetto
  ,a.ek_kal_basis
  ,a.ek_mep
  ,a.einstandspreis
  ,a.logistikkostenzuschlag
  ,a.bezugsweg_id
  ,a.wrg_id
  ,a.komponentenmenge
  ,a.ek_brutto_nrfb_rab
  ,a.bonusbasis
  ,a.bezugsnebenkosten
  ,a.zollwert
  ,a.ek_netto_bnk
  ,a.ek_netto_bnk_sachk
  ,a.cycle_id
FROM DBP_DATA.art_gp_wup_zu_per_2 a

INNER JOIN
(
  SELECT
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,bezugsweg_id
    ,MIN(dat_von) AS dat_von_
  FROM DBP_ETL.art_gp_wup_zu_per_kmo_md_2

  GROUP BY
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,bezugsweg_id
) b
ON a.mandant_id = b.mandant_id
  AND a.art_id = b.art_id
  AND a.gp_id = b.gp_id
  AND a.wup_id = b.wup_id
  AND a.bezugsweg_id = b.bezugsweg_id
  AND a.dat_bis >= b.dat_von_   /*Datensatz der in den Gueltigekeitsbereich der neuen Saetze reicht*/
  AND a.dat_von < b.dat_von_    /*Es muss der Vorgaenger sein, alle anderen werden spaeter sowieso geloescht*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
--original statement
--UPDATE DBX_LOAD.art_gp_wup_zu_per_kmo_md_2
--FROM
--(
--  SELECT
--     l.mandant_id
--    ,l.wup_id
--    ,l.nb_id
--    ,l.art_id
--    ,l.dat_von
--    ,l.gp_id
--    ,l.bezugsweg_id
--    ,l.einkaufsorganisation_id
--    ,CASE WHEN (MSUM(CAST(l.dat_von AS INTEGER), 2, l.dat_von desc) - CAST(l.dat_von AS INTEGER)) = 0
--          THEN CAST(80991231 AS DATE)
--          ELSE CAST((MSUM(CAST(l.dat_von AS INTEGER), 2, l.dat_von desc) - CAST(l.dat_von AS INTEGER)) AS DATE) -1
--     END AS dat_bis_
--  FROM DBX_LOAD.art_gp_wup_zu_per_kmo_md_2 l
--
--  GROUP BY
--     l.mandant_id
--    ,l.wup_id
--    ,l.nb_id
--    ,l.art_id
--    ,l.gp_id
--    ,l.bezugsweg_id
--    ,l.einkaufsorganisation_id
--) dt1
--SET   dat_bis = dt1.dat_bis_
--
--WHERE DBX_LOAD.art_gp_wup_zu_per_kmo_md.mandant_id              = dt1.mandant_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.wup_id                  = dt1.wup_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.art_id                  = dt1.art_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.dat_von                 = dt1.dat_von
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.gp_id                   = dt1.gp_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.einkaufsorganisation_id = dt1.einkaufsorganisation_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.bezugsweg_id            = dt1.bezugsweg_id
--  AND DBX_LOAD.art_gp_wup_zu_per_kmo_md.dat_bis                <> dt1.dat_bis_
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
UPDATE DBP_ETL.art_gp_wup_zu_per_kmo_md_2
SET   dat_bis = dt1.dat_bis_

FROM
(
  SELECT
     l.mandant_id
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,l.dat_von
    ,l.gp_id
    ,l.bezugsweg_id
    ,l.einkaufsorganisation_id
    ,CASE WHEN (MSUM(CAST(l.dat_von AS INTEGER), 2, l.dat_von desc) - CAST(l.dat_von AS INTEGER)) = 0
          THEN to_date('9999-12-31','YYYY-MM_2-DD')
          ELSE CAST((MSUM(CAST(l.dat_von AS INTEGER), 2, l.dat_von desc) - CAST(l.dat_von AS INTEGER)) AS CURRENT_DATE) -1
     END AS dat_bis_
  FROM DBP_ETL.art_gp_wup_zu_per_kmo_md_2 l

  GROUP BY
     l.mandant_id
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,l.gp_id
    ,l.bezugsweg_id
    ,l.einkaufsorganisation_id
) dt1
WHERE DBP_ETL.art_gp_wup_zu_per_kmo_md.mandant_id              = dt1.mandant_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.wup_id                  = dt1.wup_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.art_id                  = dt1.art_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.dat_von                 = dt1.dat_von
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.gp_id                   = dt1.gp_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.einkaufsorganisation_id = dt1.einkaufsorganisation_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.bezugsweg_id            = dt1.bezugsweg_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_md.dat_bis                <> dt1.dat_bis_
;

