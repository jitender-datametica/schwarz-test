DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_1;


CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_aktion_relevant_1
(
  mandant_id  BYTEINT NOT NULL,
  aktion_id   CHAR(10)  NOT NULL,
  bewart_id   SMALLINT NOT NULL,
  dat         DATE NOT NULL,
  art_id      INTEGER NOT NULL,
  wup_id      INTEGER NOT NULL,
  nb_id       SMALLINT NOT NULL,
  anz_aktion  SMALLINT NOT NULL
)
;


CREATE TABLE dbp_etl.artbew_kmo_tmp_1 like dbp_data.artbew_1 
;

/*
#------------------------------------------------------------------------------
# 4.) Befuellen der temporaeren Tabelle dbp_etl.artbew_kmo_tmp_1
#------------------------------------------------------------------------------
*/

-- Bonuskauf Polska

INSERT INTO dbp_etl.artbew_kmo_tmp_1
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
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,promo_fg
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
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,promo_fg
FROM
(
  SELECT
     lkp_mandant_id AS mandant_id
    ,lkp_wup_id AS wup_id
    ,lkp_nb_id AS nb_id
    ,lkp_art_id AS art_id
    ,-1 AS gp_id
    ,-1 AS einkaufsorganisation_id
    ,CASE
       WHEN lkp_mandant_id = 3 AND
            l.promotionart = 'RB19'
       THEN 1002
       WHEN lkp_mandant_id = 3 AND
            l.promotionart <> 'RB19' AND
            s.aktion_typ_id IS NULL AND
            t.konditionsart_id IS NULL
       THEN COALESCE(r.bewart_id, 1001)
       ELSE COALESCE(r.bewart_id, 1001)
     END AS bewart_id
    ,belegdatum_dat AS dat
    ,CASE
       WHEN lkp_mandant_id = 3 AND
            l.promotionart = 'RB19'
       THEN ''
       WHEN lkp_mandant_id = 3 AND
            l.promotionart <> 'RB19' AND
            s.aktion_typ_id IS NULL AND
            t.konditionsart_id IS NULL
       THEN COALESCE(r.aktion_id, '')
       ELSE COALESCE(r.aktion_id, '')
     END AS aktion_id
    ,-1 AS herst_id
    ,lkp_mwst_id AS mwst_id 
    ,belegwaers AS wrg_1
    ,COALESCE(lkp_posten_id, ' ') AS posten_id -- Fuer die KMO Laender ist die PostenID im Artikelstamm noch nicht vollstaendig gepflegt
    ,0 AS bezugsweg_id    -- lt. Hr. Ferber 31.10.2008
    ,CAST(SUBSTRING(umsmenge, 16, 20) AS DECIMAL(18,4)) * 
     (CASE WHEN vorzmenge = '-' THEN (-1) ELSE 1 END) * (-1) AS menge
     -- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)
    ,CASE
       WHEN vorzmenge = '+' AND
            vorzpromotion = '-' AND
            l.promotionart = 'RB19'
       THEN CAST(SUBSTRING(umspromotion, 16, 20) AS DECIMAL(18,4))
       ELSE CAST(SUBSTRING(umspromotion, 16, 20) AS DECIMAL(18,4)) * (CASE WHEN vorzpromotion = '-' THEN (-1) ELSE 1 END)
     END AS umsatz_promotion
    ,CAST(SUBSTRING(umswert, 16, 20) AS DECIMAL(18,4)) *
     (CASE WHEN vorzwert = '-' THEN (-1) ELSE 1 END) AS umsatz_brutto_inkl_promo 
    ,(umsatz_brutto_inkl_promo + umsatz_promotion) AS umsatz_brutto    /*noch ohne Kursumrechnung*/
    ,CAST(umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto

     --  ,CAST(CAST(umsatz_brutto AS DECIMAL (12,2))/ (mwst.mwst /100 + 1) AS DECIMAL(12,2)) AS umsatz_netto
     --  Diese Umsatz_netto Berechnung wuerde das exakt gleiche Ergebnis liefern wie die "alte" MIS Verarbeitung
     --  (MIS rechnet nur mit zwei Nachkommastellen -> deshalb ungenauer),
     --  AIS rechnet mit vier Nachkommastellen und erst beim Insert in die Zeiltabelle artbew_wg_sum_1 wird auf zwei
     --  Nachkommastellen reduziert (s.o.), damit gibt es eine_1 Abweichung zwischen der bestehenden MIS Verarbeitung
     --  und der neuen AIS Verarbeitung.

    ,(umsatz_brutto - umsatz_netto) AS umsatz_mwst_betrag
    ,umsatz_netto * lkp_umrechnungskurs AS diff_umsatz_netto_konz
    ,umsatz_mwst_betrag * lkp_umrechnungskurs AS diff_umsatz_mwst_betrag_konz
     -- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
     -- im abschlieenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)
    ,CASE WHEN umsatz_promotion <> 0
          THEN 1
          ELSE 0 
     END AS promo_fg /*Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist*/
  FROM dbp_etl.kmo_wpuums_1 l

  LEFT OUTER JOIN dbp_etl_process.marktabschriften_stamm_1 r
  ON l.lkp_mandant_id = r.mandant_id
    AND l.lkp_art_id = r.art_id
    AND l.lkp_wup_id = r.wup_id
    AND l.lkp_nb_id = r.nb_id
    AND l.belegdatum_dat = r.dat
    
  LEFT OUTER JOIN dbp_data.aktion_1 s
    ON l.lkp_mandant_id = s.mandant_id AND
       r.aktion_id = s.aktion_id AND
       l.belegdatum_dat BETWEEN s.dat_von AND s.dat_bis
       
  LEFT OUTER JOIN (SELECT mandant_id,
                          aktion_id,
                          MAX(konditionsart_id) AS konditionsart_id
                   FROM dbp_data.l_bonuskauf_1
                   GROUP BY 1,2) t
    ON l.lkp_mandant_id = t.mandant_id AND
       r.aktion_id = t.aktion_id
       
  WHERE l.lkp_mandant_id = 3
       
) a
;



