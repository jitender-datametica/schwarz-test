

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_artbew_bon_aktion_relevant_1
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
FROM DBP_DATA.aktion_1 a

INNER JOIN DBP_DATA.aktion_art_wup_zu_1 aaw
ON a.mandant_id = aaw.mandant_id
AND a.aktion_id = aaw.aktion_id
AND a.bewart_id = aaw.bewart_id

INNER JOIN DBP_ETL.kmo_artbew_bon_dat_1 d
ON d.dat BETWEEN a.dat_von AND a.dat_bis

WHERE a.mandant_id <> 1  -- nur KMO Mandanten
AND a.bewart_id = 1002 -- Kennzeichen Aktion_1
AND (UPPER(aaw.grund_sperrung) <> 'X'  OR aaw.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_1, Artikel_1, Wup_1 aktiv
) a
GROUP BY 1, 3 ,4, 5, 6, 7
) aa
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.artbew_kmo_tmp_1
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
,wrg_1
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
,CASE WHEN r.anz_aktion = 1 -- wenn genau eine_1 Aktion_1 vorhanden ist, diese eintragen
THEN r.aktion_id
ELSE ''
END AS aktion_id
,-1 AS herst_id
,lkp_mwst_id AS mwst_id
,lkp_wrg AS wrg_1
,COALESCE(lkp_posten_id, ' ') AS posten_id
,0 AS bezugsweg_id
,menge_ AS menge
-- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)
,(umsatz_brutto_ + umsatz_promotion_brutto_) AS umsatz_brutto_ohne_promo
,CAST(umsatz_brutto_ohne_promo / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto
,(umsatz_brutto_ohne_promo - umsatz_netto) AS umsatz_mwst_betrag
-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
-- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)
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
FROM DBP_ETL.kmo_artbew_bon_1 z

-- Ermittlung Promotionsbetrag pro Bon Zeile
LEFT OUTER JOIN
(
SELECT
mandant_id
,bon_id
,dat_booking
,bon_zeile
,SUM(umsatz_brutto) AS promotion_brutto
FROM DBP_ETL.kmo_artbew_bon_promotion_1

GROUP BY 1,2,3,4
) p
ON z.mandant_id = p.mandant_id
AND z.bon_id = p.bon_id
AND z.dat_booking = p.dat_booking
AND z.bon_zeile = p.bon_zeile
) z
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
) l

LEFT OUTER JOIN DBP_ETL.kmo_artbew_bon_aktion_relevant_1 r
ON l.mandant_id = r.mandant_id
AND l.lkp_art_id = r.art_id
AND l.wup_id = r.wup_id
AND l.lkp_nb_id = r.nb_id
AND l.dat_booking = r.dat
) a
;

/*2021-09-21 mfialkiewicz adding missing script*/
INSERT INTO DBP_DATA.artbew_1
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
,umsatz_mwst_betrag
,ek_brutto
,ek_netto
,ek_nettonetto
,ek_kal_basis
,ek_mep
,einstandspreis
,logkostenzuschlag
,ek_netto_bnk
,ek_netto_bnk_sachk
,ean_kasse

--  ,umrechnungskurs
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
,umsatz_mwst_betrag_sum
,zero_enc AS ek_brutto
,zero_enc AS ek_netto
,zero_enc AS ek_nettonetto
,zero_enc AS ek_kal_basis
,zero_enc AS ek_mep
,zero_enc AS einstandspreis
,0 AS logkostenzuschlag
,zero_enc AS ek_netto_bnk
,zero_enc AS ek_netto_bnk_sachk
,ean_kasse
--  ,umrechnungskurs
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
,SUM(menge             ) AS menge_sum
,SUM(umsatz_netto      ) AS umsatz_netto_sum
,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
,(0 ) AS zero_enc
,ean_kasse
--  ,umrechnungskurs
FROM DBP_ETL.artbew_kmo_tmp_1
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
,ean_kasse
--  ,umrechnungskurs
) a
;




