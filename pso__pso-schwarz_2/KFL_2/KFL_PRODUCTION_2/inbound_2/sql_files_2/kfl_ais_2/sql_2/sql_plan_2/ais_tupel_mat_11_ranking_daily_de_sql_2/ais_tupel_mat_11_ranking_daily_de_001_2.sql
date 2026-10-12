---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   0                           --
--                                                                 --
-- Korrekte Warengruppenhierarchie fuer alle KL-Artikel.           --
--                                                                 --
---------------------------------------------------------------------

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                  art_id,
                                                  wg_id,
                                                  wug_id
                                           FROM dbp_data.art_wg_zu_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 arthiertyp_id = 2 AND
                                                 mandant_id IN (1)
                                           GROUP BY 1,2,3,4) b

SET A7_wg_id = b.wg_id,
    wug_id   = b.wug_id
	
WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.art_id = b.art_id AND
      dbp_etl_process.tupel_mat_etl.art_id <> -1 AND
     (dbp_etl_process.tupel_mat_etl.a7_wg_id <> b.wg_id OR
      dbp_etl_process.tupel_mat_etl.wug_id <> b.wug_id) AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT *
                                           FROM dbp_data.wg_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 mandant_id IN (1) AND
                                                 owg_id <> -1) b

SET a5_owg_id = b.owg_id
	
WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a7_wg_id = b.wg_id AND
      dbp_etl_process.tupel_mat_etl.art_id <> -1 AND
      dbp_etl_process.tupel_mat_etl.a5_owg_id <> b.owg_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   1                           --
--                                                                 --
-- Beruecksichtigung der Pflege des Fachbereichs.                  --
--                                                                 --
---------------------------------------------------------------------

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT a.mandant_id,
                                                  b.matching_id,
                                                  MAX(CASE WHEN a.fb_pflege_wg_id  = -1 THEN a.kalk_vorschl_wg_id  ELSE a.fb_pflege_wg_id  END) AS wg_id_neu,
                                                  MAX(CASE WHEN a.fb_pflege_wug_id = -1 THEN a.kalk_vorschl_wug_id ELSE a.fb_pflege_wug_id END) AS wug_id_neu
                                           FROM dbp_data.art_nielsen_wug_zu_pflege_2 a
                                           JOIN (SELECT mandant_id,
                                                        art_nielsen_id,
                                                        max(art_matching_id) as matching_id
                                                 from dbp_etl.art_matching_nielsen_per_2
                                                 where art_id = -1
                                                 group by 1,2) b
                                             on a.art_nielsen_id = b.art_nielsen_id and
                                                a.mandant_id = b.mandant_id
                                           WHERE a.mandant_id = 1
                                           GROUP BY 1,2) b

SET a7_wg_id = b.wg_id_neu,
    wug_id   = b.wug_id_neu

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id AND
      dbp_etl_process.tupel_mat_etl.art_id IS NULL AND
     (dbp_etl_process.tupel_mat_etl.a7_wg_id <> b.wg_id_neu OR
      dbp_etl_process.tupel_mat_etl.wug_id <> b.wug_id_neu) AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT *
                                           FROM dbp_data.wg_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 owg_id NOT IN (-1,-3) AND
                                                 mandant_id = 1) b
                                                    
SET a5_owg_id = b.owg_id
	
WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a7_wg_id = b.wg_id AND
      dbp_etl_process.tupel_mat_etl.art_id IS NULL AND
      dbp_etl_process.tupel_mat_etl.a5_owg_id <> b.owg_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   2                           --
--                                                                 --
-- Umsaetze und Co. fuer alle Artikel_2 in die SL spielen.           --
--                                                                 --
---------------------------------------------------------------------

update dbp_etl_process.tupel_mat_etl_2 set A2_rang_umsatz_wg = NULL,
                                  A59_rang_absatz_wg = NULL,
                                  A58_rang_umsatz_owg  = NULL
