create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_1 where DAT_BIS='9999-12-31'
) ;

DROP TABLE IF EXISTS dbp_etl.bf_listung_markt_kw_kmo_1;
CREATE TABLE dbp_etl.bf_listung_markt_kw_kmo_1  (
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
       art_id,
       status_1,
       Max(kl_wg_id) Over (PARTITION BY mandant_id,art_matching_id ORDER BY kl_wg_id) AS kl_wg_id,
       Max(kl_owg_id) Over (PARTITION BY mandant_id,art_matching_id ORDER BY kl_owg_id) AS kl_owg_id,
       Max(kl_uwg_id) Over (PARTITION BY mandant_id,art_matching_id ORDER BY kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_1
WHERE art_id <> -1 AND
      mandant_id > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_min_arts AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.art_id,
       c.owg_id,
       b.wg_id,
       b.wug_id
FROM (SELECT DISTINCT
             mandant_id,
             art_matching_id,
             Min(art_id) Over (PARTITION BY mandant_id,art_matching_id ORDER BY art_id) AS art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE status_1 = 'T' AND
            mandant_id > 1 AND
            art_id <> -1) a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
JOIN (SELECT *
      FROM dbp_data.wg_per_1
      WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
            owg_id NOT IN (-1,-3) AND
            mandant_id > 1) c
  ON a.mandant_id = c.mandant_id AND
     b.wg_id = c.wg_id
);

UPDATE _art_leistung_1 
SET kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id
    
FROM (

SELECT a.mandant_id,
       a.art_matching_id,
       b.wg_id,
       b.wug_id
FROM (SELECT DISTINCT
             mandant_id,
             art_matching_id,
             Min(art_id) Over (PARTITION BY mandant_id,art_matching_id ORDER BY art_id) AS art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE status_1 = 'T' AND
            mandant_id > 1 AND
            art_id <> -1) a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
     
) b
 WHERE _art_leistung_1.mandant_id = b.mandant_id AND
      _art_leistung_1.art_matching_id = b.art_matching_id AND
      _art_leistung_1.status_1 = 'T'
;

UPDATE _art_leistung_1 
SET kl_wg_id = b.owg_id
	
FROM (SELECT *
                             FROM dbp_data.wg_per_1
                             WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
                                   owg_id NOT IN (-1,-3) AND
                                   mandant_id > 1) b
 WHERE _art_leistung_1.mandant_id = b.mandant_id AND
      _art_leistung_1.kl_owg_id = b.wg_id
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       Count(DISTINCT x.kjmo) AS anz,
       Sum(a.distr_gew)/anz AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.menge_af) AS menge_af_,
       Sum(a.umsatz_brutto_af) AS umsatz_af_,
       Sum(a.menge_sa) AS menge_sa_,
       Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       Cast(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_1
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.mandant_id > 1 AND
     (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                      x.kjmo
                               FROM (SELECT mandant_id,
                                            kjmo,
                                            Dense_Rank() Over (ORDER BY kjmo DESC) * (-1) AS akt_mo
                                     FROM dbp_data.art_nielsen_fakten_kjmo_1
                                     WHERE mandant_id  > 1
                                     GROUP BY 1,2) x
                               WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_leistung_base1 AS (
SELECT mandant_id,
       art_nielsen_id,
       art_id,
       kl_owg_id,
       kl_uwg_id,
       Cast(0 AS DECIMAL(18,4)) distr_gew,
       NULL AS rang_umsatz_wg,
       NULL AS rang_umsatz_uwg,
       NULL AS rang_absatz_uwg
FROM _art_leistung_1
WHERE art_nielsen_id <> -1
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_wg_ranking AS (
SELECT mandant_id,
       art_nielsen_id,
       kl_wg_id,
       gtin_id,
       Sum(umsatz_) AS umsatz__,
       Dense_Rank() Over (PARTITION BY mandant_id,kl_wg_id ORDER BY umsatz__ DESC) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2,3,4
);

UPDATE _artikel_anteil_uwg_leistung_base1 
SET rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    distr_gew = b.distr_gew_

FROM (SELECT *
                                                FROM _artikel_anteil_uwg_ranking) b
												 WHERE _artikel_anteil_uwg_leistung_base1.art_nielsen_id = b.art_nielsen_id AND
      _artikel_anteil_uwg_leistung_base1.kl_uwg_id = b.kl_uwg_id AND
      _artikel_anteil_uwg_leistung_base1.mandant_id = b.mandant_id
;

DELETE FROM _artikel_anteil_wg_ranking
WHERE (mandant_id,art_nielsen_id,kl_wg_id) NOT IN (SELECT mandant_id,
                                                          art_nielsen_id,
                                                          Min(kl_wg_id) AS min_kl_wg_id
                                                   FROM _artikel_anteil_wg_ranking
                                                   GROUP BY 1,2
                                                   HAVING Count(*) > 1) AND
     (mandant_id,art_nielsen_id) IN (SELECT mandant_id,art_nielsen_id
                                     FROM _artikel_anteil_wg_ranking
                                     GROUP BY 1,2
                                     HAVING Count(*) > 1)
;

UPDATE _artikel_anteil_uwg_leistung_base1 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
                                                FROM _artikel_anteil_wg_ranking) b
												 WHERE _artikel_anteil_uwg_leistung_base1.art_nielsen_id = b.art_nielsen_id AND
      _artikel_anteil_uwg_leistung_base1.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_ranking 
SET rang_umsatz_wg = b.rang_umsatz_wg

FROM (SELECT *
                                         FROM _artikel_anteil_wg_ranking) b
												 WHERE _artikel_anteil_uwg_ranking.art_nielsen_id = b.art_nielsen_id AND
      _artikel_anteil_uwg_ranking.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_1 AS (
SELECT b.art_matching_id,
       --b.art_id,
       --b.umrech_faktor,
       b.status_1,
       Cast(0 AS DECIMAL(18,4)) AS distr_gew,
       a.*,
       c.sm_id,
       c.ksm_id
FROM dbp_data.sal_kmo_1 a
LEFT JOIN (SELECT 
           mandant_id
           ,art_id
           ,Min(CASE WHEN sm_id = -2 THEN 'R' ELSE sm_id END) sm_id
           ,Min(ksm_id) ksm_id
           FROM dbp_etl_process.art_sm_vw_zu_per_1
           WHERE mandant_id > 1 
           AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
	   GROUP BY  1,2) c
ON c.mandant_id = a.mandant_id
AND c.art_id = a.art_id
JOIN (SELECT mandant_id,
             art_matching_id,
             floor(art_id/10) AS kl_art_id,
             art_id,
             status_1
      FROM _art_leistung_1
      GROUP BY 1,2,3,4,5) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE (a.mandant_id,a.kjmo) IN (SELECT mandant_id,
                                       Min(b.kjmo) AS kjmo 
                                FROM (SELECT mandant_id,
                                             Coalesce(kjmo_nielsen,kjmo_tag) kjmo
                                      FROM (SELECT mandant_id,
                                                   Max(kjmo) AS kjmo_nielsen
                                            FROM dbp_data.art_nielsen_fakten_kjmo_1
                                            WHERE mandant_id > 1
                                            GROUP BY 1) a1
                                      CROSS JOIN (SELECT Max(kjmo) kjmo_tag 
                                                  FROM dbp_data.tag_1
                                                  WHERE akt_mo = -1) a2
                                      GROUP BY 1,2) a
                                JOIN dbp_data.tag_1 b
                                  ON a.kjmo = b.kjmo
                                GROUP BY 1)
);

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.status_1,
       Cast(0 AS INTEGER) AS kl_wg_id,
       Cast(0 AS INTEGER) AS kl_owg_id,
       Cast(0 AS INTEGER) AS kl_uwg_id,
       NULL AS rang_umsatz_wg,
       NULL AS rang_umsatz_uwg,
       NULL AS rang_absatz_uwg,
       a.art_id,
       floor(a.art_id/10) AS kl_art_id,
       a.wug_id,
       b.art_bez AS art_bez,
       a.sm_id,
       a.ksm_id,
       a.art_status,
       a.gp_id,
       --CAST(SUBSTR(akt_lieferant,1,POSITION(':' IN akt_lieferant)-1) AS INTEGER) AS gp_id,
       --akt_lieferant,
       a.gp_name,
       a.zek_id AS zek_1,
       a.disc_pe,
       a.disc_marke,
       a.lactose_fg AS lcf,
       a.vegan_fg AS vegan,
       a.gluten_fg AS gluten,
       a.bio_fg AS bio,
       a.eigenmarke_id AS eigenmarke,
       ' ' AS tierwohl,
       a.posten_food,
       a.posten_nonfood,
       a.mwst,
       a.k_listung,
       ' ' ost_basis,
       ' ' ost_gross,
       ' ' sued_ost,
       ' ' sued_west,
       ' ' west,
       ' ' nord,
       /* a.total_anz_markt AS anz_maerkte, */
       a.distr_gew AS gewichtete_distribution,
       /* Index-AF */
       0 AS index_af_id,
       a.total_umsatz_netto_af/NullIfZero(a.total_anz_kjwo_wug_absatz) AS umsatz_af_pro_markt_woche,
      (a.total_artbew_menge_af/NullIfZero(a.total_anz_kjwo_wug_absatz_af))*1 AS absatz_af_pro_markt_woche,
       (a.total_rohertrag_af )/NullIfZero(a.total_anz_kjwo_wug_absatz) AS ertrag_af_pro_markt_woche,
       Cast(0 AS FLOAT) AS bonreichweite_af,
       ZeroIfNull(ertrag_af_pro_markt_woche/NullIfZero(umsatz_af_pro_markt_woche)) AS spanne_af,
       /* Index-SA */
       0 AS index_sa_id,
       ZeroIfNull((a.total_umsatz_netto_sa/NullIfZero(a.total_anz_tage_wug_absatz_sa)))*7.00 AS umsatz_sa_pro_markt_woche,
       ZeroIfNull(((a.total_artbew_menge_sa*1)/NullIfZero(a.total_anz_tage_wug_absatz_sa)))*7.00 AS absatz_sa_pro_markt_woche,
       ZeroIfNull(((a.total_rohertrag_sa )/NullIfZero(a.total_anz_tage_wug_absatz_sa)))*7.00 AS ertrag_sa_pro_markt_woche,
       Cast(0 AS FLOAT) AS bonreichweite_sa, 
       ZeroIfNull(ertrag_sa_pro_markt_woche/NullIfZero(umsatz_sa_pro_markt_woche)) AS spanne_sa,
       /* Kennzahlen */
       Round(a.total_artbew_menge_sa/NullIfZero(a.total_artbew_menge)*100,1)*1 AS aktionsanteil_absatz,
       a.total_artbew_menge*1 AS absatz_total,
       /* Bon */
       a.schnelldreherquote AS schnelldreherquote,
       Cast(0 AS FLOAT) AS schnelldreherquote_wg,
       Cast(0 AS FLOAT) AS schnelldreherquote_owg,
       CASE
         WHEN a.kol_la_bzw IS NOT NULL
         THEN ZeroIfNull((a.mhd_zeitraum*a.lager_prozent)*Coalesce((absatz_af_pro_markt_woche*1)/7,absatz_sa_pro_markt_woche*1)/NullIfZero(kol_la_bzw))
         ELSE ZeroIfNull(a.mhd_zeitraum_dz*Coalesce((absatz_af_pro_markt_woche*1)/7,absatz_sa_pro_markt_woche*1)/NullIfZero(kol_bst_bzw))
       END AS kolliabverkaufsquote,
       Cast(0 AS FLOAT) AS kolliabverkaufsquote_wg,
       Cast(0 AS FLOAT) AS kolliabverkaufsquote_owg,
       ZeroIfNull(a.abschriftbetrag_netto_oWerbung/NullIfZero(a.total_umsatz_netto)) AS abschriftsanteil,
       Cast(0 AS FLOAT) AS abschriftsanteil_wg,
       Cast(0 AS FLOAT) AS abschriftsanteil_owg,
       Cast(0 AS FLOAT) AS cherrypicker_quote, 
       Cast(0 AS FLOAT) AS cherrypicker_quote_wg,
       Cast(0 AS FLOAT) AS cherrypicker_quote_owg,
       Cast(0 AS DECIMAL(18,4)) AS restbon, 
       Cast(0 AS DECIMAL(18,4)) AS restbon_wg,
       Cast(0 AS DECIMAL(18,4)) AS restbon_owg,
       /* Bewertung */
       a.vk_brutto_pk1 AS vk_preis,
       CASE
         WHEN a.total_umsatz_netto_af <> 0
         THEN ZeroIfNull(a.total_umsatz_netto_af/NullIfZero(a.total_artbew_menge_af))
         ELSE ZeroIfNull(a.total_umsatz_netto_sa/NullIfZero(a.total_artbew_menge_sa)) 
       END AS durchschnittspreis,
       Cast(0 AS FLOAT) AS preislagenverteilung,
       Cast(0 AS FLOAT) AS marktanteilbewertung,
       /* zur Berechnung */
       a.total_anz_kjwo_wug_absatz AS anz_wo_mit_absatz,
       a.total_anz_kjwo_wug_absatz_af AS anz_wo_mit_absatz_af,
       Cast(a.total_anz_tage_wug_absatz_sa/7.0000 AS DECIMAL(18,4)) AS anz_wo_mit_absatz_sa,
       a.anz_kjwo_wup_listung AS anz_wo_listung_1,
       a.kol_la_bzw,
       a.kol_bst_bzw,
       a.mhd_zeitraum_dz AS rlz_dz,
       a.mhd_zeitraum AS rlz,
       a.lager_prozent AS lagerprozent,
      (a.total_artbew_menge_af/NullIfZero(a.total_anz_kjwo_wug_absatz_af))*1 total_absatz_af_mt_wo,
      (a.total_artbew_menge_sa/NullIfZero(a.total_anz_tage_wug_absatz_sa))*1 total_absatz_sa_mt_tag,
       a.total_artbew_menge_af*1 total_af_absatz,
       a.total_artbew_menge_sa*1 total_sa_absatz,
       a.total_umsatz_netto_af AS af_umsatz_netto,
       a.total_umsatz_netto_sa AS sa_umsatz_netto,
       a.total_anz_tage_wug_absatz_sa*1 absatz_sa_markt_tage,
       a.total_anz_kjwo_wug_absatz_af*1 absatz_af_markt_wochen,
       Cast(a.abschriftbetrag_netto_oWerbung AS FLOAT) AS abschr_o_werb,
       Cast(a.total_umsatz_netto AS FLOAT) AS kassenumsatz
FROM _sal_snap_1 a
LEFT JOIN dbp_data.art_spr_zu_1 b
ON a.art_id = b.art_id AND 
a.mandant_id = b.mandant_id AND
b.spr_id NOT IN (22,24)
);

UPDATE _sal_snap_2 
SET bonreichweite_af = krw_af,
    bonreichweite_sa = krw_sa
	
FROM (SELECT mandant_id,
                                kl_art_id,
                                Sum(krw_af) AS krw_af,
				Sum(krw_sa) AS krw_sa,
				Sum(cpq_total) AS cpq_total,
				Sum(rb_total) AS rb_total
                         FROM dbp_etl.kpi_aggregat_kmo_1
                         WHERE mandant_id > 1 AND
                               kjmo_sort IN (SELECT Max(kjmo_sort)
                                             FROM dbp_etl.kpi_aggregat_kmo_1
                                             WHERE mandant_id > 1)
			 GROUP BY 1,2) b
						  WHERE _sal_snap_2.kl_art_id = b.kl_art_id AND
      _sal_snap_2.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _step1 AS (
SELECT b.mandant_id,
       b.art_id,
       c.wg_id,
       Sum(a.artikel_bons_af) AS art_bons_af,
       Sum(a.artikel_bons_sa) AS art_bons_sa,
       Sum(a.cpq_total) AS cpq_total_artikel,
       Sum(a.cherry_bons_af) AS cp_bons_af,
       Sum(a.cherry_bons_sa) AS cp_bons_sa
FROM dbp_etl.kpi_aggregat_kmo_1 a
JOIN dbp_data.art_1 b
  ON a.mandant_id = b.mandant_id AND
     a.kl_art_id = b.kl_art_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
JOIN dbp_data.art_wg_zu_per_1 c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id AND
     c.arthiertyp_id = 2 AND
     c.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
WHERE a.mandant_id > 1 AND 
     (a.mandant_id,a.kjmo_sort) IN (SELECT mandant_id,
                                           Max(kjmo_sort)
                                    FROM dbp_etl.kpi_aggregat_kmo_1
                                    WHERE mandant_id > 1
                                    GROUP BY 1)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _step2 AS (
SELECT mandant_id,
       wg_id,
      (Sum(Cast(cp_bons_af AS FLOAT))  + Sum(Cast(cp_bons_sa AS FLOAT)) ) / NullIfZero(Sum(Cast(art_bons_af AS FLOAT)+ Cast(art_bons_sa AS FLOAT)))  AS cpq_total_wg
FROM _step1
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2_multis AS (
SELECT a.*
FROM _sal_snap_2 a
JOIN (SELECT art_matching_id,
             mandant_id
      FROM _sal_snap_2
      GROUP BY 1,2
      HAVING Count(*) > 1) b
  ON a.art_matching_id = b.art_matching_id AND
     a.mandant_id = b.mandant_id
);

UPDATE _sal_snap_2_multis 
SET wug_id            = b.wug_id         ,            
    art_bez           = b.art_bez        ,  
    art_status        = b.art_status     ,  
    gp_id             = b.gp_id          ,  
    gp_name           = b.gp_name        ,  
    zek_1               = b.zek_1            ,  
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
    nord              = b.nord            

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
                                                  FROM DBP_DATA.art_wup_zu_per_1
                                                  WHERE mandant_id > 1 AND
                                	                listung_id = 1
                                                  GROUP BY 1) y
                                              ON x.kl_art_id = floor(y.art_id/10)
                                            GROUP BY 1,2,3) z
                                      --GROUP BY 1
                                      QUALIFY ROW_NUMBER() over (PARTITION BY 1 ORDER BY z.art_matching_id DESC, z.dat_von DESC, z.kl_art_id DESC) = 1) x1
                                  ON y.art_matching_id = x1.art_matching_id AND
                                     y.kl_art_id = x1.kl_art_id) b
                                     
