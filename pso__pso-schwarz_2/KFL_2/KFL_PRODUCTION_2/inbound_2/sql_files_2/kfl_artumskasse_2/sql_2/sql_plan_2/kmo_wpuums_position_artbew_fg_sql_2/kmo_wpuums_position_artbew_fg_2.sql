
/*
#------------------------------------------------------------------------------
# 2.) Neuanlegen der Lade Tabellen DBP_ETL.position_artbew_bon_2 und
#     kmo_artbew_bon_promotion_2
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE DBP_ETL.position_artbew_bon_2
(
  -- Informationen stammen aus Bon Kopf
  mandant_id          BYTEINT,
  bon_id              VARCHAR(25) ,
  dat_booking         DATE,
  wup_id              INTEGER,
  bon_zeile           INTEGER,
  kl_art_id           INTEGER,
  ean_kasse           DECIMAL(26,0),
  menge               DECIMAL(18,4),
  umsatz_brutto       DECIMAL(18,4),
  wg_id               INTEGER,
  lkp_art_id          INTEGER,
  lkp_nb_id           SMALLINT,
  lkp_wg_id           SMALLINT,
  lkp_arthiertyp_id   BYTEINT,
  lkp_zek_id          SMALLINT,
  lkp_mwst_id         BYTEINT,
  lkp_posten_id       CHAR(4) ,
  lkp_umrechnungskurs FLOAT,
  lkp_mwst            DECIMAL(12,2),
  lkp_wrg             CHAR(3) 
  )
;



-- Tabelle fuer die relevanten Promotionsbetraege
CREATE OR REPLACE TABLE DBP_ETL.position_artbew_bon_promotion_2
(
  mandant_id            BYTEINT,
  bon_id                VARCHAR(25) ,
  dat_booking           DATE,
  kl_art_id             INTEGER,
  bon_zeile             INTEGER,
  bonuskauf_id          CHAR(20) ,
  konditionsart_id      CHAR(10) ,
  umsatz_brutto         DECIMAL(18,4),
  umsatz_promo_brutto   DECIMAL(18,4),
  menge_promo           DECIMAL(18,3)
)
;


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabelle
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE DBP_ETL.position_artbew_bon_dat_2
(  dat DATE NOT NULL)
;

CREATE  OR REPLACE TABLE DBP_ETL.position_artbew_bon_delta_2
(
  mandant_id  BYTEINT NOT NULL,
  wup_id      INTEGER NOT NULL,
  dat_booking DATE NOT NULL,
  xml_name    VARCHAR(255)
)
;

/*
#------------------------------------------------------------------------------
# 3.) Relevante Markttage ermitteln
#------------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.position_artbew_bon_delta_2
(
   mandant_id
  ,wup_id
  ,dat_booking
  ,xml_name
)
SELECT
   k.mandant_id
  ,k.wup_id
  ,k.dat_booking
  ,b.xml_name
FROM DBP_ODS.ods_bon_kopf_2 k

INNER JOIN DBP_ODS.ods_bon_transaction_2 t
ON t.bon_id = k.bon_id
  AND t.mandant_id = k.mandant_id
  AND t.wup_id = k.wup_id
  AND t.mandant_id = 3
  AND t.kassensystem_name = 'POSITION'

INNER JOIN DBP_ODS.bon_load_status_2 b
ON b.xml_name = t.datei_name
  AND b.artbew_fg = 0

WHERE k.mandant_id = 3
   AND k.dat_booking <= CURRENT_DATE -1 

GROUP BY 1,2,3,4
;



/*
#------------------------------------------------------------------------------
# 3.) Befuellen der temporaeren Tabelle kmo_artbew_bon_2
#     Es werden nur Kopf und Zeile zusammengefasst und untersucht, die
#     Promotionsbetraege sind direkt von der Zeile abgeleitet und werden
#     abschliend fuer die RFI geprueften Zeilen ermittelt.
#------------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.position_artbew_bon_2
(
   mandant_id
  ,bon_id
  ,dat_booking
  ,wup_id
  ,kl_art_id
  ,ean_kasse
  ,bon_zeile
  ,menge
  ,umsatz_brutto
  ,wg_id
)
SELECT
   k.mandant_id
  ,k.bon_id
  ,k.dat_booking
  ,k.wup_id
  ,z.kl_art_id
  ,z.ean_kasse
  ,z.bon_zeile
  ,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
        THEN z.menge * (-1)
        ELSE z.menge
   END AS menge_
  ,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
        THEN z.umsatz_brutto * (-1)
        ELSE z.umsatz_brutto
   END AS umsatz_brutto_
  ,z.wg_id
FROM DBP_ODS.ods_bon_kopf_2 k

-- Gesamten Markttag holen
INNER JOIN
(
  SELECT
     mandant_id
    ,wup_id
    ,dat_booking
  FROM DBP_ETL.position_artbew_bon_delta_2
  GROUP BY 1,2,3
) d
ON k.mandant_id = d.mandant_id
  AND k.wup_id = d.wup_id
  AND k.dat_booking = d.dat_booking

INNER JOIN DBP_ODS.ods_bon_verkauf_2 z
ON k.mandant_id = z.mandant_id
  AND k.bon_id = z.bon_id
  AND k.wup_id = z.wup_id

INNER JOIN DBP_ODS.ods_bon_transaction_2 t
ON k.mandant_id = t.mandant_id
  AND k.bon_id = t.bon_id
  AND k.wup_id = t.wup_id

WHERE k.mandant_id = 3
  AND k.kunde_fg = 1
  AND k.turnover_fg = 1
  AND
  (
    -- pro Mandant_2 kann hier ein spezieller Filter eingebaut werden
    CASE WHEN k.mandant_id = 8 THEN 1
         WHEN k.mandant_id = 3 AND k.kasse_nr NOT IN (241) THEN 1
         WHEN k.mandant_id = 7 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 2 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 6 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 5 AND k.kasse_nr NOT IN (241,242) THEN 1
         ELSE 0
    END
  ) = 1

  AND (k.bon_id, k.wup_id) NOT IN
  (
    SELECT
       bon_id
      ,wup_id
    FROM DBP_ODS.ods_bon_storno_2
  )

UNION

SELECT
   k.mandant_id
  ,k.bon_id
  ,k.dat_booking
  ,k.wup_id
  ,z.kl_art_id
  ,z.ean_kasse
  ,z.bon_zeile
   -- Mengen Flag beruecksichtigen (Vorgabe David vom 18.03.)
  ,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
        THEN z.menge * (-1)
        ELSE z.menge
   END * z.menge_fg AS menge_
  ,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
        THEN z.umsatz_brutto * (-1)
        ELSE z.umsatz_brutto
   END AS umsatz_brutto_
  ,z.wg_id
FROM DBP_ODS.ods_bon_kopf_2 k

-- Gesamten Markttag holen
INNER JOIN
(
  SELECT
     mandant_id
    ,wup_id
    ,dat_booking
  FROM DBP_ETL.position_artbew_bon_delta_2
  GROUP BY 1,2,3
) d
ON k.mandant_id = d.mandant_id
  AND k.wup_id = d.wup_id
  AND k.dat_booking = d.dat_booking

INNER JOIN DBP_ODS.ods_bon_retoure_2 z
ON k.mandant_id = z.mandant_id
  AND k.bon_id = z.bon_id
  AND k.wup_id = z.wup_id

INNER JOIN DBP_ODS.ods_bon_transaction_2 t
ON k.mandant_id = t.mandant_id
  AND k.bon_id = t.bon_id
  AND k.wup_id = t.wup_id

WHERE k.mandant_id = 3
  AND k.kunde_fg = 1
  AND k.turnover_fg = 1
  AND
  (
    -- pro Mandant_2 kann hier ein spezieller Filter eingebaut werden
    CASE WHEN k.mandant_id = 8 THEN 1
         WHEN k.mandant_id = 3 AND k.kasse_nr NOT IN (241) THEN 1
         WHEN k.mandant_id = 7 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 2 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 6 AND k.kasse_nr NOT IN (241,242) THEN 1
         WHEN k.mandant_id = 5 AND k.kasse_nr NOT IN (241,242) THEN 1
         ELSE 0
    END
  ) = 1

  AND (k.bon_id, k.wup_id) NOT IN
    (
      SELECT
         bon_id
        ,wup_id
      FROM DBP_ODS.ods_bon_storno_2
    )

;

/*
#------------------------------------------------------------------------------
# 8.) Anreichern der Ladetabelle mit den Lookupschluesseln
#     mandant_id, art_id, wup_id, nb_id, zek_id, wg_id
#------------------------------------------------------------------------------
*/