where a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
;

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking_1st_base AS (
SELECT a.mandant_id,
       c.art_matching_id,
       zz.a5_owg_id,
       zz.a7_wg_id,
       zz.wug_id,
       COUNT(DISTINCT c.art_nielsen_id||x.kjwo) AS anz,
       SUM(a.distr_gew)/anz AS distr_gew_,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_,
       SUM(a.menge_af) AS menge_af_,
       SUM(a.umsatz_brutto_af) AS umsatz_af_,
       SUM(a.menge_sa) AS menge_sa_,
       SUM(a.umsatz_brutto_sa) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg
FROM dbp_data.art_nielsen_fakten_kjwo_2 a
JOIN (SELECT kjwo,
             MIN(kjmo) AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjwo = x.kjwo
JOIN (SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_2
      GROUP BY 1,2,3,4
      UNION
      SELECT mandant_id,
             gtin_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl_process.matching_art_nielsen_zu_2
      WHERE (mandant_id,kjwo_update) in (select mandant_id,max(kjwo_update) as kjwo_update from dbp_data.art_kl_preislage_zu_per_2 where mandant_id = 1 group by 1)
      GROUP BY 1,2,3,4) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
JOIN dbp_etl_process.tupel_mat_etl_2 zz
  ON a.mandant_id = zz.mandant_id AND
     c.art_matching_id = zz.matching_id AND
     zz.a500_kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
WHERE a.kjwo IN (SELECT x.kjwo
                 FROM (SELECT kjwo,
                              RANK() OVER (ORDER BY kjwo DESC) * (-1) AS akt_wo
                       FROM dbp_data.art_nielsen_fakten_kjwo_2
                       WHERE mandant_id = 1
                       GROUP BY 1) x
                 WHERE akt_wo BETWEEN -52 AND -1) AND
      d.nielsen_market_cluster_id = 2 AND
      a.mandant_id = 1
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _artikel_anteil_uwg_ranking AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.a5_owg_id,
       a.a7_wg_id,
       a.wug_id,
       MAX(a.anz) AS anz,
       SUM(a.distr_gew_) AS distr_gew_,
       SUM(a.menge_) AS menge__,
       SUM(a.umsatz_) AS umsatz__,
       SUM(a.menge_af_) AS menge_af_,
       SUM(a.umsatz_af_) AS umsatz_af_,
       SUM(a.menge_sa_) AS menge_sa_,
       SUM(a.umsatz_sa_) AS umsatz_sa_,
       SUM(CAST(0 AS DECIMAL(18,4))) AS umsatz_anteil_kum_uwg,
       RANK() OVER (PARTITION BY a.a7_wg_id ORDER BY COALESCE(umsatz__,0) DESC) AS rang_umsatz_uwg,
       RANK() OVER (PARTITION BY a.a7_wg_id ORDER BY COALESCE(menge__,0) DESC) AS rang_absatz_uwg,
       CAST(0 AS INTEGER) AS rang_umsatz_wg
FROM _artikel_anteil_uwg_ranking_1st_base a
WHERE (mandant_id,art_matching_id) IN (SELECT mandant_id,matching_id FROM dbp_etl_process.tupel_mat_etl_2
                                       WHERE mandant_id = 1 AND 
                                             a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1))
GROUP BY 1,2,3,4,5
);

