DELETE FROM DBP_DATA.sortiment_leistung
WHERE kl_owg_id NOT IN (SELECT wg_id
                        FROM DBP_DATA.wg_filter_zu
                        WHERE wg_filter_id = 47) AND
      mandant_id = ${mandant_id}
;

DELETE FROM dbp_data.sortiment_leistung
WHERE art_id IN (SELECT art_id
                 FROM dbp_data.sortiment_leistung
                 WHERE art_id IS NOT NULL AND
                       mandant_id = ${mandant_id} AND
                       kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
                 GROUP BY 1
                 HAVING COUNT(*) > 1) AND
      gtin IS NOT NULL AND
      mandant_id = ${mandant_id} AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
;

DELETE FROM dbp_data.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
                      FROM dbp_data.sortiment_leistung
                      WHERE mandant_id = ${mandant_id} AND
                            kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
                      GROUP BY 1
                      HAVING COUNT(*) > 1) AND
      gtin IS NOT NULL AND
      mandant_id = ${mandant_id} AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _dups AS (
SELECT mandant_id,
       kjwo_update,
       matching_id,
       COUNT(*) AS anz
FROM dbp_data.sortiment_leistung
WHERE mandant_id = ${mandant_id}
GROUP BY 1,2,3
HAVING COUNT(*) > 1
);

DELETE FROM dbp_data.sortiment_leistung
WHERE (mandant_id,kjwo_update,matching_id) IN (SELECT mandant_id,kjwo_update,matching_id FROM _dups) AND
       art_id IS NULL AND
       mandant_id = ${mandant_id}
;