-- wup_id, nb_id
UPDATE DBP_ETL.position_artbew_bon_2
FROM DBP_DATA.wup_2 w

SET lkp_nb_id = w.nb_id

WHERE DBP_ETL.position_artbew_bon.mandant_id = w.mandant_id
  AND DBP_ETL.position_artbew_bon.wup_id = w.wup_id
;


-- art_id, zek_id, mwst_id, posten_id
UPDATE DBP_ETL.position_artbew_bon_2
FROM
(
  SELECT
     mandant_id
    ,kl_art_id
    ,art_id
    ,zek_id
    ,mwst_id
    ,posten_id
  FROM DBP_DATA.art_2 a
  QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,kl_art_id ORDER BY art_id desc)=1

) dt
SET lkp_art_id = dt.art_id
  , lkp_zek_id = dt.zek_id
  , lkp_mwst_id = dt.mwst_id
  , lkp_posten_id = dt.posten_id

WHERE DBP_ETL.position_artbew_bon.mandant_id = dt.mandant_id
  AND DBP_ETL.position_artbew_bon.kl_art_id = dt.kl_art_id
;

 

-- wg_id, arthiertyp_id
UPDATE DBP_ETL.position_artbew_bon_2
FROM DBP_DATA.art_wg_zu_per_2 w