CREATE OR REPLACE VOLATILE TABLE _murks_2 AS (
SELECT mandant_id,
       matching_id,
       nielsen_gtin,
       a500_kjwo_update,
       A35_umsatz_nielsen,
       absatz_nielsen,
       a5_owg_id,
       a7_wg_id,
       wug_id,
       A58_rang_umsatz_owg,
       A2_rang_umsatz_wg,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_gesamt,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_anteil_uwg,
       CAST(100 AS DECIMAL(18,4)) AS umsatz_anteil_kum_uwg
FROM dbp_etl_process.tupel_mat_etl_2
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE _murks_2 FROM (SELECT mandant_id,
                           art_matching_id,
                           SUM(distr_gew_) AS distr_gew,
                           SUM(umsatz__) AS umsatz_artikel,
                           SUM(menge__) AS absatz_artikel
                    FROM _artikel_anteil_uwg_ranking
                    GROUP BY 1,2) b
                    
SET A35_umsatz_nielsen = b.umsatz_artikel,
    absatz_nielsen = b.absatz_artikel

WHERE _murks.mandant_id = b.mandant_id AND
      _murks.matching_id = b.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _gesamt_uwg AS (
SELECT a7_wg_id,
       wug_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

UPDATE _murks_2 FROM (SELECT a7_wg_id,
                           wug_id,
                           umsatz
                    FROM _gesamt_uwg
                    GROUP BY 1,2,3) b
												
SET umsatz_gesamt = b.umsatz,
    umsatz_anteil_uwg = ROUND(CAST(_murks.A35_umsatz_nielsen AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,16)    
	
WHERE _murks.wug_id = b.wug_id AND
      _murks.a7_wg_id = b.a7_wg_id
;

UPDATE _artikel_anteil_uwg_ranking FROM (SELECT a7_wg_id,
                                                wug_id,
                                                umsatz
                                         FROM _gesamt_uwg
                                         GROUP BY 1,2,3) b
												
SET umsatz_anteil_kum_uwg = ROUND(CAST(_artikel_anteil_uwg_ranking.umsatz__ AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,5)
	
WHERE _artikel_anteil_uwg_ranking.wug_id = b.wug_id AND
      _artikel_anteil_uwg_ranking.a7_wg_id = b.a7_wg_id
;

UPDATE _murks_2 FROM (SELECT art_matching_id,
                           a7_wg_id,
                           wug_id,
                           SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY a7_wg_id,wug_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
                    FROM _artikel_anteil_uwg_ranking) b
												
SET umsatz_anteil_kum_uwg = b.umsatz_anteil_kum

WHERE _murks.matching_id = b.art_matching_id AND
      _murks.wug_id = b.wug_id AND
      _murks.a7_wg_id = b.a7_wg_id
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                           matching_id,
                                           a500_kjwo_update,
                                           MAX(A35_umsatz_nielsen) AS umsatz_artikel,
                                           MAX(umsatz_anteil_uwg) AS umsatz_anteil_uwg,
                                           MAX(umsatz_anteil_kum_uwg) AS umsatz_anteil_kum_uwg,
                                           MAX(absatz_nielsen) AS absatz_artikel
                                    FROM _murks_2
                                    GROUP BY 1,2,3) b

SET A35_umsatz_nielsen = b.umsatz_artikel,
    A32_umsatz_anteil_wgi_nielsen = b.umsatz_anteil_uwg,
    A33_umsatz_anteil_wgi_kumuliert_nielsen = b.umsatz_anteil_kum_uwg,
    absatz_nielsen = b.absatz_artikel

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;
--WG level

CREATE OR REPLACE VOLATILE TABLE _murks_wg AS (
SELECT mandant_id,
       matching_id,
       nielsen_gtin,
       a500_kjwo_update,
       A35_umsatz_nielsen,
       a7_wg_id,
       CAST(0 AS DECIMAL(18,4)) AS umsatz_anteil_wg,
       CAST(100 AS DECIMAL(18,4)) AS umsatz_anteil_kum_wg
FROM dbp_etl_process.tupel_mat_etl_2
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
);

CREATE OR REPLACE VOLATILE TABLE _gesamt_wg AS (
SELECT mandant_id,
       a7_wg_id,
       SUM(umsatz__) AS umsatz
FROM _artikel_anteil_uwg_ranking
GROUP BY 1,2
);

UPDATE _murks_wg FROM (SELECT mandant_id,
                           a7_wg_id,
                           umsatz
                    FROM _gesamt_wg
                    GROUP BY 1,2,3) b
												
SET umsatz_anteil_wg = ROUND(CAST(_murks_wg.A35_umsatz_nielsen AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,16)    
	
WHERE _murks_wg.a7_wg_id = b.a7_wg_id and
      _murks_wg.mandant_id = b.mandant_id
;

UPDATE _artikel_anteil_uwg_ranking FROM (SELECT mandant_id,
                                                a7_wg_id,
                                                umsatz
                                         FROM _gesamt_wg
                                         GROUP BY 1,2,3) b
												
SET umsatz_anteil_kum_uwg = ROUND(CAST(_artikel_anteil_uwg_ranking.umsatz__ AS FLOAT)/NULLIFZERO(CAST(b.umsatz AS FLOAT))*100.00,5)
	
WHERE _artikel_anteil_uwg_ranking.a7_wg_id = b.a7_wg_id and
      _artikel_anteil_uwg_ranking.mandant_id = b.mandant_id
;

UPDATE _murks_wg FROM (SELECT mandant_id,
                           art_matching_id,
                           a7_wg_id,
                           SUM(umsatz_anteil_kum_uwg) OVER (PARTITION BY mandant_id,a7_wg_id ORDER BY rang_umsatz_uwg ROWS UNBOUNDED PRECEDING) AS umsatz_anteil_kum   
                    FROM _artikel_anteil_uwg_ranking) b
												
SET umsatz_anteil_kum_wg = b.umsatz_anteil_kum

WHERE _murks_wg.matching_id = b.art_matching_id AND
      _murks_wg.a7_wg_id = b.a7_wg_id and
      _murks_wg.mandant_id = b.mandant_id
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                           matching_id,
                                           a500_kjwo_update,
                                           MAX(umsatz_anteil_wg) AS umsatz_anteil_wg,
                                           MAX(umsatz_anteil_kum_wg) AS umsatz_anteil_kum_wg
                                    FROM _murks_wg
                                    GROUP BY 1,2,3) b

SET A519_UMSATZ_ANTEIL_WG_NIELSEN = b.umsatz_anteil_wg,
    A520_UMSATZ_ANTEIL_WG_KUMULIERT_NIELSEN = b.umsatz_anteil_kum_wg

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update = b.a500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;
---------------------------------------------------------------------
--                                                                 --
--                         P H A S E   3                           --
--                                                                 --
-- Umsaetze und Co. fuer alle Artikel_2 in die SL spielen.           --
--                                                                 --
---------------------------------------------------------------------

CREATE OR REPLACE VOLATILE TABLE _upd_rank AS (
SELECT mandant_id,
       matching_id,
       a7_wg_id,
       A35_umsatz_nielsen,
       absatz_nielsen,
       DENSE_RANK() OVER (PARTITION BY mandant_id,a7_wg_id ORDER BY mandant_id,a7_wg_id,COALESCE(A35_umsatz_nielsen,0) DESC) AS rang_umsatz_uwg_,
       DENSE_RANK() OVER (PARTITION BY mandant_id,a7_wg_id ORDER BY mandant_id,a7_wg_id,COALESCE(absatz_nielsen,0) DESC) AS rang_absatz_uwg_
FROM dbp_etl_process.tupel_mat_etl_2
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT *
                                         FROM _upd_rank) b
										 
SET A2_rang_umsatz_wg = b.rang_umsatz_uwg_,
    A59_rang_absatz_wg = b.rang_absatz_uwg_

WHERE dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank_wg AS(
SELECT mandant_id,
       matching_id,
       a5_owg_id,
       A35_umsatz_nielsen,
       DENSE_RANK() OVER (PARTITION BY mandant_id,a5_owg_id ORDER BY mandant_id,a5_owg_id,COALESCE(A35_umsatz_nielsen,0) DESC) AS rang_umsatz_wg_
FROM dbp_etl_process.tupel_mat_etl_2
WHERE a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      mandant_id = 1
);

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT *
                                         FROM _upd_rank_wg) b
										 
SET A58_rang_umsatz_owg = b.rang_umsatz_wg_

WHERE dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                a7_wg_id,
                                                MAX(A2_rang_umsatz_wg)+1 AS next_rang_ums_uwg,
                                                MAX(A59_rang_absatz_wg)+1 AS next_rang_abs_uwg
                                         FROM dbp_etl_process.tupel_mat_etl_2
                                         WHERE A2_rang_umsatz_wg IS NOT NULL AND
                                               mandant_id = 1 AND
                                               a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1,2) b
												
SET A2_rang_umsatz_wg = b.next_rang_ums_uwg,
    A59_rang_absatz_wg = b.next_rang_abs_uwg

WHERE dbp_etl_process.tupel_mat_etl.a7_wg_id = b.a7_wg_id AND
      dbp_etl_process.tupel_mat_etl.A2_rang_umsatz_wg IS NULL AND
      dbp_etl_process.tupel_mat_etl.A59_rang_absatz_wg IS NULL AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                a5_owg_id,
                                                MAX(A58_rang_umsatz_owg)+1 AS next_rang_ums_wg
                                         FROM dbp_etl_process.tupel_mat_etl_2
                                         WHERE A58_rang_umsatz_owg IS NOT NULL AND
                                               mandant_id = 1 AND
                                               a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1,2) b
												