-- Bonuskauf normal

INSERT INTO dbp_etl.artbew_kmo_tmp_1
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
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,promo_fg
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
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,promo_fg
FROM
(
  SELECT
     lkp_mandant_id AS mandant_id
    ,lkp_wup_id AS wup_id
    ,lkp_nb_id AS nb_id
    ,lkp_art_id AS art_id
    ,-1 AS gp_id
    ,-1 AS einkaufsorganisation_id
    ,COALESCE(r.bewart_id, 1001) AS bewart_id
    ,belegdatum_dat AS dat
    ,COALESCE(r.aktion_id, '') AS aktion_id
    ,-1 AS herst_id
    ,lkp_mwst_id AS mwst_id 
    ,belegwaers AS wrg_1
    ,COALESCE(lkp_posten_id, ' ') AS posten_id -- Fuer die KMO Laender ist die PostenID im Artikelstamm noch nicht vollstaendig gepflegt
    ,0 AS bezugsweg_id    -- lt. Hr. Ferber 31.10.2008
    ,CAST(SUBSTRING(umsmenge , 16 , 20) AS DECIMAL(18,4)) * 
     (CASE WHEN vorzmenge = '-' THEN (-1) ELSE 1 END) * (-1) AS menge
     -- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)
    ,CAST(SUBSTRING(umspromotion , 16 , 20) AS DECIMAL(18,4)) *
     (CASE WHEN vorzpromotion = '-' THEN (-1) ELSE 1 END) AS umsatz_promotion
    ,CAST(SUBSTRING(umswert , 16 , 20) AS DECIMAL(18,4)) *
     (CASE WHEN vorzwert = '-' THEN (-1) ELSE 1 END) AS umsatz_brutto_inkl_promo 
    ,(umsatz_brutto_inkl_promo + umsatz_promotion) AS umsatz_brutto    /*noch ohne Kursumrechnung*/
    ,CAST(umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto

     --  ,CAST(CAST(umsatz_brutto AS DECIMAL (12,2))/ (mwst.mwst /100 + 1) AS DECIMAL(12,2)) AS umsatz_netto
     --  Diese Umsatz_netto Berechnung wuerde das exakt gleiche Ergebnis liefern wie die "alte" MIS Verarbeitung
     --  (MIS rechnet nur mit zwei Nachkommastellen -> deshalb ungenauer),
     --  AIS rechnet mit vier Nachkommastellen und erst beim Insert in die Zeiltabelle artbew_wg_sum_1 wird auf zwei
     --  Nachkommastellen reduziert (s.o.), damit gibt es eine_1 Abweichung zwischen der bestehenden MIS Verarbeitung
     --  und der neuen AIS Verarbeitung.

    ,(umsatz_brutto - umsatz_netto) AS umsatz_mwst_betrag
    ,umsatz_netto * lkp_umrechnungskurs AS diff_umsatz_netto_konz
    ,umsatz_mwst_betrag * lkp_umrechnungskurs AS diff_umsatz_mwst_betrag_konz
     -- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
     -- im abschlieenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)
    ,CASE WHEN umsatz_promotion <> 0
          THEN 1
          ELSE 0 
     END AS promo_fg /*Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist*/
  FROM dbp_etl.kmo_wpuums_1 l

  LEFT OUTER JOIN dbp_etl_process.marktabschriften_stamm_1 r
  ON l.lkp_mandant_id = r.mandant_id
    AND l.lkp_art_id = r.art_id
    AND l.lkp_wup_id = r.wup_id
    AND l.lkp_nb_id = r.nb_id
    AND l.belegdatum_dat = r.dat
    
  WHERE l.lkp_mandant_id <> 3
) a
;