SET lkp_wg_id = w.wg_id
  , lkp_arthiertyp_id = w.arthiertyp_id

WHERE DBP_ETL.position_artbew_bon.mandant_id = w.mandant_id
  AND DBP_ETL.position_artbew_bon.lkp_art_id = w.art_id
  AND w.dat_bis = '9999-12-31'
  AND w.arthiertyp_id = 2
;

 

-- Waehrung
UPDATE DBP_ETL.position_artbew_bon_2
FROM DBP_DATA.mandant_2 m

SET lkp_wrg = m.default_wrg

WHERE DBP_ETL.position_artbew_bon.mandant_id = m.mandant_id
;

 

-- Umrechnungskurs
UPDATE DBP_ETL.position_artbew_bon_2
FROM DBP_DATA.kurs_2 k

SET lkp_umrechnungskurs = k.umrechnungskurs

WHERE DBP_ETL.position_artbew_bon.lkp_wrg = k.von_wrg_id
  AND DBP_ETL.position_artbew_bon.dat_booking BETWEEN k.dat_von ANd k.dat_bis
  AND k.kurstyp_id = 9
  AND k.nach_wrg_id = 'EUR'
;

 

-- MWST Satz
UPDATE DBP_ETL.position_artbew_bon_2
FROM DBP_DATA.mwst_per_2 m

SET lkp_mwst = m.mwst

WHERE DBP_ETL.position_artbew_bon.mandant_id = m.mandant_id
  AND DBP_ETL.position_artbew_bon.lkp_mwst_id = m.mwst_id
  AND DBP_ETL.position_artbew_bon.dat_booking BETWEEN m.dat_von AND m.dat_bis
;


