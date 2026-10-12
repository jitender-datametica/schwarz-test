create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen where DAT_BIS='9999-12-31'
) ;


DROP TABLE IF EXISTS DBP_ETL.bf_artbew_wg_art_wo_sum_de;

CREATE TABLE DBP_ETL.bf_artbew_wg_art_wo_sum_de  (
      mandant_id BYTEINT,
      kjwo INTEGER,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      bewart_id SMALLINT,
      menge DECIMAL(18,3),
      umsatz_netto DECIMAL(18,4),
      ek_mep DECIMAL(18,4))
;

DROP TABLE IF EXISTS DBP_ETL.bf_listung_markt_kw;

CREATE TABLE DBP_ETL.bf_listung_markt_kw  (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      art_id INTEGER,
      wup_id INTEGER,
      nb_id SMALLINT,
      kreistyp_gruppe_id CHAR(4) COLLATE 'en-ci',
      kjwo INTEGER,
      absatz DECIMAL(18,3),
      absatz_sa DECIMAL(18,3),
      absatz_af DECIMAL(18,3),
      umsatz DECIMAL(18,4),
      umsatz_sa DECIMAL(18,4),
      umsatz_af DECIMAL(18,4),
      ertrag DECIMAL(18,4),
      ertrag_sa DECIMAL(18,4),
      ertrag_af DECIMAL(18,4),
      anzahl_wochen_mit_absatz INTEGER,
      anzahl_wochen_mit_absatz_sa INTEGER,
      anzahl_wochen_mit_absatz_af INTEGER)
;

CREATE OR REPLACE VOLATILE TABLE _art_leistung_1 AS (
SELECT mandant_id,
       art_matching_id,
       art_nielsen_id,
       gtin_id,
       art_id,
       umrech_faktor,
       status,
       MAX(kl_wg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_uwg_id) AS kl_uwg_id
FROM DBP_ETL.art_matching_nielsen_per
WHERE art_id <> -1 AND
      art_id IN (SELECT distinct art_id
                 FROM DBP_ETL.kl_basis_listung) AND
     (art_matching_id,art_id) NOT IN (SELECT art_matching_id,art_id FROM DBP_ETL.not_listed_basis)
);

INSERT INTO _art_leistung_1
SELECT mandant_id,
       art_matching_id,
       art_nielsen_id,
       gtin_id,
       art_id,
       umrech_faktor,
       status,
       MAX(kl_wg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_wg_id) AS kl_wg_id,
       MAX(kl_owg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_owg_id) AS kl_owg_id,
       MAX(kl_uwg_id) OVER (PARTITION BY art_matching_id ORDER BY kl_uwg_id) AS kl_uwg_id
FROM DBP_ETL.art_matching_nielsen_per
WHERE status = 'G' AND
      art_id NOT IN (SELECT art_id FROM _art_leistung_1)
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       COUNT(DISTINCT x.kjwo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             gtin_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2,3,4,5,6) c
  ON b.gtin_id = c.gtin_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id NOT IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

INSERT INTO _artikel_anteil_uwg_ranking_1st_base
SELECT a.mandant_id,
       c.art_matching_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       COUNT(DISTINCT x.kjwo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_matching_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2,3,4,5,6) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      b.gtin_id IN (-9999,-9998) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(a.anz) AS anz,
       SUM(a.distr_gew_) AS distr_gew_,
       SUM(a.menge_) AS menge__,
       SUM(a.umsatz_) AS umsatz__,
       SUM(a.menge_af_) AS menge_af_,
       SUM(a.umsatz_af_) AS umsatz_af_,
       SUM(a.menge_sa_) AS menge_sa_,
       SUM(a.umsatz_sa_) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY a.kl_owg_id ORDER BY umsatz__ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY a.kl_owg_id ORDER BY menge__ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking_1st_base a
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_leistung_base1 AS (
SELECT MAX(art_nielsen_id) AS art_nielsen_id,
       art_matching_id,
       MAX(art_id) AS art_id,
       kl_owg_id,
       kl_uwg_id,
       CAST(0 AS DECIMAL(18,4)) distr_gew,
       NULL AS rang_umsatz_wg,
       NULL AS rang_umsatz_uwg,
       NULL AS rang_absatz_uwg
FROM _art_leistung_1
WHERE art_nielsen_id <> -1
GROUP BY 2,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_wg_ranking AS (
SELECT art_matching_id,
       MIN(kl_wg_id) AS kl_wg_id_,
       SUM(umsatz__) AS umsatz___,
       DENSE_RANK() OVER (PARTITION BY kl_wg_id_ ORDER BY umsatz___ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking
GROUP BY 1
);

UPDATE _artikel_anteil_uwg_leistung_base1 
SET rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    distr_gew = b.distr_gew_

FROM (SELECT *
                                                FROM _artikel_anteil_uwg_ranking) b
												 WHERE _artikel_anteil_uwg_leistung_base1.art_matching_id = b.art_matching_id AND
      _artikel_anteil_uwg_leistung_base1.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_leistung_base1.kl_owg_id = b.kl_owg_id
;

UPDATE _artikel_anteil_uwg_leistung_base1 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
                                                FROM _artikel_anteil_wg_ranking) b
												 WHERE _artikel_anteil_uwg_leistung_base1.art_matching_id = b.art_matching_id
;

UPDATE _artikel_anteil_uwg_ranking 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
                                         FROM _artikel_anteil_wg_ranking) b
												 WHERE _artikel_anteil_uwg_ranking.art_matching_id = b.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_1 AS (
SELECT b.art_matching_id,
       b.art_id,
       b.umrech_faktor,
       b.status,
       CAST(0 AS DECIMAL(18,4)) AS distr_gew,
       a.*
FROM DBP_ETL.bf_sort_sal_export a
JOIN (SELECT art_matching_id,
             floor(art_id/100) AS kl_art_id,
             art_id,
             umrech_faktor,
             status
      FROM _art_leistung_1
      GROUP BY 1,2,3,4,5) b
  ON CAST(a.art_nr AS int) = b.kl_art_id
);

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2 AS (
SELECT art_matching_id,
       status,
       umrech_faktor,
       CAST(0 AS INTEGER) AS kl_wg_id,
       CAST(0 AS INTEGER) AS kl_owg_id,
       CAST(0 AS INTEGER) AS kl_uwg_id,
       NULL AS rang_umsatz_wg,
       NULL AS rang_umsatz_uwg,
       NULL AS rang_absatz_uwg,
       art_id,
       floor(art_id/100) AS kl_art_id,
       wug_id,
       art_bez,
       art_status,
       CAST(SUBSTR(akt_lieferant,1,POSITION(':' IN akt_lieferant)-1) AS INTEGER) AS gp_id,
       akt_lieferant,
       zek,
       disc_pe,
       disc_marke,
       lcf,
       vegan,
       gluten,
       bio,
       eigenmarke,
       tierwohl,
       posten_food,
       posten_nonfood,
       mwst,
       k_listung,
       ost_basis,
       ost_gross,
       sued_ost,
       sued_west,
       west,
       nord,
       anz_maerkte,
       distr_gew AS gewichtete_distribution,
       /* Index-AF */
       0 AS index_af_id,
       af_umsatz_netto_mt_wo AS umsatz_af_pro_markt_woche,
       --af_umsatz_netto/anz_wo_listung AS umsatz_af_pro_markt_woche,
       total_absatz_af_mt_wo*umrech_faktor AS absatz_af_pro_markt_woche,
       --total_af_absatz/anz_wo_listung AS absatz_af_pro_markt_woche,
       af_re_mep_mt_wo AS ertrag_af_pro_markt_woche,
       CAST(0 AS FLOAT) AS bonreichweite_af,
       ZEROIFNULL(af_re_mep_mt_wo/NULLIFZERO(af_umsatz_netto_mt_wo)) AS spanne_af,
       /* Index-SA */
       0 AS index_sa_id,
       ZEROIFNULL((sa_umsatz_netto/NULLIFZERO(absatz_sa_markt_tage)))*6.00 AS umsatz_sa_pro_markt_woche,
       ZEROIFNULL(((total_sa_absatz*umrech_faktor)/NULLIFZERO(absatz_sa_markt_tage)))*6.00 AS absatz_sa_pro_markt_woche,
       ZEROIFNULL((sa_re_mep/NULLIFZERO(absatz_sa_markt_tage)))*6.00 AS ertrag_sa_pro_markt_woche,
       CAST(0 AS FLOAT) AS bonreichweite_sa, 
       ZEROIFNULL(ertrag_sa_pro_markt_woche/NULLIFZERO(umsatz_sa_pro_markt_woche)) AS spanne_sa,
       /* Kennzahlen */
       aktion_absatz*umrech_faktor AS aktionsanteil_absatz,
       total_absatz*umrech_faktor AS absatz_total,
       /* Bon */
       schnelldreherquote/100 AS schnelldreherquote,
       CAST(0 AS FLOAT) AS schnelldreherquote_wg,
       CAST(0 AS FLOAT) AS schnelldreherquote_owg,
       CASE
         WHEN kol_la_bzw IS NOT NULL
         THEN ZEROIFNULL((rlz*lagerprozent)*COALESCE((total_absatz_af_mt_wo*umrech_faktor)/6,total_absatz_sa_mt_tag*umrech_faktor)/NULLIFZERO(kol_la_bzw))
         ELSE ZEROIFNULL(rlz_dz*COALESCE((total_absatz_af_mt_wo*umrech_faktor)/6,total_absatz_sa_mt_tag*umrech_faktor)/NULLIFZERO(kol_bst_bzw))
       END AS kolliabverkaufsquote,
       CAST(0 AS FLOAT) AS kolliabverkaufsquote_wg,
       CAST(0 AS FLOAT) AS kolliabverkaufsquote_owg,
       ZEROIFNULL(abschr_o_werb/NULLIFZERO(kassenumsatz)) AS abschriftsanteil,
       CAST(0 AS FLOAT) AS abschriftsanteil_wg,
       CAST(0 AS FLOAT) AS abschriftsanteil_owg,
       CAST(0 AS FLOAT) AS cherrypicker_quote, 
       CAST(0 AS FLOAT) AS cherrypicker_quote_wg,
       CAST(0 AS FLOAT) AS cherrypicker_quote_owg,
       CAST(0 AS DECIMAL(18,4)) AS restbon, 
       CAST(0 AS DECIMAL(18,4)) AS restbon_wg,
       CAST(0 AS DECIMAL(18,4)) AS restbon_owg,
       /* Bewertung */
       vk_pk_1 AS vk_preis,
       CASE
         WHEN af_umsatz_netto <> 0
         THEN ZEROIFNULL((af_umsatz_netto*((100+mwst)/100))/NULLIFZERO(total_af_absatz))
         ELSE ZEROIFNULL((sa_umsatz_netto*((100+mwst)/100))/NULLIFZERO(total_sa_absatz)) 
       END AS durchschnittspreis,
       CAST(0 AS FLOAT) AS preislagenverteilung,
       CAST(0 AS FLOAT) AS marktanteilbewertung,
       /* zur Berechnung */
       anz_wo_mit_absatz,
       anz_wo_listung,
       kol_la_bzw,
       kol_bst_bzw,
       rlz_dz,
       rlz,
       lagerprozent,
       total_absatz_af_mt_wo*umrech_faktor total_absatz_af_mt_wo,
       total_absatz_sa_mt_tag*umrech_faktor total_absatz_sa_mt_tag,
       total_af_absatz*umrech_faktor total_af_absatz,
       total_sa_absatz*umrech_faktor total_sa_absatz,
       af_umsatz_netto,
       sa_umsatz_netto,
       absatz_sa_markt_tage*umrech_faktor absatz_sa_markt_tage,
       absatz_af_markt_wochen*umrech_faktor absatz_af_markt_wochen,
       CAST(abschr_o_werb AS FLOAT) AS abschr_o_werb,
       CAST(kassenumsatz AS FLOAT) AS kassenumsatz
FROM _sal_snap_1
);