/*
#------------------------------------------------------------------------------
# 5.) Loeschen von bereits bestehenden Markttagen (die neue Version ersetzt die
#     bestehende Version)
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_1 a USING dbp_etl.kmo_wpuums_dat_1
WHERE a.dat = dbp_etl.kmo_wpuums_dat.dat
  AND (a.mandant_id, a.wup_id, a.dat) IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,dat
    FROM dbp_etl.artbew_kmo_tmp_1
  )
  AND bewart_id <> 1010
;


	
DELETE FROM dbp_data.artbew_promotion_zu_1 a USING dbp_etl.kmo_wpuums_dat_1
WHERE a.dat = dbp_etl.kmo_wpuums_dat.dat
  AND (a.mandant_id, a.wup_id, a.dat) IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,dat
    FROM dbp_etl.artbew_kmo_tmp_1
    WHERE promo_fg = 1
  )
  -- nur Promotionsbetraege aus Wpuums loeschen
  AND a.konditionsart_id = 'RB19'
;



/*
#------------------------------------------------------------------------------
# 6.) Aggregieren der neuen Datensaetze auf Tag_1, Art_1, Wup_1, GP_1 Ebene
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_1
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,promo_fg 
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge
  ,umsatz_netto
  ,diff_umsatz_netto_konz
  ,umsatz_mwst_betrag
  ,diff_umsatz_mwst_betrag_konz
  ,ek_brutto
  ,diff_ek_brutto_konz
  ,ek_netto
  ,diff_ek_netto_konz
  ,ek_nettonetto
  ,diff_ek_nettonetto_konz
  ,ek_kal_basis
  ,diff_ek_kal_basis_konz
  ,ek_mep
  ,diff_ek_mep_konz
  ,einstandspreis
  ,diff_einstandspreis_konz
  ,logkostenzuschlag
  ,diff_logkostenzuschlag_konz
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
  ,ek_gld
  ,diff_ek_gld_konz
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,promo_fg
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge_sum
  ,umsatz_netto_sum
  ,diff_umsatz_netto_konz_sum
  ,umsatz_mwst_betrag_sum
  ,diff_umsatz_mwst_betrag_konz_s
  ,zero_enc AS ek_brutto
  ,zero_enc AS diff_ek_brutto_konz
  ,zero_enc AS ek_netto
  ,zero_enc AS diff_ek_netto_konz
  ,zero_enc AS ek_nettonetto
  ,zero_enc AS diff_ek_nettonetto_konz
  ,zero_enc AS ek_kal_basis
  ,zero_enc AS diff_ek_kal_basis_konz
  ,zero_enc AS ek_mep
  ,zero_enc AS diff_ek_mep_konz
  ,zero_enc AS einstandspreis
  ,zero_enc AS diff_einstandspreis_konz
  ,0 AS logkostenzuschlag
  ,0 AS diff_logkostenzuschlag_konz
  ,zero_enc AS ek_netto_bnk
  ,zero_enc AS diff_ek_netto_bnk_konz
  ,zero_enc AS ek_netto_bnk_sachk
  ,zero_enc AS diff_ek_netto_bnk_sachk_konz
  ,0 AS ek_gld
  ,0 AS diff_ek_gld_konz
FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,promo_fg
    ,gp_id
    ,einkaufsorganisation_id
    ,bewart_id
    ,dat
    ,aktion_id
    ,herst_id
    ,mwst_id
    ,wrg_1
    ,posten_id
    ,bezugsweg_id
    ,SUM(menge                       ) AS menge_sum
    ,SUM(umsatz_netto                ) AS umsatz_netto_sum
    ,SUM(diff_umsatz_netto_konz      ) AS diff_umsatz_netto_konz_sum
    ,SUM(umsatz_mwst_betrag          ) AS umsatz_mwst_betrag_sum
    ,SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz_s
    ,0  AS zero_enc
  FROM dbp_etl.artbew_kmo_tmp_1
  GROUP BY
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,promo_fg
    ,gp_id
    ,einkaufsorganisation_id
    ,bewart_id
    ,dat
    ,aktion_id
    ,herst_id
    ,mwst_id
    ,wrg_1
    ,posten_id
    ,bezugsweg_id
    ,zero_enc
) a
;



/*
#------------------------------------------------------------------------------
# 7.) Befuellen der Miniatur-Artbew_1 zur Ablage der Promotionswerte
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_promotion_zu_1
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
  ,SUM(betrag_promo_netto) * (-1.0000) /*Positives Vorzeichen*/
  ,SUM(betrag_mwst)        * (-1.0000) /*Positives Vorzeichen*/
  ,umrechnungskurs 
  ,system_id