/*
#------------------------------------------------------------------------------
# 10.) Befuellen der temporaeren Tabelle DBP_ETL.position_artbew_bon_dat_2
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.position_artbew_bon_dat_2
(  dat)
SELECT   dat_booking
FROM DBP_ETL.position_artbew_bon_2
GROUP BY dat_booking
;

 

/*
#------------------------------------------------------------------------------
# 14.) Ermittlung der Promotionsbetraege fuer die RFI geprueften Bonzeilen
#      Da die Datentypen korrekt sind und die Promotionsbetraege direkt von
#      den Bonzeilen abgeleitet ist keine separate RFI Pruefung erforderlich
#------------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.position_artbew_bon_promotion_2
(
   mandant_id
  ,bon_id
  ,dat_booking
  ,kl_art_id
  ,bon_zeile
  ,bonuskauf_id
  ,konditionsart_id
  ,umsatz_brutto
  ,umsatz_promo_brutto
  ,menge_promo
)
SELECT
   k.mandant_id
  ,k.bon_id
  ,k.dat_booking
  ,k.kl_art_id
  ,k.bon_zeile
  ,p.bonuskauf_id
  ,p.konditionsart_id
  ,SUM(p.betrag_promo_brutto * (-1)) AS umsatz_brutto
  ,SUM(p.umsatz_promo_brutto) AS umsatz_promo_brutto
  ,SUM(p.menge_promo) AS menge_promo

FROM DBP_ETL.position_artbew_bon_2 k

INNER JOIN DBP_ODS.ods_promotion_2 p
ON k.mandant_id = p.mandant_id
  AND k.bon_id = p.bon_id
  AND k.bon_zeile = p.bon_zeile

WHERE COALESCE(p.betrag_promo_brutto, 0) <> 0

GROUP BY
   k.mandant_id
  ,k.bon_id
  ,k.dat_booking
  ,k.kl_art_id
  ,k.bon_zeile
  ,p.bonuskauf_id
  ,p.konditionsart_id
;


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE DBP_ETL.position_artbew_bon_aktion_relevant_2
(
  mandant_id  BYTEINT NOT NULL,
  aktion_id   CHAR(10) NOT NULL,
  bewart_id   SMALLINT NOT NULL,
  dat         DATE NOT NULL,
  art_id      INTEGER NOT NULL,
  wup_id      INTEGER NOT NULL,
  nb_id       SMALLINT NOT NULL,
  anz_aktion  SMALLINT NOT NULL
)
;


CREATE OR REPLACE  TABLE DBP_ETL.artbew_position_tmp_2 
     (
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      bewart_id SMALLINT NOT NULL ,
      gp_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL  ,
      art_id INTEGER NOT NULL,
      dat DATE  NOT NULL,
      aktion_id CHAR(10) DEFAULT '          ' NOT NULL,
      promo_fg BYTEINT DEFAULT 0 NOT NULL ,
      ean_kasse DECIMAL(26,0) DEFAULT 0 NOT NULL ,
      einkaufsorganisation_id SMALLINT,
      herst_id INTEGER,
      mwst_id BYTEINT NOT NULL,
      menge DECIMAL(18,3),
      wrg_2 CHAR(3) ,
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4),
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4),
      ek_brutto DECIMAL(18,4),
      diff_ek_brutto_konz DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      diff_ek_netto_konz DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      diff_ek_nettonetto_konz DECIMAL(18,4),
      ek_kal_basis DECIMAL(18,4),
      diff_ek_kal_basis_konz DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      diff_ek_mep_konz DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      diff_einstandspreis_konz DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      diff_logkostenzuschlag_konz DECIMAL(18,4),
      bezugsweg_id BYTEINT,
      ek_netto_bnk DECIMAL(18,4),
      diff_ek_netto_bnk_konz DECIMAL(18,4),
      ek_netto_bnk_sachk DECIMAL(18,4),
      diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
      posten_id CHAR(2) ,
      bq_findung_id BYTEINT,
      ek_gld DECIMAL(18,4),
      diff_ek_gld_konz DECIMAL(18,4)
      )
;
 

/*
#------------------------------------------------------------------------------
# 3.) Befuellen der tempoeraren Tabelle DBP_ETL.position_artbew_bon_aktion_relevant_2
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.position_artbew_bon_aktion_relevant_2
(
   mandant_id
  ,aktion_id
  ,bewart_id
  ,dat
  ,art_id
  ,wup_id
  ,nb_id
  ,anz_aktion
)
SELECT
   aa.mandant_id
  ,aa.max_aktion_id
  ,aa.bewart_id
  ,aa.dat
  ,aa.art_id
  ,aa.wup_id
  ,aa.nb_id
  ,aa.anz_aktion
FROM
(
  SELECT
     mandant_id
    ,MAX(aktion_id) AS max_aktion_id
    ,bewart_id
    ,dat
    ,art_id
    ,wup_id
    ,nb_id
    ,MAX(zaehler) AS anz_aktion
  FROM
  (
    SELECT
       a.mandant_id
      ,a.aktion_id
      ,a.bewart_id
      ,d.dat
      ,aaw.art_id
      ,aaw.wup_id
      ,aaw.nb_id
      ,ROW_NUMBER()
       OVER (PARTITION BY a.mandant_id, a.bewart_id, aaw.art_id, aaw.wup_id, aaw.nb_id, d.dat ORDER BY a.dat_von)
       AS zaehler
    FROM DBP_DATA.aktion_2 a

    INNER JOIN DBP_DATA.aktion_art_wup_zu_2 aaw
    ON a.mandant_id = aaw.mandant_id
      AND a.aktion_id = aaw.aktion_id
      AND a.bewart_id = aaw.bewart_id

    INNER JOIN DBP_ETL.position_artbew_bon_dat_2 d
    ON d.dat BETWEEN a.dat_von AND a.dat_bis

    WHERE a.mandant_id <> 1  -- nur KMO Mandanten
      AND a.bewart_id = 1002 -- Kennzeichen Aktion_2
      AND (UPPER(aaw.grund_sperrung) <> 'X'  OR aaw.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_2, Artikel_2, Wup_2 aktiv
  ) a
  GROUP BY 1, 3 ,4, 5, 6, 7
) aa
;

 

/*
#------------------------------------------------------------------------------
# 5.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_kmo_tmp_2
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.artbew_position_tmp_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_2
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,promo_fg
  ,ean_kasse
--  ,umrechnungskurs
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_2
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,promo_fg
  ,ean_kasse
--  ,umrechnungskurs
FROM
(
  SELECT
     l.mandant_id AS mandant_id
    ,l.wup_id AS wup_id
    ,lkp_nb_id AS nb_id
    ,lkp_art_id AS art_id
    ,-1 AS gp_id
    ,-1 AS einkaufsorganisation_id
    ,COALESCE(r.bewart_id, 1001) AS bewart_id
    ,dat_booking AS dat
    ,CASE WHEN r.anz_aktion = 1 -- wenn genau eine_2 Aktion_2 vorhanden ist, diese eintragen
          THEN r.aktion_id
          ELSE ''
     END AS aktion_id
    ,-1 AS herst_id
    ,lkp_mwst_id AS mwst_id
    ,lkp_wrg AS wrg_2
    ,COALESCE(lkp_posten_id, ' ') AS posten_id
    ,0 AS bezugsweg_id
    ,menge_ AS menge
     -- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)
    ,(umsatz_brutto_ + umsatz_promotion_brutto_) AS umsatz_brutto_ohne_promo
    ,CAST(umsatz_brutto_ohne_promo / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto
    ,(umsatz_brutto_ohne_promo - umsatz_netto) AS umsatz_mwst_betrag
     -- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
     -- im abschlisenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)
    ,promo_fg
    ,ean_kasse
    ,lkp_umrechnungskurs AS umrechnungskurs
  FROM
  (
    -- Bonzeilen zusammenfassen damit keine Rundungsdifferenzen bei der MWST
    -- Berechnung im Vergleich zur Wpuums auftreten.
    SELECT
       mandant_id
      ,wup_id
      ,lkp_nb_id
      ,lkp_art_id
      ,lkp_posten_id
      ,dat_booking
      ,lkp_mwst
      ,lkp_mwst_id
      ,lkp_wrg
      ,lkp_umrechnungskurs
      ,promo_fg
      ,ean_kasse  /*Datenlieferung an Externe, kommt erst noch... */
      ,SUM(umsatz_brutto) AS umsatz_brutto_
      ,SUM(menge) AS menge_
      ,SUM(umsatz_promotion_brutto) AS umsatz_promotion_brutto_
    FROM
    (
      -- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
      SELECT
         z.mandant_id
        ,z.bon_id
        ,z.wup_id
        ,z.lkp_nb_id
        ,z.lkp_art_id
        ,z.lkp_posten_id
        ,z.dat_booking
        ,z.bon_zeile
        ,z.umsatz_brutto
        ,z.menge
        ,z.lkp_mwst
        ,z.lkp_mwst_id
        ,z.lkp_wrg
        ,z.lkp_umrechnungskurs
        ,COALESCE(promotion_brutto, 0) AS umsatz_promotion_brutto
        ,CASE WHEN umsatz_promotion_brutto <> 0
              THEN 1
              ELSE 0
         END AS promo_fg /*Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist*/
        ,z.ean_kasse
      FROM DBP_ETL.position_artbew_bon_2 z

      -- Ermittlung Promotionsbetrag pro Bon Zeile
      LEFT OUTER JOIN
      (
        SELECT
           mandant_id
          ,bon_id
          ,dat_booking
          ,bon_zeile
          ,SUM(umsatz_brutto) AS promotion_brutto
        FROM DBP_ETL.position_artbew_bon_promotion_2

        GROUP BY 1,2,3,4
      ) p
      ON z.mandant_id = p.mandant_id
        AND z.bon_id = p.bon_id
        AND z.dat_booking = p.dat_booking
        AND z.bon_zeile = p.bon_zeile
    ) z
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
  ) l

  LEFT OUTER JOIN DBP_ETL.position_artbew_bon_aktion_relevant_2 r
  ON l.mandant_id = r.mandant_id
    AND l.lkp_art_id = r.art_id
    AND l.wup_id = r.wup_id
    AND l.lkp_nb_id = r.nb_id
    AND l.dat_booking = r.dat
) a
;

 
DELETE FROM DBP_DATA.artbew_promotion_zu_2 a
USING DBP_ETL.position_artbew_bon_dat_2 
WHERE a.dat = DBP_ETL.position_artbew_bon_dat.dat
  AND (a.mandant_id, a.wup_id, a.dat) IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,dat
    FROM DBP_ETL.artbew_position_tmp_2
    WHERE promo_fg = 1
  )
  -- Promotionsbetraege aus Wpuums bis auf weiteres stehen lassen
  AND a.konditionsart_id <> 'RB19'