WHERE _sal_snap_2_multis.art_matching_id = b.art_matching_id AND
      _sal_snap_2_multis.mandant_id = b.mandant_id
;

DROP TABLE IF EXISTS dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1;
CREATE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1  (
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

INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1
SELECT a.mandant_id,
       c.kjwo,
       b.wg_id,
       a.art_id,
       a.wup_id,
       a.nb_id,
       a.bewart_id,
       a.menge,
       a.umsatz_netto,
       a.ek_mep
FROM dbp_data.artbew_wo_sum_1 a
JOIN dbp_data.woche_kj_kl_1 c
  ON a.kjwo_kl = c.kjwo_kl
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
JOIN (SELECT mandant_id,
             art_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE art_id <> -1
      GROUP BY 1,2) d
  ON a.art_id = d.art_id AND
     a.mandant_id = d.mandant_id
WHERE (a.mandant_id,c.kjwo) IN (SELECT b.mandant_id,
                                       c.kjwo
                                FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                JOIN (SELECT mandant_id,
                                             Max(kjmo) AS kjmo
                                      FROM dbp_data.sortiment_leistung_1
                                      WHERE mandant_id > 1
                                      GROUP BY 1) b
                                  ON a.kjmo_sort = b.kjmo
                                JOIN dbp_data.woche_1 c
                                  ON c.kjwo BETWEEN a.kjwo_von AND a.kjwo_bis
                                GROUP BY 1,2)
;

INSERT INTO dbp_etl.bf_listung_markt_kw_kmo_1 (mandant_id
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
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto)) AS umsatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto end)) AS umsatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto end)) AS umsatz_af
      ,ZeroIfNull(Sum(v01.umsatz_netto-v01.ek_mep)) AS ertrag
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.umsatz_netto-v01.ek_mep end)) AS ertrag_af
      ,ZeroIfNull(CASE WHEN absatz>0 THEN Count(DISTINCT v01.kjwo) END) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end) end) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_1 v01