FROM 
(
  SELECT
     lkp_mandant_id AS mandant_id
    ,lkp_wup_id AS wup_id
    ,lkp_nb_id AS nb_id
    ,lkp_art_id AS art_id
    ,belegdatum_dat AS dat
    ,'' AS bonuskauf_id 
    ,COALESCE(TRIM(promotionart), '') AS konditionsart_id 
    ,belegwaers AS wrg_id
    ,CAST(SUBSTRING(umspromotion , 16 , 20) AS DECIMAL(18,4)) *
     (CASE WHEN vorzpromotion = '-' THEN (-1) ELSE 1 END) AS promotion_brutto /*noch ohne Kursumrechnung*/
    ,CAST(promotion_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS betrag_promo_netto
    ,(promotion_brutto - betrag_promo_netto) AS betrag_mwst
    ,lkp_umrechnungskurs AS umrechnungskurs 
    ,COALESCE(k.system_id, 0) AS system_id 
  FROM dbp_etl.kmo_wpuums_1 l
    
  -- eigentlich Inner Join, muss aber nochmal geklaert werden.
  LEFT OUTER JOIN dbp_data.l_konditionsart_1 k
  ON l.lkp_mandant_id = k.mandant_id 
    AND TRIM(promotionart) = k.konditionsart_id 
      
  WHERE promotion_brutto <> 0
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
; 



/*
#------------------------------------------------------------------------------
# 8.) Befuellein der Steuertabelle Artbew_agg_wt_1 als Aufsetzpunkt zur Bildung
#     der Aggregate.
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_agg_wt_1
(
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
FROM dbp_etl.artbew_kmo_tmp_1
WHERE
  (
     mandant_id
    ,wup_id
    ,nb_id
    ,dat
  )
  NOT IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,nb_id
      ,dat
    FROM dbp_data.artbew_agg_wt_1
  )

GROUP BY 1,2,3,4
;



/*
#------------------------------------------------------------------------------
# 9.) Update Wupcal_1 fuer gelieferte und verarbeitete Markttage
#------------------------------------------------------------------------------
*/

UPDATE  dbp_data.wupcal_1
   SET  datenlieferung_artbew = 1,
        dat_extrakt_umsatz = CURRENT_DATE,
        td_update = CURRENT_TIMESTAMP
WHERE (mandant_id, wup_id, nb_id, dat) IN
  (
    SELECT
      mandant_id, wup_id, nb_id, dat
    FROM dbp_etl.artbew_kmo_tmp_1
  )
;



/*
#------------------------------------------------------------------------------
# 10.) Zwischenspeichern der Markttage die gerade geladen wurden zur spteren
#     Anreicherung mit EK Preisen
#------------------------------------------------------------------------------
*/

-- nur noch nicht vorhandene Kombinationen speichern
INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu_1
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,dat
  ,bezugsweg_id
  ,anz_ek_infosatz
  ,anz_ek_orderbuch
  ,bq_gp_id
  ,bq_ekorg
  ,bq_findung_id
  ,regel_gp_id
  ,regel_ekorg
  ,ref_wup_id
  ,ref_nb_id
  ,wg_id
  ,kreistyp_gruppe_id
  ,umrechnungskurs
)
SELECT
   lkp_mandant_id
  ,lkp_wup_id
  ,lkp_nb_id
  ,lkp_art_id
  ,belegdatum_dat
  ,0 AS bezugsweg_id
  ,0 AS anz_ek_infosatz
  ,0 AS anz_ek_orderbuch
  ,0 AS bq_gp_id
  ,0 AS bq_ekorg
  ,0 AS bq_findung_id
  ,0 AS regel_gp_id
  ,0 AS regel_ekorg
  ,0 AS ref_wup_id
  ,0 AS ref_nb_id
  ,0 AS wg_id
  ,'' AS kreistyp_gruppe_id 
  ,lkp_umrechnungskurs
FROM dbp_etl.kmo_wpuums_1 a

WHERE (lkp_mandant_id, lkp_wup_id, lkp_nb_id, lkp_art_id, belegdatum_dat) NOT IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,nb_id
      ,art_id
      ,dat
    FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_1
  )