;


/*
#------------------------------------------------------------------------------
# 8.) Befuellen der Miniatur-Artbew_2 zur Ablage der Promotionswerte
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_DATA.artbew_promotion_zu_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,dat
  ,bonuskauf_id
  ,konditionsart_id
  ,wrg_id
  ,betrag_promo_netto
  ,betrag_mwst
  ,umrechnungskurs
  ,system_id
  ,ean_kasse
  ,menge_promo
  ,umsatz_promo_netto
  ,umsatz_mwst
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,dat
  ,bonuskauf_id
  ,konditionsart_id
  ,wrg_id
  ,SUM(betrag_promo_netto)
  ,SUM(betrag_mwst)
  ,umrechnungskurs
  ,system_id
  ,ean_kasse
  ,SUM(menge_promo)
  ,SUM(umsatz_promo_netto)
  ,SUM(umsatz_mwst)
FROM
(
  SELECT
     l.mandant_id AS mandant_id
    ,l.wup_id     AS wup_id
    ,l.lkp_nb_id  AS nb_id
    ,l.lkp_art_id AS art_id
    ,l.dat_booking AS dat
    ,p.bonuskauf_id
    ,p.konditionsart_id
    ,l.lkp_wrg    AS wrg_id
    ,CAST(p.umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS betrag_promo_netto
    ,(p.umsatz_brutto - betrag_promo_netto) AS betrag_mwst
    ,lkp_umrechnungskurs AS umrechnungskurs
    ,COALESCE(k.system_id, 0) AS system_id
    ,l.ean_kasse
    ,menge_promo AS menge_promo
    ,CAST(p.umsatz_promo_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_promo_netto
    ,(umsatz_promo_brutto - umsatz_promo_netto) AS umsatz_mwst
  FROM DBP_ETL.position_artbew_bon_2 l

  INNER JOIN DBP_ETL.position_artbew_bon_promotion_2 p
  ON l.mandant_id = p.mandant_id
    AND l.bon_id = p.bon_id
    AND l.dat_booking = p.dat_booking
    AND l.bon_zeile = p.bon_zeile

  -- Ermittlung System_id fuer oben eingetragene Konditionsarten
  LEFT OUTER JOIN DBP_DATA.l_konditionsart_2 k
  ON p.mandant_id = k.mandant_id
    AND p.konditionsart_id = k.konditionsart_id
) p

GROUP BY
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,dat
  ,bonuskauf_id
  ,konditionsart_id
  ,wrg_id
  ,umrechnungskurs
  ,system_id
  ,ean_kasse
;



/*
#------------------------------------------------------------------------------
# 13.) Status_2 in den Bondaten zurueckstetzen (solange MIS noch nicht aktiv ist)
#------------------------------------------------------------------------------
*/