--translated statement
DELETE FROM DBP_DATA.artbew_promotion_zu_1 a
-- bartosiewiczadm - cloud migration
-- WHERE a.dat = DBP_ETL.kmo_artbew_bon_dat.dat
  WHERE a.dat IN 
  ( SELECT dat
    FROM DBP_ETL.kmo_artbew_bon_dat_1
  )
  AND (a.mandant_id, a.wup_id, a.dat) IN
  ( SELECT
       mandant_id
      ,wup_id
      ,dat
    FROM DBP_ETL.artbew_kmo_tmp_1
    WHERE promo_fg = 1
  )

  AND a.konditionsart_id <> 'RB19'
;


--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_DATA.artbew_promotion_zu_1
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
         l.mandant_id   AS mandant_id
        ,l.wup_id       AS wup_id
        ,l.lkp_nb_id    AS nb_id
        ,l.lkp_art_id   AS art_id
        ,l.dat_booking  AS dat
        ,p.bonuskauf_id
        ,p.konditionsart_id
        ,l.lkp_wrg      AS wrg_id
        ,CAST(p.umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS betrag_promo_netto
        ,(p.umsatz_brutto - betrag_promo_netto) AS betrag_mwst
        ,lkp_umrechnungskurs AS umrechnungskurs
        ,COALESCE(k.system_id, 0) AS system_id
        ,l.ean_kasse
        ,menge_promo AS menge_promo
        ,CAST(p.umsatz_promo_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_promo_netto
        ,(umsatz_promo_brutto - umsatz_promo_netto) AS umsatz_mwst
        FROM DBP_ETL.kmo_artbew_bon_1 l

        INNER JOIN DBP_ETL.kmo_artbew_bon_promotion_1 p
        ON l.mandant_id = p.mandant_id
        AND l.bon_id = p.bon_id
        AND l.dat_booking = p.dat_booking
        AND l.bon_zeile = p.bon_zeile

        -- Ermittlung System_id fuer oben eingetragene Konditionsarten
        LEFT OUTER JOIN DBP_DATA.l_konditionsart_1 k
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

/*2021-09-22 mfialkiewicz adding missing insert*/
INSERT INTO DBP_ETL.kmo_wpuums_art_gp_wup_zu_1
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
mandant_id
,wup_id
,lkp_nb_id
,lkp_art_id
,dat_booking
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
FROM DBP_ETL.kmo_artbew_bon_1 a

WHERE (mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN
(
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,dat
FROM DBP_ETL.kmo_wpuums_art_gp_wup_zu_1
)

GROUP BY  
--gruppierung wg. Ean_1 und Promoflag erforderlich
mandant_id
,wup_id
,lkp_nb_id
,lkp_art_id
,dat_booking
,lkp_umrechnungskurs
;



UPDATE DBP_ODS.bon_load_status_1
SET artbew_fg = 1
WHERE xml_name IN
(SELECT xml_name
 FROM DBP_ETL.kmo_artbew_bon_delta_1
)
;


--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _kill_duplicates_${TRANSIENT_TABLE_SUFFIX} AS (
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
FROM DBP_DATA.artbew_promotion_zu_1
WHERE konditionsart_id <> 'RB19'
GROUP BY 1,2,3,4,5,6
HAVING COUNT(*) > 1 AND
MIN(ean_kasse) = 0 AND
MAX(ean_kasse) <> 0 AND
MIN(menge_promo) = 0 AND
MAX(menge_promo) <> 0
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.artbew_promotion_zu_1
WHERE (mandant_id,wup_id,art_id,dat,bonuskauf_id,konditionsart_id) IN 
(SELECT mandant_id,wup_id,art_id,dat,bonuskauf_id,konditionsart_id FROM _kill_duplicates_${TRANSIENT_TABLE_SUFFIX}) 
AND ean_kasse = 0
;