GROUP BY
   lkp_mandant_id
  ,lkp_wup_id
  ,lkp_nb_id
  ,lkp_art_id
  ,belegdatum_dat
  ,lkp_umrechnungskurs
;


/*
#------------------------------------------------------------------------------
# 11.) Zwischenspeichern der Mandanttage die gerade geladen wurden zur spaeteren
#      Aggregation
#------------------------------------------------------------------------------
*/

-- nur noch nicht vorhandene Kombinationen speichern
INSERT INTO dbp_etl.art_best_vw_sum_artbew_kmo_dat_1
(
   mandant_id
  ,dat
)
SELECT
   mandant_id
  ,dat
FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_1
WHERE (mandant_id, dat) NOT IN
  (SELECT mandant_id, dat
   FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat_1
  )
GROUP BY 1,2
;



/*
#------------------------------------------------------------------------------
# 12.) Protokollierung Anzahl Datensaetze pro Mandant_1
#------------------------------------------------------------------------------
*/

---CONTROLL_STEP
/*INSERT INTO dbp_etl_process.load_chk_figures_1
(
   cycle_id
  ,sql_name
  ,sql_type
  ,record_count
  ,durationsec
  ,err_count
  ,job_name
  ,scr_name
  ,loop_id
  ,proc_type
)
SELECT
   $CYCLE_ID
  ,CASE WHEN mandant_id = 2 THEN 'CONTRL:kmo_wpuumskasse_CZ'
        WHEN mandant_id = 3 THEN 'CONTRL:kmo_wpuumskasse_PL'
        WHEN mandant_id = 5 THEN 'CONTRL:kmo_wpuumskasse_SK'
        WHEN mandant_id = 6 THEN 'CONTRL:kmo_wpuumskasse_HR'
        WHEN mandant_id = 7 THEN 'CONTRL:kmo_wpuumskasse_RO'
        WHEN mandant_id = 8 THEN 'CONTRL:kmo_wpuumskasse_BG'
        ELSE 'N/A' END   AS sql_name
  ,'CONTRL'  AS sql_type
  ,COUNT(*)
  ,0 AS durationsec
  ,0 AS err_count
  ,CASE WHEN SUBSTRING('$JOB_NAME' FROM 1 FOR 1) = '$' THEN '' ELSE '$JOB_NAME' END   AS job_name
  ,CASE WHEN SUBSTRING('$PROC_NAME' FROM 1 FOR 1) = '$' THEN '' ELSE '$PROC_NAME' END AS scr_name
  ,$LOOP_ID AS loop_id
  ,CASE WHEN SUBSTRING('$PROC_TYPE' FROM 1 FOR 1) = '$' THEN '' ELSE '$PROC_TYPE' END
FROM dbp_etl.artbew_kmo_tmp_1
GROUP BY 1,2,3,5,6,7,8,9,10
;

*/
/*
#------------------------------------------------------------------------------
# 13.) Bereinigung der Load Umgebung_1
#------------------------------------------------------------------------------
*/

DROP TABLE dbp_etl.artbew_kmo_tmp_1;

DROP TABLE dbp_etl.kmo_wpuums_aktion_relevant_1;


/*
#------------------------------------------------------------------------------
# 14.) Bteq beenden
#------------------------------------------------------------------------------
*/