JOIN dbp_data.art_wg_zu_per_1 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_1 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
GROUP BY 1,2,3,4,5,6,7
;

CREATE OR REPLACE VOLATILE TABLE _anz_wochen AS (
SELECT a.kjwo,
       a.mandant_id,
       b.art_matching_id,
       a.wup_id,
       ZeroIfNull(Sum(a.absatz)) AS absatz_,
       ZeroIfNull(Sum(a.absatz_af)) AS absatz_af_,
       ZeroIfNull(Sum(a.absatz_sa)) AS absatz_sa_,
       ZeroIfNull(Sum(a.umsatz)) AS umsatz_,
       ZeroIfNull(Sum(a.umsatz_af)) AS umsatz_af_,
       ZeroIfNull(Sum(a.umsatz_sa)) AS umsatz_sa_,
       ZeroIfNull(Sum(a.ertrag)) AS ertrag_,
       ZeroIfNull(Sum(a.ertrag_af)) AS ertrag_af_,
       ZeroIfNull(Sum(a.ertrag_sa)) AS ertrag_sa_,
       ZeroIfNull(CASE WHEN absatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz,
       ZeroIfNull(CASE WHEN absatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_af,
       ZeroIfNull(CASE WHEN absatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_absatz_sa,
       ZeroIfNull(CASE WHEN umsatz_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz,
       ZeroIfNull(CASE WHEN umsatz_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_af,
       ZeroIfNull(CASE WHEN umsatz_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_umsatz_sa,
       ZeroIfNull(CASE WHEN ertrag_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag,
       ZeroIfNull(CASE WHEN ertrag_af_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_af,
       ZeroIfNull(CASE WHEN ertrag_sa_>0 THEN Count(DISTINCT a.kjwo) END) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_kmo_1 a
JOIN (SELECT mandant_id,
             art_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      WHERE art_id <> -1
      GROUP BY 1,2,3) b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id
WHERE (a.mandant_id,a.kjwo) IN (SELECT b.mandant_id,
                                       c.kjwo
                                FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                JOIN (SELECT mandant_id,
                                             Max(kjmo) AS kjmo
                                      FROM dbp_data.sortiment_leistung_1
                                      WHERE mandant_id > 1
                                      GROUP BY 1) b
                                  ON a.kjmo_sort = b.kjmo
                                JOIN dbp_data.woche_1 c
                                  ON c.kjwo BETWEEN a.kjwo_von AND a.kjwo_bis
                                GROUP BY 1,2) AND
      b.art_matching_id IN (SELECT art_matching_id FROM _sal_snap_2_multis)
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _anz_wochen1 AS (
SELECT art_matching_id,
       mandant_id,
       Sum(absatz_) AS absatz,
       Sum(absatz_af_) AS absatz_af,
       Sum(absatz_sa_) AS absatz_sa,
       Sum(umsatz_) AS umsatz,
       Sum(umsatz_af_) AS umsatz_af,
       Sum(umsatz_sa_) AS umsatz_sa,
       Sum(ertrag_) AS ertrag,
       Sum(ertrag_af_) AS ertrag_af,
       Sum(ertrag_sa_) AS ertrag_sa,
       Sum(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
       Sum(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
       Sum(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
       Sum(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
       Sum(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
       Sum(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
       Sum(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
       Sum(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
       Sum(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM _anz_wochen
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _woche AS (
SELECT b.mandant_id,
       a.kjwo
FROM dbp_data.woche_1 a
JOIN dbp_data.mandant_1 b
  ON 1 = 1
WHERE (b.mandant_id,a.kjwo) IN (SELECT b.mandant_id,
                                       c.kjwo
                                FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 a
                                JOIN (SELECT mandant_id,
                                             Max(kjmo) AS kjmo
                                      FROM dbp_data.sortiment_leistung_1
                                      WHERE mandant_id > 1
                                      GROUP BY 1) b
                                  ON a.kjmo_sort = b.kjmo
                                JOIN dbp_data.woche_1 c
                                  ON c.kjwo BETWEEN a.kjwo_von AND a.kjwo_bis
                                GROUP BY 1,2)
GROUP BY 1,2
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
       CASE WHEN Sum(a11.absatz) > 0 THEN 1 ELSE 0 END  anz_wo_mit_absatz
FROM dbp_etl.bf_listung_markt_kw_kmo_1 a11
JOIN dbp_etl.art_matching_nielsen_per_1 b
  ON a11.art_id = b.art_id AND
     a11.mandant_id = b.mandant_id 
WHERE a11.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 11) AND 
     (a11.mandant_id,a11.kjwo) IN (SELECT mandant_id,kjwo FROM _woche) AND
      a11.mandant_id > 1 AND
      b.art_matching_id IN (SELECT art_matching_id FROM _sal_snap_2_multis)
GROUP BY 1,2,3,4
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08_pre  (
    kjwo INTEGER,
    matching_id INTEGER, 
    mandant_id BYTEINT,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT)
;

INSERT INTO ZZSP08_pre
SELECT a11.kjwo,
       b.art_matching_id matching_id,
       a11.mandant_id  mandant_id,
       a11.wup_id wup_id,
       Count (DISTINCT a11.kjwo)  anz_wo_listung_1
FROM dbp_data.art_wup_listung_kjwo_1 a11
JOIN dbp_etl.art_matching_nielsen_per_kmo_1 b
  ON a11.mandant_id = b.mandant_id AND
     a11.art_id = b.art_id
WHERE a11.mandant_id > 1 AND
      (a11.mandant_id,a11.kjwo) IN (SELECT mandant_id,kjwo FROM _woche) AND
      b.art_matching_id IN (SELECT art_matching_id FROM _sal_snap_2_multis)      
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
       anz_wo_listung_1,
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
       Sum(a11.anz_wo_mit_absatz)  anz_wo_mit_absatz
FROM _mm a11
WHERE a11.anz_wo_mit_absatz <> 0
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE ZZSP08  (
  matching_id INTEGER, 
  mandant_id BYTEINT,
  anz_wo_listung_1 FLOAT)
;

INSERT INTO ZZSP08 
SELECT a11.matching_id  matching_id,
       a11.mandant_id  mandant_id,
       Sum(a11.anz_wo_listung_1)  anz_wo_listung_1
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
  anz_wo_listung_1 FLOAT, 
  anz_wo_mit_absatz	FLOAT,
  schnelldreherquote FLOAT)
;

INSERT INTO ZZMD0A_xxx 
SELECT pa11.matching_id  matching_id,
       pa11.mandant_id  mandant_id,
       1.0  WJXBFS1,
       pa13.anz_wo_listung_1  anz_wo_listung_1,
       pa12.anz_wo_mit_absatz  anz_wo_mit_absatz,
       Round((pa12.anz_wo_mit_absatz/NullIfZero(pa13.anz_wo_listung_1))*100,1) AS schnelldreherquote
FROM ZZOJ09 pa11
LEFT JOIN ZZSP07 pa12
  ON pa11.matching_id = pa12.matching_id AND 
     pa11.mandant_id = pa12.mandant_id
LEFT JOIN ZZSP08 pa13
  ON pa11.matching_id = pa13.matching_id AND
     pa11.mandant_id = pa13.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_2_multis1 AS (
SELECT x.mandant_id,
       x.art_matching_id,
       x.status_1,
       Max(Coalesce(xxx.owg_id,x.kl_wg_id)) AS kl_wg_id,
       Max(Coalesce(xxx.wg_id,x.kl_owg_id)) AS kl_owg_id,
       Max(Coalesce(xxx.wug_id,x.kl_uwg_id)) AS kl_uwg_id,
       Max(x.rang_umsatz_wg) AS rang_umsatz_wg,
       Max(x.rang_umsatz_uwg) AS rang_umsatz_uwg,
       Max(x.rang_absatz_uwg) AS rang_absatz_uwg,
       Max(Coalesce(xxx.art_id,x.art_id)) AS art_id,
       REPLACE(TRIM((LISTAGG(lpad(cast(cast(LPAD(CAST(x.kl_art_id AS VARCHAR(600)),8,'0') as int) as varchar(8)),8,'0'), ',') within group (ORDER BY x.kl_art_id) ), ','),' ', '') AS kl_art_id,
       Max(Coalesce(xxx.wug_id,x.wug_id)) AS wug_id,
       Max(x.art_bez) AS art_bez,
       Max(x.sm_id) AS sm_id,
       Max(x.ksm_id) AS ksm_id,
       Max(x.art_status) AS art_status,
       Max(x.gp_id) AS gp_id,
       Max(x.gp_name) AS gp_name,
       Max(x.zek_1) AS zek_1,
       Max(x.disc_pe) AS disc_pe,
       Max(x.disc_marke) AS disc_marke,
       Max(x.lcf) AS lcf,
       Max(x.vegan) AS vegan,
       Max(x.gluten) AS gluten,
       Max(x.bio) AS bio,
       Max(x.eigenmarke) AS eigenmarke,
       Max(x.tierwohl) AS tierwohl,
       Max(x.posten_food) AS posten_food,
       Max(x.posten_nonfood) AS posten_nonfood,
       Max(x.mwst) AS mwst,
       Max(x.k_listung) AS k_listung,
       Max(x.ost_basis) AS ost_basis,
       Max(x.ost_gross) AS ost_gross,
       Max(x.sued_ost) AS sued_ost,
       Max(x.sued_west) AS sued_west,
       Max(x.west) AS west,
       Max(x.nord) AS nord,
       ZeroIfNull(Sum(x.gewichtete_distribution)/NullIfZero(Count(*))) AS gewichtete_distribution,
       /* Index AF */
       Max(x.index_af_id) AS index_af_id,
       ZeroIfNull(Sum(x.af_umsatz_netto)/NullIfZero(Max(y.anzahl_wochen_mit_umsatz_af))) AS umsatz_af_pro_markt_woche_,
       ZeroIfNull(Sum(x.total_af_absatz)/NullIfZero(Max(y.anzahl_wochen_mit_absatz_af))) AS absatz_af_pro_markt_woche_,
       ZeroIfNull(Max(y.ertrag_af)/NullIfZero(Max(y.anzahl_wochen_mit_ertrag_af))) AS ertrag_af_pro_markt_woche_,
       Sum(x.bonreichweite_af) AS bonreichweite_af,
       ZeroIfNull(ertrag_af_pro_markt_woche_/NullIfZero(umsatz_af_pro_markt_woche_)) AS spanne_af,
       /* Index SA */
       Max(x.index_sa_id) AS index_sa_id,
       ZeroIfNull(Sum(x.sa_umsatz_netto)/NullIfZero(Max(y.anzahl_wochen_mit_umsatz_sa))) AS umsatz_sa_pro_markt_woche_,
       ZeroIfNull(Sum(x.total_sa_absatz)/NullIfZero(Max(y.anzahl_wochen_mit_absatz_sa))) AS absatz_sa_pro_markt_woche_,
       ZeroIfNull(Max(y.ertrag_sa)/NullIfZero(Max(y.anzahl_wochen_mit_ertrag_sa))) AS ertrag_sa_pro_markt_woche_,
       Sum(x.bonreichweite_sa) AS bonreichweite_sa,
       ZeroIfNull(ertrag_sa_pro_markt_woche_/NullIfZero(umsatz_sa_pro_markt_woche_)) AS spanne_sa,
       /* Kennzahlen */
       ZeroIfNull(Sum(total_sa_absatz)/NullIfZero(Sum(x.absatz_total))) AS aktionsanteil_absatz,
       Sum(x.absatz_total) AS absatz_total,
       /* Bon */
       ZeroIfNull(Sum(Cast(x.anz_wo_mit_absatz AS FLOAT))/NullIfZero(Sum(Cast(x.anz_wo_listung_1 AS FLOAT)))) AS schnelldreherquote,
       Sum(schnelldreherquote_wg) AS schnelldreherquote_wg,
       Sum(schnelldreherquote_owg) AS schnelldreherquote_owg,
       CASE
         WHEN Max(kol_la_bzw) IS NOT NULL
         THEN ZeroIfNull(((Max(rlz)/Count(*))*Max(lagerprozent))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/6,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_la_bzw)))
         ELSE ZeroIfNull((Max(rlz_dz)/Count(*))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/6,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_bst_bzw)))
       END AS kolliabverkaufsquote,
       Sum(kolliabverkaufsquote_wg) AS kolliabverkaufsquote_wg,
       Sum(kolliabverkaufsquote_owg) AS kolliabverkaufsquote_owg,
       ZeroIfNull(Sum(Cast(abschr_o_werb AS FLOAT))/NullIfZero(Sum(Cast(kassenumsatz AS FLOAT)))) AS abschriftsanteil,
       Sum(abschriftsanteil_wg) AS abschriftsanteil_wg,
       Sum(abschriftsanteil_owg) AS abschriftsanteil_owg,
       Sum(cherrypicker_quote)/Count(*) AS cherrypicker_quote,
       Sum(cherrypicker_quote_wg) AS cherrypicker_quote_wg,
       Sum(cherrypicker_quote_owg) AS cherrypicker_quote_owg,
       SUM(restbon) AS restbon,
       Sum(restbon_wg) AS restbon_wg,
       Sum(restbon_owg) AS restbon_owg,
       /* Bewertung */
       Max(vk_preis) AS vk_preis, ---> muessen wir aendern! 
       CASE
         WHEN Sum(af_umsatz_netto) <> 0
         THEN ZeroIfNull(Sum((af_umsatz_netto*((100+mwst)/100)))/NullIfZero(Sum(total_af_absatz)))
         ELSE ZeroIfNull(Sum((sa_umsatz_netto*((100+mwst)/100)))/NullIfZero(Sum(total_sa_absatz))) 
       END AS durchschnittspreis, ----> brutto!
       Sum(preislagenverteilung) AS preislagenverteilung,
       Sum(marktanteilbewertung) AS marktanteilbewertung,
       /* Berechnung */
       Sum(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
       Sum(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
       Sum(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa,
       Sum(anz_wo_listung_1) AS anz_wo_listung_1,
       Max(kol_la_bzw) AS kol_la_bzw,
       Max(kol_bst_bzw) AS kol_bst_bzw,
       Max(rlz_dz) AS rlz_dz,
       Max(rlz) AS rlz,
       Max(lagerprozent) AS lagerprozent,
       Sum(total_absatz_af_mt_wo) AS total_absatz_af_mt_wo,
       Sum(total_absatz_sa_mt_tag) AS total_absatz_sa_mt_tag,
       Sum(total_af_absatz) AS total_af_absatz,
       Sum(total_sa_absatz) AS total_sa_absatz,
       Sum(af_umsatz_netto) AS af_umsatz_netto,
       Sum(sa_umsatz_netto) AS sa_umsatz_netto,
       Sum(absatz_sa_markt_tage) AS absatz_sa_markt_tage,
       Sum(absatz_af_markt_wochen) AS absatz_af_markt_wochen,
       Sum(abschr_o_werb) AS abschr_o_werb,
       Sum(kassenumsatz) AS kassenumsatz
FROM _sal_snap_2_multis x

LEFT JOIN _track_min_arts xxx_1
  ON x.mandant_id = xxx.mandant_id AND
     x.art_matching_id = xxx.art_matching_id

LEFT JOIN _step1 z
  ON x.mandant_id = z.mandant_id AND
     x.art_id = z.art_id

LEFT JOIN _anz_wochen1 y
  ON x.art_matching_id = y.art_matching_id AND
     x.mandant_id = y.mandant_id

WHERE (x.art_matching_id,x.mandant_id) NOT IN (SELECT art_matching_id,mandant_id FROM DBP_ETL.art_matching_nielsen_per_1 WHERE gtin_id IN (-9998,-9999) AND mandant_id > 1)

GROUP BY 1,2,3
);

UPDATE _sal_snap_2_multis1 
SET schnelldreherquote = b.sdq/100

FROM (SELECT schnelldreherquote AS sdq,
                                        matching_id,
                                        mandant_id
                                 FROM ZZMD0A_xxx
                                 GROUP BY 1,2,3) b
										 WHERE _sal_snap_2_multis1.art_matching_id = b.matching_id AND
      _sal_snap_2_multis1.mandant_id = b.mandant_id
;

DELETE FROM _sal_snap_2
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,art_matching_id FROM _sal_snap_2_multis1)
;

CREATE OR REPLACE VOLATILE TABLE _sal_snap_final AS (
SELECT a.mandant_id
      ,d.kjmo_sort AS kjmo
      ,art_matching_id
      /*,' ' AS status_1
      ,umrech_faktor*/
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,rang_umsatz_wg
      ,rang_umsatz_uwg
      ,rang_absatz_uwg
      ,art_id
      ,Cast(kl_art_id AS VARCHAR(300)) AS kl_art_id
      ,wug_id
      ,art_bez
      ,art_status
      ,sm_id
      ,ksm_id
      ,gp_id
      ,gp_name
      ,zek_1 AS zek_id
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
      /* ,anz_maerkte */
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
      ,anz_wo_listung_1
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
FROM _sal_snap_2 a
JOIN (SELECT Max(kjmo) AS max_kjmo
      FROM dbp_data.art_nielsen_fakten_kjmo_1
      WHERE mandant_id > 1) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 d
  ON c.max_kjmo = d.kjmo_sort
);

INSERT INTO _sal_snap_final
SELECT a.mandant_id
      ,d.kjmo_sort AS kjmo
      ,art_matching_id
      /*,' ' AS status_1
      ,umrech_faktor*/
      ,kl_wg_id
      ,kl_owg_id
      ,kl_uwg_id
      ,rang_umsatz_wg
      ,rang_umsatz_uwg
      ,rang_absatz_uwg
      ,art_id
      ,Cast(Substr(kl_art_id,1,300) AS VARCHAR(300)) AS kl_art_id
      ,wug_id
      ,art_bez
      ,art_status
      ,sm_id
      ,ksm_id
      ,gp_id
      ,gp_name
      ,zek_1 AS zek_id
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
      /* ,anz_maerkte */
      ,gewichtete_distribution
      ,index_af_id
      ,umsatz_af_pro_markt_woche_
      ,absatz_af_pro_markt_woche_
      ,ertrag_af_pro_markt_woche_
      ,bonreichweite_af
      ,spanne_af
      ,index_sa_id
      ,umsatz_sa_pro_markt_woche_
      ,absatz_sa_pro_markt_woche_
      ,ertrag_sa_pro_markt_woche_
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
      ,anz_wo_listung_1
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
FROM _sal_snap_2_multis1 a
JOIN (SELECT Max(kjmo) AS max_kjmo
      FROM dbp_data.art_nielsen_fakten_kjmo_1
      WHERE mandant_id > 1) c
  ON 1 = 1
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_1 d
  ON c.max_kjmo = d.kjmo_sort
;

DELETE FROM _sal_snap_final
WHERE (mandant_id,art_id,art_matching_id) NOT IN (SELECT mandant_id,
                                                         art_id,
                                                         Min(art_matching_id) AS min_matching_id
                                                  FROM _sal_snap_final
                                                  GROUP BY 1,2
                                                  HAVING Count(*) > 1) AND
     (mandant_id,art_id) IN (SELECT mandant_id,art_id
                             FROM _sal_snap_final
                             GROUP BY 1,2
                             HAVING Count(*) > 1)
;

UPDATE _sal_snap_final 
SET kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id

FROM (SELECT mandant_id,
                                    art_id,
                                    Max(kl_wg_id) AS kl_wg_id,
				    Max(kl_owg_id) AS kl_owg_id,
				    Max(kl_uwg_id) AS kl_uwg_id
                             FROM _art_leistung_1
			     GROUP BY 1,2) b
							  WHERE _sal_snap_final.art_id = b.art_id AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.rang_umsatz_wg,
    rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg,
    gewichtete_distribution = b.distr_gew

FROM (SELECT mandant_id,
                                    art_id,
                                    Max(rang_umsatz_wg) AS rang_umsatz_wg,
				    Max(rang_umsatz_uwg) AS rang_umsatz_uwg,
 				    Max(rang_absatz_uwg) AS rang_absatz_uwg,
				    Sum(distr_gew) AS distr_gew
                             FROM _artikel_anteil_uwg_leistung_base1
			     GROUP BY 1,2) b
							  WHERE _sal_snap_final.art_id = b.art_id AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg,
    rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                    kl_owg_id,
                                    kl_uwg_id,
                                    Max(rang_umsatz_wg) AS next_rang_ums_wg,
                                    Max(rang_umsatz_uwg) AS next_rang_ums_uwg,
                                    Max(rang_absatz_uwg) AS next_rang_abs_uwg
			     FROM _artikel_anteil_uwg_ranking
			     GROUP BY 1,2,3) b
												 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT mandant_id,
                                    kl_wg_id,
                                    Max(rang_umsatz_wg)+1 AS next_rang_ums_wg
			     FROM _artikel_anteil_uwg_ranking
			     GROUP BY 1,2) b
												 WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                    kl_owg_id,
                                    kl_uwg_id,
                                    Coalesce(Max(rang_umsatz_uwg),0)+1 AS next_rang_ums_uwg,
				    Coalesce(Max(rang_absatz_uwg),0)+1 AS next_rang_abs_uwg
			     FROM _sal_snap_final a
			     WHERE a.rang_umsatz_uwg IS NULL
			     GROUP BY 1,2,3) b
												 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_wg = b.next_rang_ums_wg

FROM (SELECT mandant_id,
                                    kl_wg_id,
                                    Max(Coalesce(rang_umsatz_wg,0))+1 AS next_rang_ums_wg
			     FROM _sal_snap_final
			     GROUP BY 1,2) b
												 WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id AND
      _sal_snap_final.rang_umsatz_wg IS NULL AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET rang_umsatz_uwg = b.next_rang_ums_uwg,
    rang_absatz_uwg = b.next_rang_abs_uwg

FROM (SELECT mandant_id,
                                    kl_owg_id,
                                    Max(Coalesce(rang_umsatz_uwg,0))+1 AS next_rang_ums_uwg,
				    Max(Coalesce(rang_absatz_uwg,0))+1 AS next_rang_abs_uwg
	  		     FROM _sal_snap_final
			     GROUP BY 1,2) b
												 WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.rang_umsatz_uwg IS NULL AND
      _sal_snap_final.rang_absatz_uwg IS NULL AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET schnelldreherquote_wg = b.schnelldreherquote_wg,
    kolliabverkaufsquote_wg = b.kolliabverkaufsquote_wg,
    abschriftsanteil_wg = b.abschriftsanteil_wg
	
FROM (SELECT mandant_id,
                                    kl_wg_id,
                                    ZeroIfNull(Sum(Cast(anz_wo_mit_absatz AS FLOAT))/NullIfZero(Sum(Cast(anz_wo_listung_1 AS FLOAT)))) AS schnelldreherquote_wg,
				    CASE WHEN Max(kol_la_bzw) IS NOT NULL
		                     THEN ZeroIfNull(((Sum(rlz)/Count(*))*Max(lagerprozent))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/7,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_la_bzw)))
		                     ELSE ZeroIfNull((Sum(rlz_dz)/Count(*))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/7,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_bst_bzw)))
	                            END AS kolliabverkaufsquote_wg,
				    ZeroIfNull(Sum(Cast(abschr_o_werb AS FLOAT))/NullIfZero(Sum(Cast(kassenumsatz AS FLOAT)))) AS abschriftsanteil_wg
                             FROM _sal_snap_final
                             GROUP BY 1,2) b
							  WHERE _sal_snap_final.kl_wg_id = b.kl_wg_id AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET schnelldreherquote_owg = b.schnelldreherquote_owg,
    kolliabverkaufsquote_owg = b.kolliabverkaufsquote_owg,
    abschriftsanteil_owg = b.abschriftsanteil_owg
	
FROM (SELECT mandant_id,
                                    kl_owg_id,
                                    Sum(Cast(anz_wo_mit_absatz AS FLOAT))/Sum(Cast(anz_wo_listung_1 AS FLOAT)) AS schnelldreherquote_owg,
				    CASE
	                              WHEN Max(kol_la_bzw) IS NOT NULL
		                      THEN ZeroIfNull(((Sum(rlz)/Count(*))*Max(lagerprozent))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/7,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_la_bzw)))
		                      ELSE ZeroIfNull((Sum(rlz_dz)/Count(*))*Coalesce((Sum(total_af_absatz)/Sum(absatz_af_markt_wochen))/7,Sum(total_sa_absatz)/Sum(absatz_sa_markt_tage))/NullIfZero(Max(kol_bst_bzw)))
	                            END AS kolliabverkaufsquote_owg,
				    ZeroIfNull(Sum(Cast(abschr_o_werb AS FLOAT))/NullIfZero(Sum(Cast(kassenumsatz AS FLOAT)))) AS abschriftsanteil_owg
                             FROM _sal_snap_final
                             GROUP BY 1,2) b
							  WHERE _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.mandant_id = b.mandant_id
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
SELECT mandant_id,
       kl_wg_id,
       /* Index AF */
       Avg(umsatz_af_pro_markt_woche) AS avg_umsatz_af_pro_markt_woche,
       Avg(absatz_af_pro_markt_woche) AS avg_absatz_af_pro_markt_woche,
       Avg(ertrag_af_pro_markt_woche) AS avg_ertrag_af_pro_markt_woche,
       Avg(bonreichweite_af) AS avg_bonreichweite_af,
       /* Index SA */
       Avg(umsatz_sa_pro_markt_woche) AS avg_umsatz_sa_pro_markt_woche,
       Avg(absatz_sa_pro_markt_woche) AS avg_absatz_sa_pro_markt_woche,
       Avg(ertrag_sa_pro_markt_woche) AS avg_ertrag_sa_pro_markt_woche,
       Avg(bonreichweite_sa) AS avg_bonreichweite_sa,
       Count(*) AS anz_art
FROM _index01
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _index03 AS (
SELECT a.mandant_id,
       a.kl_wg_id,
       Max(b.anz_art) AS anz_art_,
       /* Index AF */
       Sum((a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)*(a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)) AS double_umsatz_af,
       Sum((a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)*(a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)) AS double_absatz_af,
       Sum((a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)*(a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)) AS double_ertrag_af,
       Sum((a.bonreichweite_af-b.avg_bonreichweite_af)*(a.bonreichweite_af-b.avg_bonreichweite_af)) AS double_bonreichweite_af,
       double_umsatz_af/anz_art_ AS varianz_umsatz_af,
       double_absatz_af/anz_art_ AS varianz_absatz_af,
       double_ertrag_af/anz_art_ AS varianz_ertrag_af,
       Sqrt(varianz_umsatz_af) AS std_umsatz_af,
       Sqrt(varianz_absatz_af) AS std_absatz_af,
       Sqrt(varianz_ertrag_af) AS std_ertrag_af,
       /* Index SA */
       Sum((a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)*(a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)) AS double_umsatz_sa,
       Sum((a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)*(a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)) AS double_absatz_sa,
       Sum((a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)*(a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)) AS double_ertrag_sa,
       Sum((a.bonreichweite_sa-b.avg_bonreichweite_sa)*(a.bonreichweite_af-b.avg_bonreichweite_sa)) AS double_bonreichweite_sa,
       double_umsatz_sa/anz_art_ AS varianz_umsatz_sa,
       double_absatz_sa/anz_art_ AS varianz_absatz_sa,
       double_ertrag_sa/anz_art_ AS varianz_ertrag_sa,
       Sqrt(varianz_umsatz_sa) AS std_umsatz_sa,
       Sqrt(varianz_absatz_sa) AS std_absatz_sa,
       Sqrt(varianz_ertrag_sa) AS std_ertrag_sa
FROM _index01 a
JOIN _index02 b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _index04 AS (
SELECT a.*,
       /* Index AF */
       ZeroIfNull((a.umsatz_af_pro_markt_woche-b.avg_umsatz_af_pro_markt_woche)/NullIfZero(c.std_umsatz_af)) AS standardisierung_umsatz_af,
       ZeroIfNull((a.absatz_af_pro_markt_woche-b.avg_absatz_af_pro_markt_woche)/NullIfZero(c.std_absatz_af)) AS standardisierung_absatz_af,
       ZeroIfNull((a.ertrag_af_pro_markt_woche-b.avg_ertrag_af_pro_markt_woche)/NullIfZero(c.std_ertrag_af)) AS standardisierung_ertrag_af,
       --(a.bonreichweite_af-b.avg_bonreichweite_af)/c.std_bonreichweite_af AS standardisierung_bonreichweite_af,
      (standardisierung_umsatz_af*0.25)+(standardisierung_absatz_af*0.25)+(standardisierung_ertrag_af*0.25) AS temp_af,
       50*(temp_af+1)+50 AS index_af_tmp,
      /* Index SA */
      ZeroIfNull((a.umsatz_sa_pro_markt_woche-b.avg_umsatz_sa_pro_markt_woche)/NullIfZero(c.std_umsatz_sa)) AS standardisierung_umsatz_sa,
      ZeroIfNull((a.absatz_sa_pro_markt_woche-b.avg_absatz_sa_pro_markt_woche)/NullIfZero(c.std_absatz_sa)) AS standardisierung_absatz_sa,
      ZeroIfNull((a.ertrag_sa_pro_markt_woche-b.avg_ertrag_sa_pro_markt_woche)/NullIfZero(c.std_ertrag_sa)) AS standardisierung_ertrag_sa,
     (standardisierung_umsatz_sa*0.25)+(standardisierung_absatz_sa*0.25)+(standardisierung_ertrag_sa*0.25) AS temp_sa,
      --(a.bonreichweite_sa-b.avg_bonreichweite_sa)/c.std_bonreichweite_sa AS standardisierung_bonreichweite_sa,
      50*(temp_sa+1)+50 AS index_sa_tmp
FROM _index01 a
JOIN _index02 b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.mandant_id = b.mandant_id
JOIN _index03 c
  ON a.kl_wg_id = c.kl_wg_id AND
     a.mandant_id = c.mandant_id
);

CREATE OR REPLACE VOLATILE TABLE _index05_af AS (
SELECT x.mandant_id,
       x.kl_wg_id,
       x.kl_owg_id,
       x.kl_uwg_id,
       Max(x.l_af_quartil) AS l_af_quartil,
       Max(x.m_af_quartil) AS m_af_quartil,
       Max(x.h_af_quartil) AS h_af_quartil
FROM (SELECT a.mandant_id,
             a.kl_wg_id,
             a.kl_owg_id,
             a.kl_uwg_id,
             Cast(Median(a.index_af_tmp) AS INT) AS l_af_quartil,
             Cast(0 AS INT) AS m_af_quartil,
	     Cast(0 AS INT) AS h_af_quartil
      FROM _index04 a
      JOIN (SELECT mandant_id,
                   kl_wg_id,
                   kl_owg_id,
                   kl_uwg_id,
                   Median(index_af_tmp) AS med_1
            FROM _index04
	    GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_af_tmp <= b.med_1
GROUP BY 1,2,3,4
UNION ALL
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Max(0) AS l_af_quartil,
       Max(b.med_1) AS m_af_quartil,
       Max(0) AS h_af_quartil
FROM _index04 a
JOIN (SELECT mandant_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             Median(index_af_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_af_tmp <= b.med_1
GROUP BY 1,2,3,4
UNION ALL
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       0 AS l_af_quartil,
       0 AS m_af_quartil,
       Median(a.index_af_tmp) AS h_af_quartil
FROM _index04 a
JOIN (SELECT mandant_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             Median(index_af_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_af_tmp > b.med_1
GROUP BY 1,2,3,4) x
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _index05_sa AS (
SELECT x.mandant_id,
       x.kl_wg_id,
       x.kl_owg_id,
       x.kl_uwg_id,
       Max(x.l_sa_quartil) AS l_sa_quartil,
       Max(x.m_sa_quartil)+2 AS m_sa_quartil,
       Max(x.h_sa_quartil) AS h_sa_quartil
FROM (SELECT a.mandant_id,
             a.kl_wg_id,
             a.kl_owg_id,
             a.kl_uwg_id,
             Cast(Median(a.index_sa_tmp) AS INT) AS l_sa_quartil,
             Cast(0 AS INT) AS m_sa_quartil,
	     Cast(0 AS INT) AS h_sa_quartil
      FROM _index04 a
      JOIN (SELECT mandant_id,
                   kl_wg_id,
                   kl_owg_id,
                   kl_uwg_id,
                   Median(index_sa_tmp) AS med_1
            FROM _index04
	    GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_sa_tmp <= b.med_1
GROUP BY 1,2,3,4
UNION ALL
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Max(0) AS l_sa_quartil,
       Max(b.med_1) AS m_sa_quartil,
       Max(0) AS h_sa_quartil
FROM _index04 a
JOIN (SELECT mandant_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             Median(index_sa_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_sa_tmp <= b.med_1
GROUP BY 1,2,3,4
UNION ALL
SELECT a.mandant_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       0 AS l_sa_quartil,
       0 AS m_sa_quartil,
       Median(a.index_sa_tmp) AS h_sa_quartil
FROM _index04 a
JOIN (SELECT mandant_id,
             kl_wg_id,
             kl_owg_id,
             kl_uwg_id,
             Median(index_sa_tmp) AS med_1 
      FROM _index04
      GROUP BY 1,2,3,4) b
  ON a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.mandant_id = b.mandant_id AND
     a.index_sa_tmp > b.med_1
GROUP BY 1,2,3,4) x
GROUP BY 1,2,3,4
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
      _index04.kl_owg_id = b.kl_owg_id AND
      _index04.kl_uwg_id = b.kl_uwg_id AND
      _index04.mandant_id = b.mandant_id
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
      _index04.kl_owg_id = b.kl_owg_id AND
      _index04.kl_uwg_id = b.kl_uwg_id AND
      _index04.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final 
SET index_af_id = b.index_af,
    index_sa_id = b.index_sa
	
FROM (SELECT mandant_id,
             art_id,
             MAX(index_af) as index_af,
             MAX(index_sa) as index_sa
      FROM _index04
      group by 1,2) b

WHERE _sal_snap_final.art_id = b.art_id AND
      _sal_snap_final.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_kl AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.kl_wg_id,
       c.kl_owg_id,
       c.kl_uwg_id,
       b.gtin_id,
       Count(DISTINCT x.kjmo) AS anz,
       Count(DISTINCT a.kjmo) AS anz_wochen,
       Sum(a.distr_gew)/anz_wochen AS distr_gew_,
       Sum(a.menge) AS menge_,
       Sum(a.umsatz_brutto) AS umsatz_,
       Sum(a.anz_maerkte) AS anz_maerkte,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
       Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
       Cast(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
	  FROM dbp_data.tag_1
	  GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id 
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              Rank() Over (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id > 1
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_x AS (
SELECT a.mandant_id,
       b.art_nielsen_id,
       c.kl_wg_id,
	   c.kl_owg_id,
	   c.kl_uwg_id,
	   b.gtin_id,
	   Count(DISTINCT x.kjmo) AS anz,
	   Sum(a.distr_gew)/anz AS distr_gew_,
	   Sum(a.menge) AS menge_,
	   Sum(a.umsatz_brutto) AS umsatz_,
	   Sum(a.menge_af) AS menge_af_,
	   Sum(a.umsatz_brutto_af) AS umsatz_af_,
	   Sum(a.menge_sa) AS menge_sa_,
	   Sum(a.umsatz_brutto_sa) AS umsatz_sa_,
       Sum(Cast(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
	   Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY umsatz_ DESC) AS rang_umsatz_uwg,
	   Dense_Rank() Over (PARTITION BY a.mandant_id,c.kl_owg_id ORDER BY menge_ DESC) AS rang_absatz_uwg,
	   Cast(0 AS INTEGER) AS rang_umsatz_wg
FROM dbp_data.art_nielsen_fakten_kjmo_1 a
JOIN (SELECT kjmo AS kjmo
	  FROM dbp_data.tag_1
	  GROUP BY 1) x
  ON a.kjmo = x.kjmo
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN (SELECT mandant_id,
             art_nielsen_id,
             kl_wg_id,
	     kl_owg_id,
             kl_uwg_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_1
      GROUP BY 1,2,3,4,5) c
  ON b.art_nielsen_id = c.art_nielsen_id AND
     b.mandant_id = c.mandant_id
JOIN dbp_data.nielsen_market_1 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE a.kjmo IN (SELECT x.kjmo
                 FROM (SELECT kjmo,
                              Rank() Over (ORDER BY kjmo DESC) * (-1) AS akt_mo
                       FROM dbp_data.art_nielsen_fakten_kjmo_1
                       WHERE mandant_id > 1
                       GROUP BY 1) x
                 WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 2
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_owg_1 AS (
SELECT a.mandant_id,
       a.kl_owg_id,
	   Sum(a.umsatz__) AS umsatz_x,
	   Sum(b.umsatz_kl) AS umsatz_kl_x,
	  ZeroIfNull((umsatz_kl_x/NullIfZero(umsatz_x))) * 100.00 AS marktanteil_owg
FROM (SELECT mandant_id,
             kl_owg_id,
             Sum(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
	  GROUP BY 1,2) a
JOIN (SELECT mandant_id,
             kl_owg_id,
             Sum(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
	  GROUP BY 1,2) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.mandant_id = b.mandant_id
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _kl_ma_uwg_1 AS (
SELECT a.mandant_id,
       a.kl_owg_id,
       a.kl_uwg_id,
	   Sum(a.umsatz__) AS umsatz_x,
	   Sum(b.umsatz_kl) AS umsatz_kl_x,
	   ZeroIfNull((umsatz_kl_x/NullIfZero(umsatz_x))) * 100.00 AS marktanteil_uwg
FROM (SELECT mandant_id,
             kl_owg_id,
             kl_uwg_id,
             Sum(umsatz_) AS umsatz__
      FROM _artikel_anteil_uwg_ranking_x
	  GROUP BY 1,2,3) a
JOIN (SELECT mandant_id,
             kl_owg_id,
             kl_uwg_id,
             Sum(umsatz_) AS umsatz_kl
      FROM _artikel_anteil_uwg_ranking_kl
	  GROUP BY 1,2,3) b
  ON a.kl_owg_id = b.kl_owg_id AND
     a.kl_uwg_id = b.kl_uwg_id AND
	 a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

UPDATE _sal_snap_final 
SET marktanteilbewertung = b.indexpunkt

FROM (SELECT a.mandant_id,
                                    b.kl_owg_id,
                                    b.kl_uwg_id,
	                                a.marktanteil_owg,
	                                b.marktanteil_uwg,
	                                ZeroIfNull(b.marktanteil_uwg/NullIfZero(a.marktanteil_owg)) AS indexpunkt
                             FROM _kl_ma_owg_1 a
                             JOIN _kl_ma_uwg_1 b
                               ON a.kl_owg_id = b.kl_owg_id AND
							      a.mandant_id = b.mandant_id
                             GROUP BY 1,2,3,4,5,6) b
 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      _sal_snap_final.mandant_id = b.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _preis_wg_kl AS (
SELECT a.mandant_id,
       a.kjmo,
       a.wg_id AS kl_owg_id,
       a.wug_id AS kl_uwg_id,
       Cast(a.durchschnitt_preis_kasse AS INT)+1 AS preis,
       Count(*) AS anz_artikel
FROM dbp_data.art_kl_preislage_zu_per_1  a
WHERE a.durchschnitt_preis_kasse IS NOT NULL AND
            a.kjmo IN (SELECT Max(kjmo) AS kjmo
                             FROM dbp_data.art_nielsen_fakten_kjmo_1
                             WHERE mandant_id > 1) AND
      a.mandant_id > 1 AND
     (a.kjmo,a.kjwo_update) IN (SELECT Max(kjmo) AS kjmo,Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _preis_wg_nielsen AS (
SELECT a.mandant_id,
       a.kjmo,
       a.kl_owg_id,
       a.kl_uwg_id,
       Cast(a.durchschnitt_preis_kasse AS INT)+1 AS preis,
       Count(*) AS anz_artikel
FROM dbp_data.art_nielsen_preislage_zu_per_1 a
WHERE a.durchschnitt_preis_kasse IS NOT NULL AND
     (a.mandant_id,a.kjmo,a.art_matching_id) IN (SELECT mandant_id,
	                                       kjmo,
   	                                       art_matching_id 
	                                FROM dbp_data.art_kl_preislage_zu_per_1
				                    WHERE kjmo IN (SELECT Max(kjmo) AS kjmo
                                                         FROM dbp_data.art_nielsen_fakten_kjmo_1
                                                         WHERE mandant_id > 1) AND
	                                  mandant_id > 1 AND
                                         (kjmo,kjwo_update) IN (SELECT Max(kjmo) AS kjmo,Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_1 WHERE mandant_id > 1)
                                    GROUP BY 1,2,3) AND
      a.mandant_id > 1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _preis_wg AS (
SELECT Coalesce(a.mandant_id,b.mandant_id) AS mandant_id,
       Coalesce(a.kjmo,b.kjmo) AS kjmo,
       Coalesce(a.kl_owg_id,b.kl_owg_id) AS kl_owg_id,
       Coalesce(a.kl_uwg_id,b.kl_uwg_id) AS kl_uwg_id,
       Coalesce(a.preis,b.preis) AS preis,
       CASE
         WHEN Coalesce(a.anz_artikel,0) > Coalesce(b.anz_artikel,0) THEN 3
         WHEN Coalesce(a.anz_artikel,0) < Coalesce(b.anz_artikel,0) THEN 1
         ELSE 2
       END AS preislage_id
FROM _preis_wg_kl a
FULL JOIN _preis_wg_nielsen b
  ON a.kjmo = b.kjmo AND
     a.kl_uwg_id = b.kl_uwg_id AND
     a.kl_owg_id = b.kl_owg_id AND
     a.preis = b.preis AND
     a.mandant_id = b.mandant_id
);

UPDATE _sal_snap_final 
SET preislagenverteilung = b.preislage_id

FROM (SELECT *
                             FROM _preis_wg) b
 WHERE _sal_snap_final.kl_uwg_id = b.kl_uwg_id AND
      _sal_snap_final.kl_owg_id = b.kl_owg_id AND
      Cast(_sal_snap_final.durchschnittspreis AS INT) = b.preis AND
      _sal_snap_final.mandant_id = b.mandant_id
;

UPDATE _sal_snap_final SET preislagenverteilung = 2
WHERE preislagenverteilung = 0
;

DROP TABLE IF EXISTS dbp_etl.sal_snap_final_kmo_1;
CREATE TABLE dbp_etl.sal_snap_final_kmo_1 AS (
SELECT *
FROM _sal_snap_final
);

DROP TABLE IF EXISTS dbp_etl.sal_snap2_kmo_1;
CREATE TABLE dbp_etl.sal_snap2_kmo_1 AS (
SELECT *
FROM _sal_snap_2
);

DROP TABLE IF EXISTS dbp_etl.sal_snap2_multis_1;
CREATE TABLE dbp_etl.sal_snap2_multis_1 AS (
SELECT *
FROM _sal_snap_2_multis1
);