CREATE OR REPLACE VOLATILE TABLE _upd_rang_wg AS(
SELECT a.mandant_id,
       a.matching_id,
       a.kjmo,
       a.kl_wg_id,
       Sum(Coalesce(c.total_umsatz_netto,0)) AS umsatz,
       Dense_Rank() Over (PARTITION BY a.mandant_id,a.kl_wg_id ORDER BY umsatz DESC) AS rang_umsatz_wg
FROM dbp_data.sortiment_leistung a
JOIN dbp_etl.art_matching_nielsen_per_kmo b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.art_matching_id
JOIN dbp_data.sal_kmo c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id  AND
     a.kjmo = c.kjmo
WHERE a.kjmo IN (SELECT Max(kjmo) FROM dbp_data.sortiment_leistung WHERE mandant_id = ${mandant_id} AND mandant_id NOT IN (SELECT mandant_id FROM dbp_data.art_nielsen_fakten_kjmo WHERE art_nielsen_id <> -9999999)) AND
      a.mandant_id = ${mandant_id} AND
      a.mandant_id NOT IN (SELECT mandant_id FROM dbp_data.art_nielsen_fakten_kjmo WHERE art_nielsen_id <> -9999999 GROUP BY 1) AND
      a.kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _upd_rang_uwg AS(
SELECT a.mandant_id,
       a.matching_id,
       a.kjmo,
       a.kl_owg_id,
       Sum(Coalesce(c.total_umsatz_netto,0)) AS umsatz,
       Sum(Coalesce(c.total_artbew_menge,0)) AS absatz,
       Dense_Rank() Over (PARTITION BY a.mandant_id,a.kl_owg_id ORDER BY umsatz DESC) AS rang_umsatz_uwg,
       Dense_Rank() Over (PARTITION BY a.mandant_id,a.kl_owg_id ORDER BY absatz DESC) AS rang_absatz_uwg
FROM dbp_data.sortiment_leistung a
JOIN dbp_etl.art_matching_nielsen_per_kmo b
  ON a.mandant_id = b.mandant_id AND
     a.matching_id = b.art_matching_id
JOIN dbp_data.sal_kmo c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id  AND
     a.kjmo = c.kjmo
WHERE a.kjmo IN (SELECT Max(kjmo) FROM dbp_data.sortiment_leistung WHERE mandant_id = ${mandant_id} AND mandant_id NOT IN (SELECT mandant_id FROM dbp_data.art_nielsen_fakten_kjmo WHERE art_nielsen_id <> -9999999)) AND
      a.mandant_id = ${mandant_id} AND
      a.mandant_id NOT IN (SELECT mandant_id FROM dbp_data.art_nielsen_fakten_kjmo WHERE art_nielsen_id <> -9999999 GROUP BY 1) AND
      a.kjwo_update IN (SELECT Max(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
GROUP BY 1,2,3,4
);

UPDATE dbp_data.sortiment_leistung FROM (SELECT mandant_id,
                                                              matching_id,
                                                              kjmo,
                                                              kl_wg_id,
                                                              MAX(rang_umsatz_wg) AS rang_umsatz_wg
                                                       FROM _upd_rang_wg
                                                       GROUP BY 1,2,3,4) b
										 
SET rang_umsatz_wg = b.rang_umsatz_wg

WHERE dbp_data.sortiment_leistung.kjmo = b.kjmo AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kl_wg_id = b.kl_wg_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
;

UPDATE dbp_data.sortiment_leistung FROM (SELECT mandant_id,
                                                              matching_id,
                                                              kjmo,
                                                              kl_owg_id,
                                                              MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
                                                              MAX(rang_absatz_uwg) AS rang_absatz_uwg
                                                       FROM _upd_rang_uwg
                                                       GROUP BY 1,2,3,4) b
										 
SET rang_umsatz_uwg = b.rang_umsatz_uwg,
    rang_absatz_uwg = b.rang_absatz_uwg

WHERE dbp_data.sortiment_leistung.kjmo = b.kjmo AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.kl_owg_id = b.kl_owg_id AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank AS(
SELECT mandant_id,
       matching_id,
       kjmo,
       kl_owg_id,
       rang_umsatz_uwg,
       rang_absatz_uwg,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_umsatz_uwg) AS rang_umsatz_uwg_,
       ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_absatz_uwg) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung
WHERE kjmo IN (SELECT MAX(kjmo) FROM dbp_data.sortiment_leistung WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND 
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
);

UPDATE dbp_data.sortiment_leistung FROM (SELECT *
                                                       FROM _upd_rank) b
										 
SET rang_umsatz_uwg = b.rang_umsatz_uwg_,
    rang_absatz_uwg = b.rang_absatz_uwg_

WHERE dbp_data.sortiment_leistung.kjmo = b.kjmo AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND
      dbp_data.sortiment_leistung.rang_absatz_uwg = b.rang_absatz_uwg AND
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
;

CREATE OR REPLACE VOLATILE TABLE _upd_rank_wg AS (
SELECT mandant_id,
       matching_id,
       kjmo,
       kl_wg_id,
       rang_umsatz_wg,
       ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY rang_umsatz_wg) AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung
WHERE kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      mandant_id = ${mandant_id} AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id})
);

UPDATE dbp_data.sortiment_leistung FROM (SELECT *
                                                       FROM _upd_rank_wg) b
										 
SET rang_umsatz_wg = b.rang_umsatz_wg_

WHERE dbp_data.sortiment_leistung.kjmo = b.kjmo AND 
      dbp_data.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      dbp_data.sortiment_leistung.mandant_id = b.mandant_id AND
      dbp_data.sortiment_leistung.matching_id = b.matching_id AND
      dbp_data.sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg
;

UPDATE dbp_data.sortiment_leistung SET bonreichweite_af = 0,
                                       bonreichweite_sa = 0,
                                       cherrypicker_quote = 0,
                                       restbon = 0

WHERE mandant_id = ${mandant_id} AND
     (absatz_total IS NULL OR
      absatz_total = 0) AND
     (restbon IS NOT NULL AND
      restbon <> 0) AND
      art_id IS NOT NULL
;