UPDATE _sal_snap_2 
SET bonreichweite_af = krw_af,
    bonreichweite_sa = krw_sa
	
FROM (SELECT kl_art_id,
                                SUM(krw_af) AS krw_af,
                                SUM(krw_sa) AS krw_sa,
                                SUM(cpq_total) AS cpq_total,
                                SUM(rb_total) AS rb_total
                         FROM DBP_ETL.bf_bons_sort_export
                         WHERE bereich = 'alle' AND
                               mandant_id = 1
                         GROUP BY 1) b
						  WHERE _sal_snap_2.kl_art_id = b.kl_art_id
;

CREATE OR REPLACE VOLATILE TABLE _step1 AS (
SELECT b.mandant_id,
       b.art_id,
       c.wg_id,
       SUM(a.artikel_bons_af) AS art_bons_af,
       SUM(a.artikel_bons_sa) AS art_bons_sa,
       SUM(a.cpq_total) AS cpq_total_artikel,
       SUM(a.cherry_bons_af) AS cp_bons_af,
       SUM(a.cherry_bons_sa) AS cp_bons_sa,
       SUM(a.bons) AS bons,
       SUM(a.rb_total) AS rb_total
FROM DBP_ETL.bf_bons_sort_export a
JOIN DBP_DATA.art b
  ON a.mandant_id = b.mandant_id AND
     a.kl_art_id = b.kl_art_id AND
    b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
JOIN DBP_DATA.art_wg_zu_per c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id AND
     c.arthiertyp_id = 2 AND
     c.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
WHERE a.bereich = 'alle' AND
      a.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step2 AS (
SELECT mandant_id,
       wg_id,
      (SUM(CAST(cp_bons_af AS FLOAT))  + SUM(CAST(cp_bons_sa AS FLOAT)) ) / NULLIFZERO(SUM(CAST(art_bons_af AS FLOAT)+ CAST(art_bons_sa AS FLOAT)))  AS cpq_total_wg
FROM _step1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2_multis AS (
SELECT a.*
FROM _sal_snap_2 a
JOIN (SELECT art_matching_id
      FROM _sal_snap_2
      WHERE status IN ('G','T')
      GROUP BY 1
      HAVING COUNT(*) > 1) b
  ON a.art_matching_id = b.art_matching_id
);


UPDATE _sal_snap_2_multis 
SET art_id            = b.art_id         ,
    wug_id            = b.wug_id         ,            
    art_bez           = b.art_bez        ,  
    art_status        = b.art_status     ,  
    gp_id             = b.gp_id          ,  
    akt_lieferant     = b.akt_lieferant  ,  
    zek               = b.zek            ,  
    disc_pe           = b.disc_pe        ,  
    disc_marke        = b.disc_marke     ,  
    lcf               = b.lcf            ,  
    vegan             = b.vegan          ,  
    gluten            = b.gluten         ,  
    bio               = b.bio            ,  
    eigenmarke        = b.eigenmarke     ,  
    tierwohl          = b.tierwohl       ,  
    posten_food       = b.posten_food    ,  
    posten_nonfood    = b.posten_nonfood ,  
    mwst              = b.mwst           ,  
    k_listung         = b.k_listung      ,  
    ost_basis         = b.ost_basis      ,  
    ost_gross         = b.ost_gross      ,  
    sued_ost          = b.sued_ost       ,  
    sued_west         = b.sued_west      ,  
    west              = b.west           ,  
    nord              = b.nord           ,  
    anz_maerkte       = b.anz_maerkte      

FROM (SELECT y.*
                                FROM _sal_snap_2_multis y
                                JOIN (SELECT z.art_matching_id,
                                             z.kl_art_id
                                      FROM (SELECT x.art_matching_id,
                                                   x.kl_art_id,
                                                   y.art_id,
                                                   MAX(y.dat_von) AS dat_von
                                            FROM _sal_snap_2_multis x
                                            JOIN (SELECT art_id,
                                                         MAX(dat_von) AS dat_von
                                                  FROM DBP_DATA.art_wup_zu_per
                                                  WHERE mandant_id = 1 AND
                                	                    listung_id = 1
                                                  GROUP BY 1) y
                                              ON x.kl_art_id = floor(y.art_id/100)
                                            GROUP BY 1,2,3) z
                                      QUALIFY  row_number() OVER (PARTITION BY z.art_matching_id  order by  z.art_matching_id DESC, z.dat_von DESC, z.kl_art_id DESC) = 1) x1
                                  ON y.art_matching_id = x1.art_matching_id AND
                                     y.kl_art_id = x1.kl_art_id
                                  QUALIFY  row_number() OVER (PARTITION BY y.art_matching_id  order by y.art_matching_id DESC, y.kl_art_id DESC) = 1) b

WHERE _sal_snap_2_multis.art_matching_id = b.art_matching_id
;

INSERT INTO DBP_ETL.bf_artbew_wg_art_wo_sum_de
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge*d.umrech_faktor,
       a.umsatz_netto,
       a.ek_mep
FROM DBP_DATA.artbew_wo_sum a
JOIN DBP_DATA.woche_kj_kl c
  ON a.kjwo_kl = c.kjwo_kl
JOIN DBP_DATA.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
JOIN DBP_ETL.art_matching_nielsen_per d
  ON a.art_id = d.art_id
WHERE c.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.status IN ('T','G') AND
      a.mandant_id = 1
;

INSERT INTO DBP_ETL.bf_listung_markt_kw (mandant_id
                                           ,wg_id
                                           ,art_id
                                           ,wup_id
                                           ,nb_id
                                           ,kreistyp_gruppe_id
                                           ,kjwo
                                           ,absatz
                                           ,absatz_sa
                                           ,absatz_af
                                           ,umsatz
                                           ,umsatz_sa
                                           ,umsatz_af
                                           ,ertrag
                                           ,ertrag_sa
                                           ,ertrag_af
                                           ,anzahl_wochen_mit_absatz
                                           ,anzahl_wochen_mit_absatz_sa
                                           ,anzahl_wochen_mit_absatz_af)
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto)) AS umsatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZEROIFNULL(SUM(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM DBP_ETL.bf_artbew_wg_art_wo_sum_de v01
JOIN DBP_DATA.art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN DBP_DATA.wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen AS (
SELECT a.kjwo,
       b.art_matching_id,
       a.wup_id,
       ZEROIFNULL(SUM(a.absatz)) AS absatz_,
       ZEROIFNULL(SUM(a.absatz_af)) AS absatz_af_,
       ZEROIFNULL(SUM(a.absatz_sa)) AS absatz_sa_,
       ZEROIFNULL(SUM(a.umsatz)) AS umsatz_,
       ZEROIFNULL(SUM(a.umsatz_af)) AS umsatz_af_,
       ZEROIFNULL(SUM(a.umsatz_sa)) AS umsatz_sa_,
       ZEROIFNULL(SUM(a.ertrag)) AS ertrag_,
       ZEROIFNULL(SUM(a.ertrag_af)) AS ertrag_af_,
       ZEROIFNULL(SUM(a.ertrag_sa)) AS ertrag_sa_,
       ZEROIFNULL(CASE WHEN absatz_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz,
       ZEROIFNULL(CASE WHEN absatz_af_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_af,
       ZEROIFNULL(CASE WHEN absatz_sa_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_sa,
       ZEROIFNULL(CASE WHEN umsatz_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz,
       ZEROIFNULL(CASE WHEN umsatz_af_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_af,
       ZEROIFNULL(CASE WHEN umsatz_sa_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_sa,
       ZEROIFNULL(CASE WHEN ertrag_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag,
       ZEROIFNULL(CASE WHEN ertrag_af_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_af,
       ZEROIFNULL(CASE WHEN ertrag_sa_>0 THEN COUNT(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_sa
FROM DBP_ETL.bf_listung_markt_kw a
JOIN (SELECT art_matching_id,
             art_id,
             status
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      b.status IN ('T','G')
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1 AS (
SELECT art_matching_id,
       SUM(absatz_) AS absatz,
       SUM(absatz_af_) AS absatz_af,
       SUM(absatz_sa_) AS absatz_sa,
       SUM(umsatz_) AS umsatz,
       SUM(umsatz_af_) AS umsatz_af,
       SUM(umsatz_sa_) AS umsatz_sa,
       SUM(ertrag_) AS ertrag,
       SUM(ertrag_af_) AS ertrag_af,
       SUM(ertrag_sa_) AS ertrag_sa,
       SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
       SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
       SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
       SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
       SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
       SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
       SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
       SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
       SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM _anz_wochen
GROUP BY 1
);

CREATE OR REPLACE VOLATILE TABLE _woche AS (
SELECT x.kjwo
FROM (SELECT kjwo,
             RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
      FROM DBP_DATA.art_nielsen_fakten_kjwo
      WHERE mandant_id = 1
      GROUP BY 1) x
WHERE akt_wo BETWEEN -52 AND -1
);

CREATE OR REPLACE VOLATILE TABLE ZZSP07_pre  (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT, 
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT
) ;

INSERT INTO ZZSP07_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       CASE WHEN SUM(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz
FROM DBP_ETL.bf_listung_markt_kw a11
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a11.art_id = b.art_id AND
     b.status IN ('G','T')
WHERE a11.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu WHERE wg_filter_id = 11) AND 
      a11.kjwo BETWEEN (SELECT MIN(kjwo) FROM _woche) AND (SELECT MAX(kjwo) FROM _woche) AND
      a11.mandant_id = 1
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre  (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung FLOAT)
;

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       COUNT (DISTINCT a11.kjwo)  anz_wo_listung
FROM DBP_DATA.art_wup_listung_kjwo a11
JOIN DBP_ETL.art_matching_nielsen_per b
  ON a11.art_id = b.art_id AND
     b.status IN ('G','T')
WHERE a11.mandant_id = 1 AND
      a11.kjwo BETWEEN (SELECT MIN(kjwo) FROM _woche) AND (SELECT MAX(kjwo) FROM _woche)
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE _mm AS (
SELECT a.*,
       b.anz_wo_mit_absatz
FROM ZZSP08_pre a
JOIN ZZSP07_pre b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.matching_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo
);

INSERT INTO _mm
SELECT kjwo,
       matching_id,
       mandant_id,
       wup_id,
       anz_wo_listung,
       0
FROM ZZSP08_pre
WHERE (kjwo,matching_id,mandant_id,wup_id) NOT IN (SELECT kjwo,matching_id,mandant_id,wup_id FROM _mm)
;



CREATE OR REPLACE VOLATILE TABLE ZZSP07  (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_mit_absatz	FLOAT
) ;


INSERT INTO ZZSP07 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       SUM(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2
;



CREATE OR REPLACE VOLATILE TABLE ZZSP08  (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_listung FLOAT)
;


INSERT INTO ZZSP08 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       SUM(a11.anz_wo_listung)  anz_wo_listung
FROM _mm a11
GROUP BY 1,2
;



CREATE OR REPLACE VOLATILE TABLE ZZOJ09  (
  matching_id INTEGER, 
  mandant_id BYTEINT)
;


INSERT INTO ZZOJ09 
SELECT pa11.matching_id  matching_id,
      pa11.mandant_id  mandant_id
FROM ZZSP07 pa11
GROUP BY 1,2
UNION
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id
FROM ZZSP08 pa11
GROUP BY 1,2
;



CREATE OR REPLACE VOLATILE TABLE ZZMD0A_xxx  (
  matching_id INTEGER, 
  mandant_id BYTEINT, 
  WJXBFS1 FLOAT, 
  anz_wo_listung FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT)
;


INSERT INTO ZZMD0A_xxx 
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       1.0  WJXBFS1,
       pa13.anz_wo_listung  anz_wo_listung,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       ROUND((pa12.anz_wo_mit_absatz/NULLIFZERO(pa13.anz_wo_listung))*100,1) AS schnelldreherquote
FROM ZZOJ09 pa11
LEFT JOIN ZZSP07 pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id
LEFT JOIN ZZSP08 pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2_multis1 AS (
SELECT x.art_matching_id,
       x.status,
       MAX(x.umrech_faktor) AS umrech_faktor,
       MAX(x.kl_wg_id) AS kl_wg_id,
       MAX(x.kl_owg_id) AS kl_owg_id,
       MAX(x.kl_uwg_id) AS kl_uwg_id,
       MAX(x.rang_umsatz_wg) AS rang_umsatz_wg,
       MAX(x.rang_umsatz_uwg) AS rang_umsatz_uwg,
       MAX(x.rang_absatz_uwg) AS rang_absatz_uwg,
       MAX(x.art_id) AS art_id,
       SUBSTR(REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(x.kl_art_id AS VARCHAR(600)),8,'0') as int) as varchar(8)),8,'0'), ',') within group (ORDER BY x.kl_art_id) ), ','),' ', ''),1,300) AS kl_art_id,
       MAX(x.wug_id) AS wug_id,
       MAX(x.art_bez) AS art_bez,
       MAX(x.art_status) AS art_status,
       MAX(x.gp_id) AS gp_id,
       MAX(x.akt_lieferant) AS akt_lieferant,
       MAX(x.zek) AS zek,
       MAX(x.disc_pe) AS disc_pe,
       MAX(x.disc_marke) AS disc_marke,
       MAX(x.lcf) AS lcf,
       MAX(x.vegan) AS vegan,
       MAX(x.gluten) AS gluten,
       MAX(x.bio) AS bio,
       MAX(x.eigenmarke) AS eigenmarke,
       MAX(x.tierwohl) AS tierwohl,
       MAX(x.posten_food) AS posten_food,
       MAX(x.posten_nonfood) AS posten_nonfood,
       MAX(x.mwst) AS mwst,
       MAX(x.k_listung) AS k_listung,
       MAX(x.ost_basis) AS ost_basis,
       MAX(x.ost_gross) AS ost_gross,
       MAX(x.sued_ost) AS sued_ost,
       MAX(x.sued_west) AS sued_west,
       MAX(x.west) AS west,
       MAX(x.nord) AS nord,
       MAX(x.anz_maerkte) AS anz_maerkte,
       ZEROIFNULL(SUM(x.gewichtete_distribution)/NULLIFZERO(COUNT(*))) AS gewichtete_distribution,
       /* Index AF */
       MAX(x.index_af_id) AS index_af_id,
       ZEROIFNULL(MAX(y.umsatz_af)/NULLIFZERO(MAX(y.anzahl_wochen_mit_umsatz_af))) AS umsatz_af_pro_markt_woche_,
       ZEROIFNULL(MAX(y.absatz_af)/NULLIFZERO(MAX(y.anzahl_wochen_mit_absatz_af))) AS absatz_af_pro_markt_woche_,
       ZEROIFNULL(MAX(y.ertrag_af)/NULLIFZERO(MAX(y.anzahl_wochen_mit_ertrag_af))) AS ertrag_af_pro_markt_woche_,
       SUM(x.bonreichweite_af) AS bonreichweite_af,
       ZEROIFNULL(ertrag_af_pro_markt_woche_/NULLIFZERO(umsatz_af_pro_markt_woche_)) AS spanne_af,
       /* Index SA */
       MAX(x.index_sa_id) AS index_sa_id,
       ZEROIFNULL(MAX(y.umsatz_sa)/NULLIFZERO(MAX(y.anzahl_wochen_mit_umsatz_sa))) AS umsatz_sa_pro_markt_woche_,
       ZEROIFNULL(MAX(y.absatz_sa)/NULLIFZERO(MAX(y.anzahl_wochen_mit_absatz_sa))) AS absatz_sa_pro_markt_woche_,
       ZEROIFNULL(MAX(y.ertrag_sa)/NULLIFZERO(MAX(y.anzahl_wochen_mit_ertrag_sa))) AS ertrag_sa_pro_markt_woche_,
       SUM(x.bonreichweite_sa) AS bonreichweite_sa,
       ZEROIFNULL(ertrag_sa_pro_markt_woche_/NULLIFZERO(umsatz_sa_pro_markt_woche_)) AS spanne_sa,
       /* Kennzahlen */
       ZEROIFNULL(SUM(total_sa_absatz)/NULLIFZERO(SUM(x.absatz_total))) AS aktionsanteil_absatz,
       SUM(x.absatz_total) AS absatz_total,
       /* Bon */
       ZEROIFNULL(SUM(CAST(x.anz_wo_mit_absatz AS FLOAT))/NULLIFZERO(SUM(CAST(x.anz_wo_listung AS FLOAT)))) AS schnelldreherquote,
       SUM(schnelldreherquote_wg) AS schnelldreherquote_wg,
       SUM(schnelldreherquote_owg) AS schnelldreherquote_owg,
       CASE
         WHEN MAX(kol_la_bzw) IS NOT NULL
         THEN ZEROIFNULL(((MAX(rlz)/COUNT(*))*MAX(lagerprozent))*COALESCE((SUM(total_af_absatz)/SUM(absatz_af_markt_wochen))/6,SUM(total_sa_absatz)/SUM(absatz_sa_markt_tage))/NULLIFZERO(MAX(CASE WHEN umrech_faktor = 1 THEN kol_la_bzw ELSE 1 END)))
         ELSE ZEROIFNULL((MAX(rlz_dz)/COUNT(*))*COALESCE((SUM(total_af_absatz)/SUM(absatz_af_markt_wochen))/6,SUM(total_sa_absatz)/SUM(absatz_sa_markt_tage))/NULLIFZERO(MAX(CASE WHEN umrech_faktor = 1 THEN kol_bst_bzw ELSE 1 END)))
       END AS kolliabverkaufsquote,
       SUM(kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
       SUM(kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
       ZEROIFNULL(SUM(CAST(abschr_o_werb AS FLOAT))/NULLIFZERO(SUM(CAST(kassenumsatz AS FLOAT)))) AS abschriftsanteil,
       SUM(abschriftsanteil_wg) AS abschriftsanteil_wg,
       SUM(abschriftsanteil_owg) AS abschriftsanteil_owg,
       SUM(cherrypicker_quote) AS cherrypicker_quote,
       SUM(cherrypicker_quote_wg) AS cherrypicker_quote_wg,
       SUM(cherrypicker_quote_owg) AS cherrypicker_quote_owg,
       SUM(restbon) AS restbon,
       SUM(restbon_wg) AS restbon_wg,
       SUM(restbon_owg) AS restbon_owg,
       /* Bewertung */
       MAX(vk_preis) AS vk_preis, ---> muessen wir aendern! 
       CASE
         WHEN SUM(af_umsatz_netto) <> 0
         THEN ZEROIFNULL(SUM((af_umsatz_netto*((100+mwst)/100)))/NULLIFZERO(SUM(total_af_absatz)))
         ELSE ZEROIFNULL(SUM((sa_umsatz_netto*((100+mwst)/100)))/NULLIFZERO(SUM(total_sa_absatz))) 
       END AS durchschnittspreis, ----> brutto!
       SUM(preislagenverteilung) AS preislagenverteilung,
       SUM(marktanteilbewertung) AS marktanteilbewertung,
       /* Berechnung */
       SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       SUM(anz_wo_listung) AS anz_wo_listung,
       MAX(kol_la_bzw) AS kol_la_bzw,
       MAX(kol_bst_bzw) AS kol_bst_bzw,
       MAX(rlz_dz) AS rlz_dz,
       MAX(rlz) AS rlz,
       MAX(lagerprozent) AS lagerprozent,
       SUM(total_absatz_af_mt_wo) AS total_absatz_af_mt_wo,
       SUM(total_absatz_sa_mt_tag) AS total_absatz_sa_mt_tag,
       SUM(total_af_absatz) AS total_af_absatz,
       SUM(total_sa_absatz) AS total_sa_absatz,
       SUM(af_umsatz_netto) AS af_umsatz_netto,
       SUM(sa_umsatz_netto) AS sa_umsatz_netto,
       SUM(absatz_sa_markt_tage) AS absatz_sa_markt_tage,
       SUM(absatz_af_markt_wochen) AS absatz_af_markt_wochen,
       SUM(abschr_o_werb) AS abschr_o_werb,
       SUM(kassenumsatz) AS kassenumsatz
FROM _sal_snap_2_multis x
LEFT JOIN _step1 z
  ON 1 = z.mandant_id AND
     x.art_id = z.art_id
LEFT JOIN _anz_wochen1 y
  ON x.art_matching_id = y.art_matching_id
WHERE x.art_matching_id NOT IN (SELECT art_matching_id FROM DBP_ETL.art_matching_nielsen_per WHERE gtin_id IN (-9998,-9999))
GROUP BY 1,2
);

UPDATE _sal_snap_2_multis1 
SET schnelldreherquote = b.sdq/100

FROM (SELECT schnelldreherquote AS sdq,
                                        matching_id
                                 FROM ZZMD0A_xxx) b
										 WHERE _sal_snap_2_multis1.art_matching_id = b.matching_id
;

DELETE FROM _sal_snap_2
WHERE art_matching_id IN (SELECT art_matching_id FROM _sal_snap_2_multis1)
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_final AS (
SELECT 1 AS mandant_id
      ,d.kjmo_sort AS kjmo
      ,art_matching_id
      ,' ' AS status
      ,umrech_faktor
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,rang_umsatz_wg
      ,rang_umsatz_uwg
      ,rang_absatz_uwg
      ,art_id
      ,CAST(kl_art_id AS VARCHAR(300)) AS kl_art_id
      ,wug_id
      ,art_bez
      ,art_status
      ,gp_id
      ,akt_lieferant
      ,zek AS zek_id
      ,disc_pe
      ,disc_marke
      ,lcf
      ,vegan
      ,gluten
      ,bio
      ,eigenmarke
      ,tierwohl
      ,posten_food
      ,posten_nonfood
      ,mwst
      ,k_listung
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,nord
      ,anz_maerkte
      ,gewichtete_distribution
      ,index_af_id
      ,umsatz_af_pro_markt_woche
      ,absatz_af_pro_markt_woche
      ,ertrag_af_pro_markt_woche
      ,bonreichweite_af
      ,spanne_af
      ,index_sa_id
      ,umsatz_sa_pro_markt_woche
      ,absatz_sa_pro_markt_woche
      ,ertrag_sa_pro_markt_woche
      ,bonreichweite_sa
      ,spanne_sa
      ,aktionsanteil_absatz
      ,absatz_total
      ,schnelldreherquote
      ,schnelldreherquote_wg
      ,schnelldreherquote_owg
      ,kolliabverkaufsquote
      ,kolliabverkaufsquote_wg
      ,kolliabverkaufsquote_owg
      ,abschriftsanteil
      ,abschriftsanteil_wg
      ,abschriftsanteil_owg
      ,cherrypicker_quote
      ,cherrypicker_quote_wg
      ,cherrypicker_quote_owg
      ,restbon
      ,restbon_wg
      ,restbon_owg
      ,vk_preis
      ,durchschnittspreis
      ,preislagenverteilung
      ,marktanteilbewertung
      /* zur Berechnung */
      ,anz_wo_mit_absatz
      ,anz_wo_listung
      ,kol_la_bzw
      ,kol_bst_bzw
      ,rlz_dz
      ,rlz
      ,lagerprozent
      ,total_absatz_af_mt_wo
      ,total_absatz_sa_mt_tag
      ,total_af_absatz
      ,total_sa_absatz
      ,af_umsatz_netto
      ,sa_umsatz_netto
      ,absatz_sa_markt_tage
      ,absatz_af_markt_wochen
      ,abschr_o_werb
      ,kassenumsatz
FROM _sal_snap_2
JOIN (SELECT MAX(kjwo) AS max_kjwo
      FROM DBP_DATA.art_nielsen_fakten_kjwo
      WHERE mandant_id = 1) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM d
  ON c.max_kjwo = d.kjwo_bis
);

INSERT INTO _sal_snap_final
SELECT 1 AS mandant_id,
       d.kjmo_sort AS kjmo,
       a.*
FROM _sal_snap_2_multis1 a
JOIN (SELECT MAX(kjwo) AS max_kjwo
      FROM DBP_DATA.art_nielsen_fakten_kjwo
      WHERE mandant_id = 1) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM d
  ON c.max_kjwo = d.kjwo_bis
;

DELETE FROM _sal_snap_final
WHERE (art_id,art_matching_id) NOT IN (SELECT art_id,
                                              MIN(art_matching_id) AS min_matching_id
                                       FROM _sal_snap_final
                                       GROUP BY 1
                                       HAVING COUNT(*) > 1) AND
      art_id IN (SELECT art_id
                 FROM _sal_snap_final
                 GROUP BY 1
                 HAVING COUNT(*) > 1)
;

DELETE FROM _sal_snap_final
WHERE art_id IN (SELECT art_id
                 FROM _sal_snap_final
                 GROUP BY 1
                 HAVING COUNT(*) > 1) AND
      umsatz_af_pro_markt_woche = 0
;

UPDATE _sal_snap_final 
SET kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id

FROM (SELECT art_id,
                                    MAX(kl_wg_id) AS kl_wg_id,
                                    MAX(kl_owg_id) AS kl_owg_id,
                                    MAX(kl_uwg_id) AS kl_uwg_id
                             FROM _art_leistung_1
                             GROUP BY 1) b
							  WHERE _sal_snap_final.art_id = b.art_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    gewichtete_distribution = b.distr_gew

FROM (SELECT art_matching_id,
                                    MIN(rang_umsatz_wg) AS rang_umsatz_wg,
                                    MIN(rang_umsatz_uwg) AS rang_umsatz_uwg,
                                    MIN(rang_absatz_uwg) AS rang_absatz_uwg,
                                    SUM(distr_gew)/COUNT(*) AS distr_gew
                             FROM _artikel_anteil_uwg_leistung_base1
                             GROUP BY 1) b
							  WHERE _sal_snap_final.art_matching_id = b.art_matching_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
                                    MAX(rang_umsatz_wg) AS next_rang_ums_wg,
                                    MAX(rang_umsatz_uwg) AS next_rang_ums_uwg,
                                    MAX(rang_absatz_uwg) AS next_rang_abs_uwg
                             FROM _artikel_anteil_uwg_ranking
                             GROUP BY 1) b
												 WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT kl_wg_id,
                                    MAX(rang_umsatz_wg)+1 AS next_rang_ums_wg
                             FROM _artikel_anteil_uwg_ranking
                             GROUP BY 1) b
												 WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL
;

UPDATE _sal_snap_final 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
                                    COALESCE(MAX(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
                                    COALESCE(MAX(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
                             FROM _sal_snap_final a
                             GROUP BY 1) b
												 WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT kl_wg_id,
                                    MAX(COALESCE(rang_umsatz_wg,0))+1 AS next_rang_ums_wg
                             FROM _sal_snap_final
                             GROUP BY 1) b
												 WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL
;

UPDATE _sal_snap_final 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT kl_owg_id,
                                    MAX(COALESCE(rang_umsatz_uwg,0))+1 AS next_rang_ums_uwg,
                                    MAX(COALESCE(rang_absatz_uwg,0))+1 AS next_rang_abs_uwg
                             FROM _sal_snap_final
                             GROUP BY 1) b
												 WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL
;

UPDATE _sal_snap_final 
SET schnelldreherquote_wg = b.schnelldreherquote_wg,
    kolliabverkaufsquote_wg = b.kolliabverkaufsquote_wg,
    abschriftsanteil_wg = b.abschriftsanteil_wg
	
FROM (SELECT kl_wg_id,
                                    SUM(CAST(anz_wo_mit_absatz AS FLOAT))/NULLIFZERO(SUM(CAST(anz_wo_listung AS FLOAT))) AS schnelldreherquote_wg,
                                    CASE
                                      WHEN MAX(kol_la_bzw) IS NOT NULL
                                      THEN ZEROIFNULL(((SUM(rlz)/COUNT(*))*MAX(lagerprozent))*COALESCE((SUM(total_af_absatz)/NULLIFZERO(SUM(absatz_af_markt_wochen)))/6,SUM(total_sa_absatz)/NULLIFZERO(SUM(absatz_sa_markt_tage)))/NULLIFZERO(MAX(kol_la_bzw)))
                                      ELSE ZEROIFNULL((SUM(rlz_dz)/COUNT(*))*COALESCE((SUM(total_af_absatz)/NULLIFZERO(SUM(absatz_af_markt_wochen)))/6,SUM(total_sa_absatz)/NULLIFZERO(SUM(absatz_sa_markt_tage)))/NULLIFZERO(MAX(kol_bst_bzw)))
                                    END AS kolliabverkaufsquote_wg,
                                    SUM(CAST(abschr_o_werb AS FLOAT))/NULLIFZERO(SUM(CAST(kassenumsatz AS FLOAT))) AS abschriftsanteil_wg
                             FROM _sal_snap_final
                             GROUP BY 1) b
							  WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id
;

UPDATE _sal_snap_final 
SET schnelldreherquote_owg = b.schnelldreherquote_owg,
    kolliabverkaufsquote_owg = b.kolliabverkaufsquote_owg,
    abschriftsanteil_owg = b.abschriftsanteil_owg
	
FROM (SELECT kl_owg_id,
                                    SUM(CAST(anz_wo_mit_absatz AS FLOAT))/NULLIFZERO(SUM(CAST(anz_wo_listung AS FLOAT))) AS schnelldreherquote_owg,
                                    CASE
                                      WHEN MAX(kol_la_bzw) IS NOT NULL
                                      THEN ZEROIFNULL(((SUM(rlz)/COUNT(*))*MAX(lagerprozent))*COALESCE((SUM(total_af_absatz)/NULLIFZERO(SUM(absatz_af_markt_wochen)))/6,SUM(total_sa_absatz)/NULLIFZERO(SUM(absatz_sa_markt_tage)))/NULLIFZERO(MAX(kol_la_bzw)))
                                      ELSE ZEROIFNULL((SUM(rlz_dz)/COUNT(*))*COALESCE((SUM(total_af_absatz)/NULLIFZERO(SUM(absatz_af_markt_wochen)))/6,SUM(total_sa_absatz)/NULLIFZERO(SUM(absatz_sa_markt_tage)))/NULLIFZERO(MAX(kol_bst_bzw)))
                                    END AS kolliabverkaufsquote_owg,
                                    SUM(CAST(abschr_o_werb AS FLOAT))/NULLIFZERO(SUM(CAST(kassenumsatz AS FLOAT))) AS abschriftsanteil_owg
                             FROM _sal_snap_final
                             GROUP BY 1) b
							  WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id
;

CREATE OR REPLACE VOLATILE TABLE _index01  (
      mandant_id BYTEINT,
      kjmo INTEGER,
      art_matching_id INTEGER,
      kl_wg_id INTEGER,
      kl_owg_id INTEGER,
      kl_uwg_id INTEGER,
      art_id INTEGER,
      /* Index AF */
      umsatz_af_pro_markt_woche FLOAT,
      absatz_af_pro_markt_woche FLOAT,
      ertrag_af_pro_markt_woche FLOAT,
      bonreichweite_af FLOAT,
      /* Index SA */
      umsatz_sa_pro_markt_woche FLOAT,
      absatz_sa_pro_markt_woche FLOAT,
      ertrag_sa_pro_markt_woche FLOAT,
      bonreichweite_sa FLOAT,
      index_af INTEGER,
      index_sa INTEGER
) ;

INSERT INTO _index01
SELECT mandant_id,
       kjmo,
       art_matching_id,
       kl_wg_id,
       kl_owg_id,
       kl_uwg_id,
       art_id,
       /* Index AF */
       umsatz_af_pro_markt_woche,
       absatz_af_pro_markt_woche,
       ertrag_af_pro_markt_woche,
       bonreichweite_af,
       /* Index SA */
       umsatz_sa_pro_markt_woche,
       absatz_sa_pro_markt_woche,
       ertrag_sa_pro_markt_woche,
       bonreichweite_sa,
       0 AS index_af,
       0 AS index_sa
FROM _sal_snap_final
WHERE art_id IS NOT NULL
;



CREATE OR REPLACE VOLATILE TABLE _index02 AS (
SELECT kl_wg_id,
       /* Index AF */
       AVG(umsatz_af_pro_markt_woche) AS avg_umsatz_af_pro_markt_woche,
       AVG(absatz_af_pro_markt_woche) AS avg_absatz_af_pro_markt_woche,
       AVG(ertrag_af_pro_markt_woche) AS avg_ertrag_af_pro_markt_woche,
       AVG(bonreichweite_af) AS avg_bonreichweite_af,
       /* Index SA */
       AVG(umsatz_sa_pro_markt_woche) AS avg_umsatz_sa_pro_markt_woche,
       AVG(absatz_sa_pro_markt_woche) AS avg_absatz_sa_pro_markt_woche,
       AVG(ertrag_sa_pro_markt_woche) AS avg_ertrag_sa_pro_markt_woche,
       AVG(bonreichweite_sa) AS avg_bonreichweite_sa,
       COUNT(*) AS anz_art
FROM _index01
GROUP BY 1
);



CREATE OR REPLACE VOLATILE TABLE _index03 AS (
SELECT a.kl_wg_id,
       MAX(b.anz_art) AS anz_art_,
       /* Index AF */
       SUM((a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)*(a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)) AS double_umsatz_af,
       SUM((a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)*(a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)) AS double_absatz_af,
       SUM((a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)*(a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)) AS double_ertrag_af,
       SUM((a.bonreichweite_af-b.avg_bonreichweite_af)*(a.bonreichweite_af-b.avg_bonreichweite_af)) AS double_bonreichweite_af,
       --
       double_umsatz_af/anz_art_ AS varianz_umsatz_af,
       double_absatz_af/anz_art_ AS varianz_absatz_af,
       double_ertrag_af/anz_art_ AS varianz_ertrag_af,
       --double_bonreichweite_af/anz_art_ AS varianz_bonreichweite_af,
       -- 
       SQRT(varianz_umsatz_af) AS std_umsatz_af,
       SQRT(varianz_absatz_af) AS std_absatz_af,
       SQRT(varianz_ertrag_af) AS std_ertrag_af,
       --SQRT(varianz_bonreichweite_af) AS std_bonreichweite_af,
       /* Index SA */
       SUM((a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)*(a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)) AS double_umsatz_sa,
       SUM((a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)*(a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)) AS double_absatz_sa,
       SUM((a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)*(a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)) AS double_ertrag_sa,
       SUM((a.bonreichweite_sa-b.avg_bonreichweite_sa)*(a.bonreichweite_af-b.avg_bonreichweite_sa)) AS double_bonreichweite_sa,
       --
       double_umsatz_sa/anz_art_ AS varianz_umsatz_sa,
       double_absatz_sa/anz_art_ AS varianz_absatz_sa,
       double_ertrag_sa/anz_art_ AS varianz_ertrag_sa,
       --double_bonreichweite_sa/anz_art_ AS varianz_bonreichweite_sa,
       -- 
       SQRT(varianz_umsatz_sa) AS std_umsatz_sa,
       SQRT(varianz_absatz_sa) AS std_absatz_sa,
       SQRT(varianz_ertrag_sa) AS std_ertrag_sa--,
       --SQRT(varianz_bonreichweite_sa) AS std_bonreichweite_sa
FROM _index01 a
JOIN _index02 b
  ON a.kl_wg_id = b.kl_wg_id
GROUP BY 1
);



CREATE OR REPLACE VOLATILE TABLE _index04 AS (
SELECT a.*,
       /* Index AF */
       ZEROIFNULL((a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)/NULLIFZERO(c.std_umsatz_af)) AS standardisierung_umsatz_af,
       ZEROIFNULL((a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)/NULLIFZERO(c.std_absatz_af)) AS standardisierung_absatz_af,
       ZEROIFNULL((a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)/NULLIFZERO(c.std_ertrag_af)) AS standardisierung_ertrag_af,
       --(a.bonreichweite_af-b.avg_bonreichweite_af)/c.std_bonreichweite_af AS standardisierung_bonreichweite_af,
      (standardisierung_umsatz_af*0.25)+(standardisierung_absatz_af*0.25)+(standardisierung_ertrag_af*0.25) AS temp_af,
       50*(temp_af+1)+50 AS index_af_tmp,
      /* Index SA */
      ZEROIFNULL((a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)/NULLIFZERO(c.std_umsatz_sa)) AS standardisierung_umsatz_sa,
      ZEROIFNULL((a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)/NULLIFZERO(c.std_absatz_sa)) AS standardisierung_absatz_sa,
      ZEROIFNULL((a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)/NULLIFZERO(c.std_ertrag_sa)) AS standardisierung_ertrag_sa,
     (standardisierung_umsatz_sa*0.25)+(standardisierung_absatz_sa*0.25)+(standardisierung_ertrag_sa*0.25) AS temp_sa,
      --(a.bonreichweite_sa-b.avg_bonreichweite_sa)/c.std_bonreichweite_sa AS standardisierung_bonreichweite_sa,
      50*(temp_sa+1)+50 AS index_sa_tmp
FROM _index01 a
JOIN _index02 b
  ON a.kl_wg_id = b.kl_wg_id
JOIN _index03 c
  ON a.kl_wg_id = c.kl_wg_id
);



CREATE OR REPLACE VOLATILE TABLE _index05_af AS (
SELECT x.kl_wg_id,
       x.kl_owg_id,
       x.kl_uwg_id,
       MAX(x.l_af_quartil) AS l_af_quartil,
       MAX(x.m_af_quartil) AS m_af_quartil,
       MAX(x.h_af_quartil) AS h_af_quartil
FROM (
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       CAST(MEDIAN(a.index_af_tmp) AS INT) AS l_af_quartil,
       CAST(0 AS INT) AS m_af_quartil,
       CAST(0 AS INT) AS h_af_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_af_tmp) AS med_1
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_af_tmp <= b.med_1
GROUP BY 1,2,3
UNION ALL
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(0) AS l_af_quartil,
       MAX(b.med_1) AS m_af_quartil,
       MAX(0) AS h_af_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_af_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_af_tmp <= b.med_1
GROUP BY 1,2,3
UNION ALL
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       0 AS l_af_quartil,
       0 AS m_af_quartil,
       MEDIAN(a.index_af_tmp) AS h_af_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_af_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_af_tmp > b.med_1
GROUP BY 1,2,3) x
GROUP BY 1,2,3
);



CREATE OR REPLACE VOLATILE TABLE _index05_sa AS (
SELECT x.kl_wg_id,
       x.kl_owg_id,
       x.kl_uwg_id,
       MAX(x.l_sa_quartil) AS l_sa_quartil,
       MAX(x.m_sa_quartil)+2 AS m_sa_quartil,
       MAX(x.h_sa_quartil) AS h_sa_quartil
FROM (
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       CAST(MEDIAN(a.index_sa_tmp) AS INT) AS l_sa_quartil,
       CAST(0 AS INT) AS m_sa_quartil,
       CAST(0 AS INT) AS h_sa_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_sa_tmp) AS med_1
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_sa_tmp <= b.med_1
GROUP BY 1,2,3
UNION ALL
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       MAX(0) AS l_sa_quartil,
       MAX(b.med_1) AS m_sa_quartil,
       MAX(0) AS h_sa_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_sa_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_sa_tmp <= b.med_1
GROUP BY 1,2,3
UNION ALL
SELECT a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       0 AS l_sa_quartil,
       0 AS m_sa_quartil,
       MEDIAN(a.index_sa_tmp) AS h_sa_quartil
FROM _index04 a
JOIN (SELECT kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             MEDIAN(index_sa_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.index_sa_tmp > b.med_1
GROUP BY 1,2,3) x
GROUP BY 1,2,3
);


UPDATE _index04 
SET index_af = CASE
                 WHEN _index04.index_af_tmp < b.l_af_quartil
                 THEN 1
                 WHEN _index04.index_af_tmp BETWEEN b.l_af_quartil AND b.m_af_quartil
                 THEN 2
                 ELSE 3
               END

FROM (SELECT *
                      FROM _index05_af) b
					   WHERE _index04.kl_wg_id = b.kl_wg_id AND
      _index04.kl_uwg_id = b.kl_uwg_id AND
      _index04.kl_owg_id = b.kl_owg_id
;


UPDATE _index04 
SET index_sa = CASE
                 WHEN _index04.index_sa_tmp < b.l_sa_quartil
                 THEN 1
                 WHEN _index04.index_sa_tmp BETWEEN b.l_sa_quartil AND b.m_sa_quartil
                 THEN 2
                 ELSE 3
               END

FROM (SELECT *
                      FROM _index05_sa) b
					   WHERE _index04.kl_wg_id = b.kl_wg_id AND
      _index04.kl_uwg_id = b.kl_uwg_id AND
      _index04.kl_owg_id = b.kl_owg_id
;

UPDATE _sal_snap_final 
SET index_af_id = b.index_af,
    index_sa_id = b.index_sa
	
FROM (SELECT art_id,
                                    MAX(index_af) AS index_af,
                                    MAX(index_sa) AS index_sa
                             FROM _index04
                             GROUP BY 1) b
							  WHERE _sal_snap_final.art_id = b.art_id
;



CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_kl AS (
SELECT b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjmo) AS anz,
       COUNT(DISTINCT a.kjwo) AS anz_wochen,
       SUM(a.distr_gew)/anz_wochen AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.anz_maerkte) AS anz_maerkte,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id 
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);



CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_x AS (
SELECT b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       COUNT(DISTINCT x.kjwo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       DENSE_RANK() OVER (PARTITION BY c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM DBP_DATA.art_nielsen_fakten_kjwo a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM DBP_DATA.tag
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id
      FROM DBP_ETL.art_matching_nielsen_per
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN DBP_DATA.nielsen_market d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM DBP_DATA.art_nielsen_fakten_kjwo
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);



CREATE OR REPLACE VOLATILE TABLE _kl_ma_owg_1 AS (
SELECT a.kl_owg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
      (umsatz_kl_x/CAST(umsatz_x AS FLOAT)) * 100.00 AS marktanteil_owg
FROM (SELECT kl_owg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1) a
JOIN (SELECT kl_owg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1) b
  ON a.kl_owg_id = b.kl_owg_id
GROUP BY 1
);



CREATE OR REPLACE VOLATILE TABLE _kl_ma_uwg_1 AS (
SELECT a.kl_owg_id,
       a.kl_uwg_id,
       SUM(a.umsatz__) AS umsatz_x,
       SUM(b.umsatz_kl) AS umsatz_kl_x,
      (ZEROIFNULL(umsatz_kl_x/NULLIFZERO(umsatz_x))) * 100.00 AS marktanteil_uwg
FROM (SELECT kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
      GROUP BY 1,2) a
JOIN (SELECT kl_owg_id,
             kl_uwg_id,
             SUM(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
      GROUP BY 1,2) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id
GROUP BY 1,2
);

UPDATE _sal_snap_final 
SET marktanteilbewertung = b.indexpunkt

FROM (SELECT b.kl_owg_id,
                                    b.kl_uwg_id,
	                a.marktanteil_owg,
	                b.marktanteil_uwg,
	                ZEROIFNULL(b.marktanteil_uwg/NULLIFZERO(a.marktanteil_owg)) AS indexpunkt
                             FROM _kl_ma_owg_1 a
                             JOIN _kl_ma_uwg_1 b
                               ON a.kl_owg_id = b.kl_owg_id) b
 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id
;

CREATE OR REPLACE VOLATILE TABLE _preis_wg_kl AS (
SELECT a.kjmo,
       a.wg_id AS kl_owg_id,
       a.wug_id AS kl_uwg_id,
       CAST(a.durchschnitt_preis_kasse AS INT)+1 AS preis,
       COUNT(*) AS anz_artikel
FROM DBP_DATA.art_kl_preislage_zu_per  a
WHERE a.durchschnitt_preis_kasse IS NOT NULL AND
      a.mandant_id = 1 AND
     (a.kjmo,a.kjwo_update) IN (SELECT MAX(kjmo) AS kjmo,MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _preis_wg_nielsen AS (
SELECT a.kjmo,
       a.kl_owg_id,
       a.kl_uwg_id,
       CAST(a.durchschnitt_preis_kasse AS INT)+1 AS preis,
       COUNT(*) AS anz_artikel
FROM DBP_DATA.art_nielsen_preislage_zu_per a
WHERE a.durchschnitt_preis_kasse IS NOT NULL AND
     (a.kjmo,a.art_matching_id) IN (SELECT kjmo,
                                           art_matching_id 
                                    FROM DBP_DATA.art_kl_preislage_zu_per
                                    WHERE mandant_id = 1 AND
                                         (kjmo,kjwo_update) IN (SELECT MAX(kjmo) AS kjmo,MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                                    GROUP BY 1,2) AND
      a.mandant_id = 1
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _preis_wg AS (
SELECT COALESCE(a.kjmo,b.kjmo) AS kjmo,
       COALESCE(a.kl_owg_id,b.kl_owg_id) AS kl_owg_id,
       COALESCE(a.kl_uwg_id,b.kl_uwg_id) AS kl_uwg_id,
       COALESCE(a.preis,b.preis) AS preis,
       CASE
         --WHEN a.anz_artikel BETWEEN b.anz_artikel*(-1.1) AND b.anz_artikel*1.1 THEN 2
         WHEN COALESCE(a.anz_artikel,0) > COALESCE(b.anz_artikel,0) THEN 3
         WHEN COALESCE(a.anz_artikel,0) < COALESCE(b.anz_artikel,0) THEN 1
         ELSE 2
       END AS preislage_id
FROM _preis_wg_kl a
FULL JOIN _preis_wg_nielsen b
  ON a.kjmo = b.kjmo AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.preis = b.preis
);

UPDATE _sal_snap_final 
SET preislagenverteilung = b.preislage_id

FROM (SELECT *
                             FROM _preis_wg) b
 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      CAST(_sal_snap_final.durchschnittspreis AS INT) = b.preis
;

UPDATE _sal_snap_final SET preislagenverteilung = 2
WHERE preislagenverteilung = 0
;


DELETE FROM DBP_DATA.sortiment_leistung
WHERE mandant_id = 1 AND
     (kjmo,kjwo_update) IN (SELECT MAX(kjmo) AS kjmo,MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

INSERT INTO DBP_DATA.sortiment_leistung (mandant_id
                                        ,kjmo
                                        ,matching_id
                                        ,kjwo_update
                                        ,wrg_id
                                        ,kl_wg_id
                                        ,kl_owg_id
                                        ,kl_uwg_id
                                        ,owg_id
                                        ,wg_id
                                        ,wug_id
                                        ,rang_umsatz_wg
                                        ,rang_umsatz_uwg
                                        ,rang_absatz_uwg
                                        ,art_id
                                        ,kl_art_id
                                        ,art_bez
                                        ,art_status
                                        ,gp_id
                                        ,akt_lieferant
                                        ,zek_id
                                        ,disc_pe
                                        ,disc_marke
                                        ,lcf
                                        ,vegan
                                        ,gluten
                                        ,bio
                                        ,eigenmarke
                                        ,tierwohl
                                        ,posten_food
                                        ,posten_nonfood
                                        ,mwst
                                        ,listung_sst_mvke
                                        ,ost_basis
                                        ,ost_gross
                                        ,sued_ost
                                        ,sued_west
                                        ,west
                                        ,nord
                                        --,anz_maerkte
                                        ,gewichtete_distribution
                                        ,index_af_id
                                        ,umsatz_af_pro_markt_woche
                                        ,absatz_af_pro_markt_woche
                                        ,ertrag_af_pro_markt_woche
                                        ,bonreichweite_af
                                        ,spanne_af
                                        ,index_sa_id
                                        ,umsatz_sa_pro_markt_woche
                                        ,absatz_sa_pro_markt_woche
                                        ,ertrag_sa_pro_markt_woche
                                        ,bonreichweite_sa
                                        ,spanne_sa
                                        ,aktionsanteil_absatz
                                        ,absatz_total
                                        ,schnelldreherquote
                                        ,schnelldreherquote_wg
                                        ,schnelldreherquote_owg
                                        ,kolliabverkaufsquote
                                        ,kolliabverkaufsquote_wg
                                        ,kolliabverkaufsquote_owg
                                        ,abschriftsanteil
                                        ,abschriftsanteil_wg
                                        ,abschriftsanteil_owg
                                        ,cherrypicker_quote
                                        ,cherrypicker_quote_wg
                                        ,cherrypicker_quote_owg
                                        ,restbon
                                        ,restbon_wg
                                        ,restbon_owg
                                        ,vk_preis
                                        ,durchschnittspreis
                                        ,preislagenverteilung
                                        ,marktanteilbewertung
                                        ,produktwissen_vp
                                        ,lieferantenwissen_vp
                                        ,produktwissen_pflege
                                        ,lieferantenwissen_pflege
                                        ,listung_sst_pflege
                                        ,ost_basis_pflege
                                        ,ost_gross_pflege
                                        ,sued_ost_pflege
                                        ,sued_west_pflege
                                        ,west_pflege
                                        ,nord_pflege
                                        ,vorschlag
                                        ,stk_re_pflege
                                        ,umsatz_hr
                                        ,absatz_hr
                                        ,rohertrag_hr
                                        ,nielsen_art_bez
                                        ,gtin
                                        ,distr_gew
                                        ,umsatz_anteil_uwg
                                        ,umsatz_anteil_uwg_kumuliert
                                        ,durchschnitt_anz_maerkte
                                        ,durchschnitt_preis
                                        ,kl_markt_anteil_owg
                                        ,umsatz_artikel
                                        ,absatz_artikel
                                        ,anz_monate
                                        ,anz_wochen
                                        ,eigenmarke_fg
                                        ,anz_maerkte_sst
                                        ,anz_maerkte_baustein_sonstige
                                        ,anz_maerkte_listung_einzel
                                        ,anz_maerkte_listung_gesamt
					,listungsaktion)
SELECT a.mandant_id
      ,kjmo
      ,art_matching_id
      ,z.kjwo
      ,x.default_wrg AS wrg_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,kl_wg_id AS owg_id
      ,kl_owg_id AS wg_id
      ,kl_uwg_id AS wug_id
      ,rang_umsatz_wg
      ,rang_umsatz_uwg
      ,rang_absatz_uwg
      ,art_id
      ,kl_art_id
      ,art_bez
      ,SUBSTR(art_status,1,2) AS art_status
      ,gp_id
      ,akt_lieferant
      ,zek_id
      ,disc_pe
      ,disc_marke
      ,SUBSTR(lcf,1,1) AS lcf
      ,SUBSTR(vegan,1,1) AS vegan
      ,SUBSTR(gluten,1,1) AS gluten
      ,SUBSTR(bio,1,1) AS bio
      ,SUBSTR(eigenmarke,1,2) AS eigenmarke
      ,tierwohl
      ,SUBSTR(posten_food,1,1) AS posten_food
      ,SUBSTR(posten_nonfood,1,1) AS posten_nonfood
      ,mwst
      ,TRIM(k_listung) AS listung_sst_mvke
      ,ost_basis
      ,ost_gross
      ,sued_ost
      ,sued_west
      ,west
      ,nord
      --,anz_maerkte
      ,gewichtete_distribution
      ,index_af_id
      ,umsatz_af_pro_markt_woche
      ,absatz_af_pro_markt_woche
      ,ertrag_af_pro_markt_woche
      ,bonreichweite_af
      ,spanne_af
      ,index_sa_id
      ,umsatz_sa_pro_markt_woche
      ,absatz_sa_pro_markt_woche
      ,ertrag_sa_pro_markt_woche
      ,bonreichweite_sa
      ,spanne_sa
      ,aktionsanteil_absatz
      ,absatz_total
      ,schnelldreherquote
      ,schnelldreherquote_wg
      ,schnelldreherquote_owg
      ,kolliabverkaufsquote
      ,kolliabverkaufsquote_wg
      ,kolliabverkaufsquote_owg
      ,abschriftsanteil
      ,abschriftsanteil_wg
      ,abschriftsanteil_owg
      ,cherrypicker_quote
      ,cherrypicker_quote_wg
      ,cherrypicker_quote_owg
      ,restbon
      ,restbon_wg
      ,restbon_owg
      ,vk_preis
      ,durchschnittspreis
      ,preislagenverteilung
      ,marktanteilbewertung
      -------------------------- TS --------------------------
      ,CAST(' ' AS VARCHAR(255)) AS produktwissen_vp
      ,CAST(' ' AS VARCHAR(255)) AS lieferantenwissen_vp
      ,CAST(' ' AS VARCHAR(255)) AS produktwissen_pflege
      ,CAST(' ' AS VARCHAR(255)) AS lieferantenwissen_pflege
      ,CAST(' ' AS VARCHAR(255)) AS listung_sst_pflege
      ,CAST(' ' AS VARCHAR(255)) AS ost_basis_pflege
      ,CAST(' ' AS VARCHAR(255)) AS ost_gross_pflege
      ,CAST(' ' AS VARCHAR(255)) AS sued_ost_pflege
      ,CAST(' ' AS VARCHAR(255)) AS sued_west_pflege
      ,CAST(' ' AS VARCHAR(255)) AS west_pflege
      ,CAST(' ' AS VARCHAR(255)) AS nord_pflege
      ,CAST(' ' AS VARCHAR(255)) AS vorschlag
      ,CAST(' ' AS VARCHAR(255)) AS stk_re_pflege
      ,NULL AS umsatz_hr
      ,NULL AS absatz_hr
      ,NULL AS rohertrag_hr
      -------------------------- Potenzial --------------------------
      ,NULL AS nielsen_art_bez
      ,NULL AS gtin
      ,NULL AS distr_gew
      ,NULL AS umsatz_anteil_uwg
      ,NULL AS umsatz_anteil_uwg_kumuliert
      ,NULL AS durchschnitt_anz_maerkte
      ,NULL AS durchschnitt_preis
      ,NULL AS kl_markt_anteil_owg
      ,NULL AS umsatz_artikel
      ,NULL AS absatz_artikel
      ,NULL AS anz_monate
      ,NULL AS anz_wochen
      ,NULL AS eigenmarke_fg
      ,0 AS anz_maerkte_sst
      ,0 AS anz_maerkte_baustein_sonstige
      ,0 AS anz_maerkte_listung_einzel
      ,0 AS anz_maerkte_listung_gesamt
      ,CAST(' ' AS VARCHAR(255)) AS listungsaktion
FROM _sal_snap_final a
JOIN DBP_DATA.mandant x
  ON a.mandant_id = x.mandant_id
JOIN DBP_DATA.woche z
  ON 1 = 1
WHERE z.kjwo IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;


INSERT INTO DBP_DATA.sortiment_leistung (mandant_id
                                        ,kjmo
                                        ,matching_id
                                        ,kjwo_update
                                        ,wrg_id
                                        ,kl_wg_id
                                        ,kl_owg_id
                                        ,kl_uwg_id
                                        ,owg_id
                                        ,wg_id
                                        ,wug_id
                                        ,art_id
                                        ,kl_art_id
                                        ,zek_id
                                        ,rang_umsatz_wg
                                        ,rang_umsatz_uwg
                                        ,rang_absatz_uwg
                                        ,nielsen_art_bez
                                        ,gtin
                                        ,distr_gew
                                        ,umsatz_anteil_uwg
                                        ,umsatz_anteil_uwg_kumuliert
                                        ,durchschnitt_anz_maerkte
                                        ,durchschnitt_preis
                                        ,kl_markt_anteil_owg
                                        ,umsatz_artikel
                                        ,absatz_artikel
                                        ,anz_monate
                                        ,anz_wochen
                                        ,eigenmarke_fg)
SELECT 1 AS mandant_id
      ,kjmo
      ,art_matching_id
      ,z.kjwo AS kjwo_update
      ,'EUR' AS wrg_id
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,kl_wg_id AS owg_id
      ,kl_owg_id AS wg_id
      ,kl_uwg_id AS wug_id
      ,art_id AS art_id
      ,a.kl_art_id 
      ,'-99' AS zek_id
      ,rang_umsatz_wg
      ,rang_umsatz_uwg
      ,rang_absatz_uwg
      ,art_nielsen_bez
      ,gtin_id
      ,distr_gew
      ,umsatz_anteil_uwg
      ,umsatz_anteil_uwg_kumuliert
      ,durchschnitt_anz_maerkte
      ,durchschnitt_preis
      ,kl_markt_anteil_owg
      ,umsatz_artikel
      ,absatz_artikel
      ,anz_monate
      ,anz_wochen
      ,eigenmarke_fg
FROM DBP_ETL.sortiment_potenziale a
JOIN DBP_DATA.woche z
  ON 1 = 1
WHERE z.kjwo IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;


UPDATE DBP_DATA.sortiment_leistung SET art_id = NULL
WHERE art_id = -1
;


UPDATE DBP_DATA.sortiment_leistung 
SET art_id = CASE WHEN b.fg_a = 1 THEN b.art_a
                  WHEN b.fg_b = 1 AND (b.fg_c1 = 1 OR b.fg_c2 = 1) THEN b.art_b
                  WHEN b.fg_b = 1 AND b.fg_d1 = 1 THEN b.art_b
                  WHEN b.fg_b = 1 AND b.fg_d2 = 1 AND b.status_d2 = '' THEN b.art_d2
                  WHEN b.fg_b = 1 AND b.fg_d2 = 1 AND b.status_d2 = 'L' THEN b.art_b
                  WHEN b.fg_b = 1 THEN b.art_b
                  WHEN b.fg_c1 = 1 AND (b.fg_d1 = 1 OR b.fg_d2 = 1) THEN b.art_c1
                  WHEN b.fg_c1 = 1 THEN b.art_c1
                  WHEN b.fg_c2 = 1 AND (b.fg_d1 = 1 OR b.fg_d2 = 1) THEN b.art_c2
                  WHEN b.fg_c2 = 1 THEN b.art_c2
                  WHEN b.fg_d1 = 1 THEN b.art_d1
                  WHEN b.fg_d2 = 1 THEN b.art_d2
             END

FROM (SELECT *
                                         FROM DBP_ETL.anzeige_artikel) b
										 WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _check_visibility AS (
SELECT x.mandant_id,
       x.art_matching_id,
       MIN(x.art_id) AS art_id
FROM dbp_etl.art_matching_nielsen_per x
JOIN (SELECT a.mandant_id,
             a.art_matching_id,
             MIN(a.list_kz) AS list_kz
      FROM DBP_ETL.art_matching_nielsen_per a
      JOIN (SELECT mandant_id,
                   matching_id
            FROM DBP_DATA.sortiment_leistung
            WHERE mandant_id = 1 AND
                  POSITION(',' IN kl_art_id) > 0 AND
                  kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)) b
        ON a.mandant_id = b.mandant_id AND
           a.art_matching_id = b.matching_id
      GROUP BY 1,2) y
  ON x.mandant_id = y.mandant_id AND
     x.art_matching_id = y.art_matching_id AND
     x.list_kz = y.list_kz
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _upd_visibility AS (
SELECT a.mandant_id,
       a.matching_id,
       a.kjwo_update,
       b.art_id,
       c.loesch_id
FROM DBP_DATA.sortiment_leistung a
JOIN _check_visibility b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.art_matching_id AND
     a.art_id <> b.art_id
JOIN DBP_DATA.art c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id
WHERE a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
);

UPDATE DBP_DATA.sortiment_leistung 
SET art_id = b.art_id,
    art_status = b.loesch_id
    
FROM (SELECT DISTINCT *
                                                       FROM _upd_visibility) b
                                          WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update
;


UPDATE DBP_DATA.sortiment_leistung 
SET kl_art_id = CAST(floor(DBP_DATA.sortiment_leistung.art_id/100) AS VARCHAR(10))
    ,wug_id = b.wug_id
    ,art_bez = b.art_bez
    ,art_status = b.art_status
    ,gp_id = CAST(SUBSTR(b.akt_lieferant,1,POSITION(':' IN b.akt_lieferant)-1) AS INTEGER)
    ,akt_lieferant = b.akt_lieferant
    ,zek_id = b.zek
    ,disc_pe = b.disc_pe
    ,disc_marke = b.disc_marke
    ,lcf = b.lcf
    ,vegan = b.vegan
    ,gluten = b.gluten
    ,bio = b.bio
    ,eigenmarke = b.eigenmarke
    ,tierwohl = b.tierwohl
    ,posten_food = b.posten_food
    ,posten_nonfood = b.posten_nonfood
    ,mwst = b.mwst
    ,listung_sst_mvke = TRIM(b.k_listung)
    ,ost_basis = b.ost_basis
    ,ost_gross = b.ost_gross
    ,sued_ost = b.sued_ost
    ,sued_west = b.sued_west
    ,west = b.west
    ,nord = b.nord
    --,anz_maerkte = b.anz_listung_as_is
    ,durchschnittspreis = b.stueck_re_mep
FROM (SELECT *
      FROM DBP_ETL.bf_sort_sal_export) b
 WHERE DBP_DATA.sortiment_leistung.art_id IS NOT NULL AND
      DBP_DATA.sortiment_leistung.vk_preis IS NULL AND
      DBP_DATA.sortiment_leistung.gtin IS NOT NULL AND
      floor(DBP_DATA.sortiment_leistung.art_id/100) = CAST(b.art_nr as int) AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung SET art_id = NULL
WHERE art_id = -1 AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

create or replace volatile table _murks_xxx1 as (
select a.*
from dbp_data.sortiment_leistung a
WHERE a.kl_art_id IS NULL AND
      a.art_id IS NOT NULL AND
      a.vk_preis IS NULL AND
      a.gtin IS NOT NULL AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.sortiment_leistung WHERE mandant_id = 1)
);

create or replace volatile table _murks_xxx2 as (
SELECT DISTINCT a.kjmo,
       a.art_id,
       b.kl_art_id,
       a132.wug_id,
       a133.art_bez,
       b.loesch_id AS art_status,
       b.zek_id AS zek
      ,b.aldi_id AS disc_pe
      ,b.discount_id AS disc_marke
      ,b.lactose_fg AS lcf
      ,b.vegan_fg AS vegan
      ,b.gluten_fg AS gluten
      ,b.bio_fg AS bio
      ,b.eigenmarke_id AS eigenmarke
      ,b.tierwohl_kz AS tierwohl
      ,COALESCE(x.mwst, 0) AS mwst
      ,'N/A' AS k_listung
      ,CASE
         WHEN b.posten_id = 'PF'
         THEN 'X'
         ELSE ' '
       END AS posten_food
      ,CASE
         WHEN b.posten_id = 'PN'
         THEN 'X'
         ELSE ' '
       END AS posten_nonfood,
       TRIM(a126.akt_gp_id||':'||a134.akt_gp_name) AS akt_lieferant
from  _murks_xxx1 a
JOIN DBP_MSI_VIEW2.mv_art b
  ON a.art_id = b.art_id AND
     b.mandant_id = 1
JOIN DBP_MSI_VIEW2.mv_art_wg_zu_per a132
  ON a.art_id = a132.art_id AND 
     b.mandant_id = a132.mandant_id
JOIN DBP_MSI_VIEW2.mv_art_spr_zu a133
  ON a.art_id = a133.art_id AND 
     b.mandant_id = a133.mandant_id
LEFT JOIN DBP_DATA.mwst_per x
  ON b.mandant_id = x.mandant_id AND
     b.mwst_id = x.mwst_id AND
     x.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
JOIN DBP_MSI_VIEW2.mv_art_gp_aktuell a126
  ON a.art_id = a126.art_id AND 
     b.mandant_id = a126.mandant_id
JOIN DBP_MSI_VIEW2.mv_gp_aktuell a134
  ON a126.akt_gp_id = a134.akt_gp_id
);

UPDATE DBP_DATA.sortiment_leistung from (select *
                                         from _murks_xxx2) b

SET kl_art_id = CAST(floor(DBP_DATA.sortiment_leistung.art_id/100) AS VARCHAR(10))
    ,wug_id = b.wug_id
    ,art_bez = b.art_bez
    ,art_status = b.art_status
    ,gp_id = CAST(SUBSTR(b.akt_lieferant,1,POSITION(':' IN b.akt_lieferant)-1) AS INTEGER)
    ,akt_lieferant = b.akt_lieferant
    ,zek_id = b.zek
    ,disc_pe = b.disc_pe
    ,disc_marke = b.disc_marke
    ,lcf = b.lcf
    ,vegan = b.vegan
    ,gluten = b.gluten
    ,bio = b.bio
    ,eigenmarke = b.eigenmarke

WHERE DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung 
SET akt_lieferant = b.hersteller_bez

FROM (SELECT gtin_id,
                                                art_nielsen_bez,
                                                MAX(hersteller_bez) AS hersteller_bez
                                         FROM _art_nielsen
                                         WHERE mandant_id = 1
                                         GROUP BY 1,2) b
										  WHERE CAST(DBP_DATA.sortiment_leistung.gtin AS BIGINT) = b.gtin_id AND
      DBP_DATA.sortiment_leistung.nielsen_art_bez = b.art_nielsen_bez AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.art_id IS NULL
;


UPDATE DBP_DATA.sortiment_leistung SET eigenmarke = '-1'
WHERE kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1) AND
      gtin IS NOT NULL AND
      gtin = '-9999' AND
      mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _step1_absatz_vj AS (
SELECT c.kjmo_sort AS kjmo,
       b.art_id,
       SUM(a.menge*b.umrech_faktor) AS absatz_vj
FROM DBP_DATA.artbew a
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM c
  ON a.dat BETWEEN c.dat_von-365 AND c.dat_bis-365
JOIN (SELECT art_id,
             MAX(umrech_faktor) AS umrech_faktor
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1) b
  ON a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
      c.kjmo_sort IN (SELECT MAX(kjmo)
                      FROM DBP_DATA.sortiment_leistung
                      WHERE mandant_id = 1)
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _step2_absatz_vj AS (
SELECT a.kjmo,
       b.art_matching_id,
       b.art_id,
       a.absatz_vj
FROM _step1_absatz_vj a
JOIN (SELECT art_id,
             art_matching_id
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1,2) b
  ON a.art_id = b.art_id
GROUP BY 1,2,3,4
);

UPDATE DBP_DATA.sortiment_leistung 
SET absatz_total_vj = b.absatz_vj

FROM (SELECT kjmo,
                                                              art_matching_id,
                                                              SUM(absatz_vj) AS absatz_vj
                                                       FROM _step2_absatz_vj
                                                       GROUP BY 1,2) b
                                               WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjmo = b.kjmo AND
      DBP_DATA.sortiment_leistung.kjmo = b.kjmo AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;


UPDATE DBP_DATA.sortiment_leistung SET kassenumsatz_kl_absolut_brutto = 0,
                                                     kassenumsatz_kl_absolut_netto  = 0,
                                                     abschriften_wert_netto_absolut = 0
WHERE mandant_id = 1 AND
      kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _step1_umsatz_brutto AS (
SELECT c.kjmo_sort AS kjmo,
       b.art_id,
       Sum(a.umsatz_netto) AS umsatz_netto,
       Sum(a.umsatz_netto+a.umsatz_mwst_betrag) AS umsatz_brutto
FROM DBP_DATA.artbew a
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM c
  ON a.dat BETWEEN c.dat_von AND c.dat_bis
JOIN (SELECT art_id
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1) b
  ON a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
      c.kjmo_sort IN (SELECT Max(kjmo)
                      FROM DBP_DATA.sortiment_leistung
                      WHERE mandant_id = 1)
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _step2_umsatz_brutto AS (
SELECT a.kjmo,
       b.art_matching_id,
       b.art_id,
       a.umsatz_netto,
       a.umsatz_brutto
FROM _step1_umsatz_brutto a
JOIN (SELECT art_id,
             art_matching_id
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1,2) b
  ON a.art_id = b.art_id
GROUP BY 1,2,3,4,5
);

UPDATE DBP_DATA.sortiment_leistung 
SET kassenumsatz_kl_absolut_brutto = b.umsatz_brutto,
    kassenumsatz_kl_absolut_netto  = b.umsatz_netto

FROM (SELECT kjmo,
                                                              art_matching_id,
                                                              Sum(umsatz_netto) AS umsatz_netto,
                                                              Sum(umsatz_brutto) AS umsatz_brutto
                                                       FROM _step2_umsatz_brutto
                                                       GROUP BY 1,2) b
                                               WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjmo = b.kjmo AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

CREATE OR REPLACE VOLATILE TABLE _step1_abschr AS (
SELECT c.kjmo_sort AS kjmo,
       b.art_id,
       Sum(a.abschriftenbetrag_netto) AS abschriftenbetrag_netto
FROM DBP_MSI_VIEW2.mv_marktabschriften a
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM c
  ON a.dat BETWEEN c.dat_von AND c.dat_bis
JOIN (SELECT art_id
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1) b
  ON a.art_id = b.art_id
WHERE a.mandant_id = 1 AND
      c.kjmo_sort IN (SELECT Max(kjmo)
                      FROM DBP_DATA.sortiment_leistung
                      WHERE mandant_id = 1) AND
      a.abschriftenart_id <> -1
GROUP BY 1,2
);



CREATE OR REPLACE VOLATILE TABLE _step2_abschr AS (
SELECT a.kjmo,
       b.art_matching_id,
       b.art_id,
       a.abschriftenbetrag_netto
FROM _step1_abschr a
JOIN (SELECT art_id,
             art_matching_id
      FROM DBP_ETL.art_matching_nielsen_per 
      GROUP BY 1,2) b
  ON a.art_id = b.art_id
GROUP BY 1,2,3,4
);


UPDATE DBP_DATA.sortiment_leistung 
SET abschriften_wert_netto_absolut = b.abschriftenbetrag_netto

FROM (SELECT kjmo,
                                                              art_matching_id,
                                                              Sum(abschriftenbetrag_netto) AS abschriftenbetrag_netto
                                                       FROM _step2_abschr
                                                       GROUP BY 1,2) b
                                               WHERE DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjmo = b.kjmo AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

-- 18.01.2022, -dbay-
--
-- proper handling of duplicates

insert into dbp_etl_process.matching_art_nielsen_zu
select mandant_id,
       kjwo_update,
       art_matching_id,
       art_nielsen_id,
       gtin_id
from dbp_etl.art_matching_nielsen_per
where (mandant_id,art_matching_id) in (SELECT mandant_id,
                                              matching_id
                                       FROM DBP_DATA.sortiment_leistung
                                       WHERE mandant_id = 1 AND
                                             kjwo_update in (select max(kjwo_update) as kjwo_update from dbp_data.sortiment_leistung where mandant_id = 1)
                                       GROUP BY 1,2
                                       HAVING COUNT(*) > 1) and
       art_nielsen_id <> -1 and
      (mandant_id,art_matching_id,art_nielsen_id,kjwo_update) not in (select mandant_id,art_matching_id,art_nielsen_id,kjwo_update from dbp_etl_process.matching_art_nielsen_zu)
group by 1,2,3,4,5
;

create or replace volatile table _sorti_agg as (
select mandant_id
,kjmo
,matching_id
,kjwo_update
,MAX(kl_wg_id                                          )  kl_wg_id                           
,MAX(kl_owg_id                                         )  kl_owg_id                          
,MAX(kl_uwg_id                                         )  kl_uwg_id                          
,MAX(owg_id                                            )  owg_id                             
,MAX(wg_id                                             )  wg_id                              
,MAX(wug_id                                            )  wug_id                             
,MAX(rang_umsatz_wg                                    )  rang_umsatz_wg                     
,MAX(rang_umsatz_uwg                                   )  rang_umsatz_uwg                    
,MAX(rang_absatz_uwg                                   )  rang_absatz_uwg                    
,MAX(art_id                                            )  art_id                             
,MAX(kl_art_id                                         )  kl_art_id                          
,MAX(art_bez                                           )  art_bez                            
,MAX(art_status                                        )  art_status                         
,MAX(gp_id                                             )  gp_id                              
,MAX(akt_lieferant                                     )  akt_lieferant                      
,MAX(disc_pe                                           )  disc_pe                            
,MAX(disc_marke                                        )  disc_marke                         
,MAX(lcf                                               )  lcf                                
,MAX(vegan                                             )  vegan                              
,MAX(gluten                                            )  gluten                             
,MAX(bio                                               )  bio                                
,MAX(eigenmarke                                        )  eigenmarke                         
,MAX(tierwohl                                          )  tierwohl                           
,MAX(posten_food                                       )  posten_food                        
,MAX(posten_nonfood                                    )  posten_nonfood                     
,MAX(mwst                                              )  mwst                               
,MAX(listung_k_sst_mvke                                )  listung_k_sst_mvke                 
,MAX(gewichtete_distribution                           )  gewichtete_distribution            
,MAX(index_af_id                                       )  index_af_id                        
,MAX(umsatz_af_pro_markt_woche                         )  umsatz_af_pro_markt_woche          
,MAX(absatz_af_pro_markt_woche                         )  absatz_af_pro_markt_woche          
,MAX(ertrag_af_pro_markt_woche                         )  ertrag_af_pro_markt_woche          
,MAX(bonreichweite_af                                  )  bonreichweite_af                   
,MAX(spanne_af                                         )  spanne_af                          
,MAX(index_sa_id                                       )  index_sa_id                        
,MAX(umsatz_sa_pro_markt_woche                         )  umsatz_sa_pro_markt_woche          
,MAX(absatz_sa_pro_markt_woche                         )  absatz_sa_pro_markt_woche          
,MAX(ertrag_sa_pro_markt_woche                         )  ertrag_sa_pro_markt_woche          
,MAX(bonreichweite_sa                                  )  bonreichweite_sa                   
,MAX(spanne_sa                                         )  spanne_sa                          
,MAX(aktionsanteil_absatz                              )  aktionsanteil_absatz               
,MAX(absatz_total                                      )  absatz_total                       
,MAX(schnelldreherquote                                )  schnelldreherquote                 
,MAX(schnelldreherquote_wg                             )  schnelldreherquote_wg              
,MAX(schnelldreherquote_owg                            )  schnelldreherquote_owg             
,MAX(kolliabverkaufsquote                              )  kolliabverkaufsquote               
,MAX(kolliabverkaufsquote_wg                           )  kolliabverkaufsquote_wg            
,MAX(kolliabverkaufsquote_owg                          )  kolliabverkaufsquote_owg           
,MAX(abschriftsanteil                                  )  abschriftsanteil                   
,MAX(abschriftsanteil_wg                               )  abschriftsanteil_wg                
,MAX(abschriftsanteil_owg                              )  abschriftsanteil_owg               
,MAX(cherrypicker_quote                                )  cherrypicker_quote                 
,MAX(cherrypicker_quote_wg                             )  cherrypicker_quote_wg              
,MAX(cherrypicker_quote_owg                            )  cherrypicker_quote_owg             
,MAX(restbon                                           )  restbon                            
,MAX(restbon_wg                                        )  restbon_wg                         
,MAX(restbon_owg                                       )  restbon_owg                        
,MAX(vk_preis                                          )  vk_preis                           
,MAX(durchschnittspreis                                )  durchschnittspreis                 
,MAX(preislagenverteilung                              )  preislagenverteilung               
,MAX(marktanteilbewertung                              )  marktanteilbewertung               
,MAX(produktwissen_vp                                  )  produktwissen_vp                   
,MAX(lieferantenwissen_vp                              )  lieferantenwissen_vp               
,MAX(produktwissen_pflege                              )  produktwissen_pflege               
,MAX(lieferantenwissen_pflege                          )  lieferantenwissen_pflege           
,MAX(listung_sst_pflege                                )  listung_sst_pflege                 
,MAX(ost_basis_pflege                                  )  ost_basis_pflege                   
,MAX(ost_gross_pflege                                  )  ost_gross_pflege                   
,MAX(sued_ost_pflege                                   )  sued_ost_pflege                    
,MAX(sued_west_pflege                                  )  sued_west_pflege                   
,MAX(west_pflege                                       )  west_pflege                        
,MAX(nord_pflege                                       )  nord_pflege                        
,MAX(vorschlag                                         )  vorschlag                          
,MAX(stk_re_pflege                                     )  stk_re_pflege                      
,MAX(umsatz_hr                                         )  umsatz_hr                          
,MAX(absatz_hr                                         )  absatz_hr                          
,MAX(rohertrag_hr                                      )  rohertrag_hr                       
,MAX(nielsen_art_bez                                   )  nielsen_art_bez                    
,MAX(gtin                                              )  gtin                               
,MAX(distr_gew                                         )  distr_gew                          
,MAX(umsatz_anteil_uwg                                 )  umsatz_anteil_uwg                  
,MAX(umsatz_anteil_uwg_kumuliert                       )  umsatz_anteil_uwg_kumuliert        
,MAX(durchschnitt_anz_maerkte                          )  durchschnitt_anz_maerkte           
,MAX(durchschnitt_preis                                )  durchschnitt_preis                 
,MAX(kl_markt_anteil_owg                               )  kl_markt_anteil_owg                
,MAX(umsatz_artikel                                    )  umsatz_artikel                     
,MAX(absatz_artikel                                    )  absatz_artikel                     
,MAX(anz_monate                                        )  anz_monate                         
,MAX(anz_wochen                                        )  anz_wochen                         
,MAX(eigenmarke_fg                                     )  eigenmarke_fg                      
,MAX(listung_sst_mvke                                  )  listung_sst_mvke                   
,MAX(ost_basis                                         )  ost_basis                          
,MAX(ost_gross                                         )  ost_gross                          
,MAX(sued_ost                                          )  sued_ost                           
,MAX(sued_west                                         )  sued_west                          
,MAX(west                                              )  west                               
,MAX(nord                                              )  nord                               
,MAX(anz_maerkte_sst                                   )  anz_maerkte_sst                    
,MAX(anz_maerkte_baustein_sonstige                     )  anz_maerkte_baustein_sonstige      
,MAX(anz_maerkte_listung_einzel                        )  anz_maerkte_listung_einzel         
,MAX(anz_maerkte_listung_gesamt                        )  anz_maerkte_listung_gesamt         
,MAX(listungsaktion                                    )  listungsaktion                     
,MAX(anz_maerkte_k_sst                                 )  anz_maerkte_k_sst                  
,MAX(listung_k_sst_pflege                              )  listung_k_sst_pflege               
,MAX(muki_wb_kz                                        )  muki_wb_kz                         
,MAX(muki_wb_kl_art_id_verkettung                      )  muki_wb_kl_art_id_verkettung       
,MAX(muki_vk_kz                                        )  muki_vk_kz                         
,MAX(muki_vk_kl_art_id_verkettung                      )  muki_vk_kl_art_id_verkettung       
,MAX(muki_ek_kz                                        )  muki_ek_kz                         
,MAX(muki_ek_kl_art_id_verkettung                      )  muki_ek_kl_art_id_verkettung       
,MAX(absatz_total_vj                                   )  absatz_total_vj                    
,MAX(max_anz_maerkte_sst                               )  max_anz_maerkte_sst                
,MAX(max_anz_maerkte_k_sst                             )  max_anz_maerkte_k_sst              
,MAX(kassenumsatz_kl_absolut_brutto                    )  kassenumsatz_kl_absolut_brutto     
,MAX(kassenumsatz_kl_absolut_netto                     )  kassenumsatz_kl_absolut_netto      
,MAX(abschriften_wert_netto_absolut                    )  abschriften_wert_netto_absolut
,MAX(current_timestamp) as td_insert
,MAX(current_timestamp) as td_update
,MAX(zek_id                                            )  zek_id                             
,MAX(wrg_id                                            )  wrg_id                        
from dbp_data.sortiment_leistung
where (mandant_id,matching_id,kjwo_update) in (select mandant_id,art_matching_id,kjwo_update
                                               from dbp_etl_process.matching_art_nielsen_zu
                                               where mandant_id = 1 and
                                                     kjwo_update in (select max(kjwo_update) as kjwo_update from dbp_data.sortiment_leistung where mandant_id = 1))
group by 1,2,3,4
);

delete from dbp_data.sortiment_leistung
where (mandant_id,kjwo_update,matching_id) in (select mandant_id,kjwo_update,matching_id from _sorti_agg)
;

insert into dbp_data.sortiment_leistung
select a.*
from _sorti_agg a
;

-- kl_old de

create or replace volatile table _upd1 as 
(
select distinct kjwo_update,mandant_id,art_id,gtin_id 
                                    from dbp_etl.art_matching_nielsen_per
                                    where kjwo_update in (select MAX(kjwo_update) from dbp_etl.art_matching_nielsen_per )
                                    and art_nielsen_id <> -1 and art_id <> -1 and gtin_id not in (-9999,-9998)
) ;


create or replace volatile table _upd2 as 
(
select distinct kjwo_update,mandant_id,art_matching_id,ART_NIELSEN_ID,gtin_id 
                                    from dbp_etl.art_matching_nielsen_per 
                                    where kjwo_update in (select MAX(kjwo_update) from dbp_etl.art_matching_nielsen_per )
                                    and gtin_id not in (-9999,-9998)
) ;

update DBP_DATA.sortiment_leistung from (select kjwo_update,mandant_id,art_id,max(gtin_id) as gtin_id
                                    from _upd1 group by 1,2,3) b
SET gtin = b.gtin_id
WHERE   
DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update and
DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id and 
DBP_DATA.sortiment_leistung.art_id = b.art_id and
dbp_data.sortiment_leistung.gtin is null and 
dbp_data.sortiment_leistung.art_id is not null 
;


update DBP_DATA.sortiment_leistung from (select kjwo_update,mandant_id,art_matching_id ,max(gtin_id) as gtin_id
                                    from _upd2 where art_nielsen_id <> - 1 group by 1,2,3) b
SET gtin = b.gtin_id
WHERE   
DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update and
DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id and 
DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id and 
dbp_data.sortiment_leistung.gtin is null and 
dbp_data.sortiment_leistung.art_id is not null 
;