SET A58_rang_umsatz_owg = b.next_rang_ums_wg

WHERE dbp_etl_process.tupel_mat_etl.a5_owg_id = b.a5_owg_id AND
      dbp_etl_process.tupel_mat_etl.A58_rang_umsatz_owg IS NULL AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                a7_wg_id,
                                                COALESCE(MAX(A2_rang_umsatz_wg),0)+1 AS next_rang_ums_uwg,
                                                COALESCE(MAX(A59_rang_absatz_wg),0)+1 AS next_rang_abs_uwg
                                         FROM dbp_etl_process.tupel_mat_etl_2
                                         WHERE mandant_id = 1 AND
                                              (mandant_id,a7_wg_id) IN (SELECT x.mandant_id,x.a7_wg_id
                                                                         FROM (SELECT mandant_id,
                                                                                      a7_wg_id,
                                                                                      MAX(CASE
                                                                                            WHEN A2_rang_umsatz_wg IS NULL
                                                                                            THEN 1
                                                                                            ELSE 2
                                                                                          END) AS rang_xxx
                                                                               FROM dbp_etl_process.tupel_mat_etl_2
                                                                               WHERE mandant_id = 1 AND
                                                                                     a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                                                               GROUP BY 1,2
                                                                               HAVING rang_xxx = 1) x
                                                                         GROUP BY 1,2) AND
                                               a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1,2) b
												