-- nur temporaer bis die MIS Verarbeitung aktiviert wird.
UPDATE DBP_ODS.bon_load_status_2
SET artbew_fg = 1
WHERE xml_name IN 
(SELECT xml_name FROM DBP_ETL.position_artbew_bon_delta_2  )
;


CREATE OR REPLACE VOLATILE TABLE kill_duplicates AS (
SELECT mandant_id,
       wup_id,
       art_id,
       dat,
       bonuskauf_id,
       konditionsart_id,
       COUNT(*) AS anzahl,
       MIN(ean_kasse) AS min_ean_kasse,
       MAX(ean_kasse) AS max_ean_kasse,
       MIN(menge_promo) AS min_menge_promo,
       MAX(menge_promo) AS max_menge_promo
FROM DBP_DATA.artbew_promotion_zu_2
WHERE konditionsart_id <> 'RB19'
GROUP BY 1,2,3,4,5,6
HAVING COUNT(*) > 1 AND
       MIN(ean_kasse) = 0 AND
       MAX(ean_kasse) <> 0 AND
       MIN(menge_promo) = 0 AND
       MAX(menge_promo) <> 0
)
;


DELETE FROM DBP_DATA.artbew_promotion_zu_2
WHERE (mandant_id,wup_id,art_id,dat,bonuskauf_id,konditionsart_id) IN 
(SELECT mandant_id,wup_id,art_id,dat,bonuskauf_id,konditionsart_id 
FROM kill_duplicates) AND
ean_kasse = 0
;