SET A2_rang_umsatz_wg = b.next_rang_ums_uwg,
    A59_rang_absatz_wg = b.next_rang_abs_uwg

WHERE dbp_etl_process.tupel_mat_etl.a7_wg_id = b.a7_wg_id AND
      dbp_etl_process.tupel_mat_etl.A2_rang_umsatz_wg IS NULL AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                a5_owg_id,
                                                COALESCE(MAX(A58_rang_umsatz_owg),0)+1 AS next_rang_ums_wg
                                         FROM dbp_etl_process.tupel_mat_etl_2
                                         WHERE mandant_id = 1 AND
                                               a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
                                         GROUP BY 1,2) b
												
SET A58_rang_umsatz_owg = b.next_rang_ums_wg

WHERE dbp_etl_process.tupel_mat_etl.a5_owg_id = b.a5_owg_id AND
      dbp_etl_process.tupel_mat_etl.A58_rang_umsatz_owg IS NULL AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

-------------------------------------------------------------------------------------------------------------------------------------------------------

--UPDATE dbp_etl_process.tupel_mat_etl_2 SET A36_gewichtete_distribution_nielsen = 0,
--                                         A36_gewichtete_distribution = 0
--WHERE mandant_id = 1 AND
--      a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
--      a450_art_nielsen_nr IS NULL
--;

UPDATE dbp_etl_process.tupel_mat_etl_2 SET a36_gewichtete_distribution_nielsen = a36_gewichtete_distribution_nielsen/2
WHERE a36_gewichtete_distribution_nielsen > 100 AND
      mandant_id = 1 AND
      a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
;

--UPDATE dbp_etl_process.tupel_mat_etl_2 SET a36_gewichtete_distribution = a36_gewichtete_distribution_nielsen
--WHERE mandant_id = 1 AND
--      a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1) AND
--      a36_gewichtete_distribution <> a36_gewichtete_distribution_nielsen
--;

--Update the fields related to the product groups that have been changed 


UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (select
                                 distinct
                                 KL_WG_ID,
                                 KL_OWG_ID,
                                 KL_MARKT_ANTEIL_OWG
                                 from DBP_ETL.sortiment_potenziale_2) b

SET A376_kl_marktanteil_wg_nielsen = KL_MARKT_ANTEIL_OWG 

WHERE dbp_etl_process.tupel_mat_etl.A5_OWG_ID = b.KL_WG_ID AND
      dbp_etl_process.tupel_mat_etl.A7_WG_ID = b.KL_OWG_ID AND
      dbp_etl_process.tupel_mat_etl.mandant_id = 1 AND
      dbp_etl_process.tupel_mat_etl.A500_KJWO_UPDATE = (SELECT MAX(KJWO_UPDATE) as KJWO_UPDATE FROM DBP_DATA.SORTIMENT_LEISTUNG_2 WHERE MANDANT_ID = 1) AND
      dbp_etl_process.tupel_mat_etl.A376_kl_marktanteil_wg_nielsen is not null
      ;    

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT A500_kjwo_update,
                                                  mandant_id,
                                                  A7_wg_id,
                                                  Sum(A21_kassenumsatz_kl_absolut_netto) AS kassenumsatz_kl_absolut_netto_wg,
                                                  Sum(A27_totalabschriften_wert_netto_absolut) AS totalabschriften_wert_netto_absolut_wg,
                                                  Sum(A313_preisabschriften_preisanderungen_wert_netto_absolut) AS preisabschriften_preisanderungen_wert_netto_absolut_wg
                                           FROM dbp_etl_process.tupel_mat_etl_2 where A500_KJWO_UPDATE = (SELECT MAX(KJWO_UPDATE) as KJWO_UPDATE FROM DBP_DATA.SORTIMENT_LEISTUNG_2 WHERE MANDANT_ID = 1) and mandant_id = 1
                                           GROUP BY 1,2,3) b

SET kassenumsatz_kl_absolut_netto_wg = b.kassenumsatz_kl_absolut_netto_wg,
    totalabschriften_wert_netto_absolut_wg = b.totalabschriften_wert_netto_absolut_wg,
    preisabschriften_preisanderungen_wert_netto_absolut_wg = b.preisabschriften_preisanderungen_wert_netto_absolut_wg

WHERE dbp_etl_process.tupel_mat_etl.A500_kjwo_update = b.A500_kjwo_update AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id AND
      dbp_etl_process.tupel_mat_etl.A7_wg_id = b.A7_wg_id
;


UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (SELECT mandant_id,
                                                       kjwo_update,
                                                       owg_id,
                                                       wg_id,
                                                       wug_id,
                                                       SUM(CASE
                                                             WHEN anz_maerkte_listung_gesamt IS NOT NULL AND
                                                                  anz_maerkte_listung_gesamt > 0
                                                             THEN 1
                                                             ELSE 0
                                                           END) AS anz_artikel
                                                FROM dbp_data.sortiment_leistung_2
                                                WHERE kjwo_update IN (SELECT Max(kjwo_update) FROM dbp_data.sortiment_leistung_2 where mandant_id = 1 ) and mandant_id = 1
                                                GROUP BY 1,2,3,4,5) b
                                    
SET a445_anz_tupel_listung_wgi = b.anz_artikel

WHERE dbp_etl_process.tupel_mat_etl.A5_owg_id = b.owg_id AND
      dbp_etl_process.tupel_mat_etl.A7_wg_id = b.wg_id AND
      dbp_etl_process.tupel_mat_etl.wug_id = b.wug_id AND
      dbp_etl_process.tupel_mat_etl.A500_kjwo_update = b.kjwo_update AND
      dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id
;

UPDATE dbp_etl_process.tupel_mat_etl_2 FROM (select * from dbp_data.art_nielsen_2 where dat_bis='9999-12-31' and mandant_id = 1) b
                                    
SET NIELSEN_ART_BEZ = b.ART_NIELSEN_BEZ

WHERE dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.A450_ART_NIELSEN_NR = b.art_nielsen_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per_2 WHERE mandant_id = 1)
      
;
