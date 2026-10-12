DELETE FROM dbp_data.sortiment_leistung_2
WHERE mandant_id = ${mandant_id} AND kl_owg_id NOT IN (SELECT wg_id
   FROM dbp_data.wg_filter_zu_2
   WHERE wg_filter_id = 47);


DELETE FROM dbp_data.sortiment_leistung_2
WHERE art_id IN (SELECT art_id
     FROM dbp_data.sortiment_leistung_2
     WHERE art_id IS NOT NULL
      AND mandant_id = ${mandant_id}
      AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = ${mandant_id})
     GROUP BY art_id
     HAVING COUNT(*) > 1) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = ${mandant_id}) AND gtin IS NOT NULL;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE matching_id IN (SELECT matching_id
     FROM dbp_data.sortiment_leistung_2
     WHERE mandant_id = ${mandant_id}
      AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per_2
        WHERE mandant_id = ${mandant_id})
     GROUP BY matching_id
     HAVING COUNT(*) > 1) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per_2
    WHERE mandant_id = ${mandant_id}) AND gtin IS NOT NULL;


CREATE OR REPLACE TEMPORARY TABLE _dups_2 AS
SELECT mandant_id,
 kjwo_update,
 matching_id,
 COUNT(*) AS anz
FROM dbp_data.sortiment_leistung_2
WHERE mandant_id = ${mandant_id}
GROUP BY mandant_id,
 matching_id,
 kjwo_update
HAVING anz > 1;


DELETE FROM dbp_data.sortiment_leistung_2
WHERE (mandant_id, kjwo_update, matching_id) IN (SELECT (mandant_id, kjwo_update, matching_id)
    FROM `_dups_2`) AND art_id IS NULL AND mandant_id = ${mandant_id};


CREATE OR REPLACE TEMPORARY TABLE _upd_rang_wg AS
SELECT A.mandant_id,
 A.matching_id,
 A.kjmo,
 A.kl_wg_id,
 SUM(COALESCE(C.total_umsatz_netto, 0)) AS umsatz,
 DENSE_RANK() OVER (PARTITION BY A.mandant_id, A.kl_wg_id ORDER BY SUM(COALESCE(C.total_umsatz_netto, 0)) IS NULL DESC,
    SUM(COALESCE(C.total_umsatz_netto, 0)) DESC) AS rang_umsatz_wg
FROM dbp_data.sortiment_leistung_2 AS A
 INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_2 AS B ON A.mandant_id = B.mandant_id AND A.matching_id =
   B.art_matching_id
 INNER JOIN dbp_data.sal_kmo_2 AS C ON A.mandant_id = C.mandant_id AND B.art_id = C.art_id AND A.kjmo = C.kjmo
   
WHERE A.kjmo IN (SELECT MAX(kjmo)
   FROM dbp_data.sortiment_leistung_2
   WHERE mandant_id = ${mandant_id}
    AND mandant_id NOT IN (SELECT mandant_id
      FROM dbp_data.art_nielsen_fakten_kjmo_2
      WHERE art_nielsen_id <> - 9999999))
 AND A.mandant_id = ${mandant_id}
 AND A.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id})
 AND A.mandant_id NOT IN (SELECT mandant_id
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE art_nielsen_id <> - 9999999
   GROUP BY mandant_id)
GROUP BY A.mandant_id,
 A.matching_id,
 A.kjmo,
 A.kl_wg_id;


CREATE OR REPLACE TEMPORARY TABLE _upd_rang_uwg AS
SELECT A.mandant_id,
 A.matching_id,
 A.kjmo,
 A.kl_owg_id,
 SUM(COALESCE(C.total_umsatz_netto, 0)) AS umsatz,
 SUM(COALESCE(C.total_artbew_menge, 0)) AS absatz,
 DENSE_RANK() OVER (PARTITION BY A.mandant_id, A.kl_owg_id ORDER BY SUM(COALESCE(C.total_umsatz_netto, 0)) IS NULL DESC
    , SUM(COALESCE(C.total_umsatz_netto, 0)) DESC) AS rang_umsatz_uwg,
 DENSE_RANK() OVER (PARTITION BY A.mandant_id, A.kl_owg_id ORDER BY SUM(COALESCE(C.total_artbew_menge, 0)) IS NULL DESC
    , SUM(COALESCE(C.total_artbew_menge, 0)) DESC) AS rang_absatz_uwg
FROM dbp_data.sortiment_leistung_2 AS A
 INNER JOIN dbp_etl.art_matching_nielsen_per_kmo_2 AS B ON A.mandant_id = B.mandant_id AND A.matching_id =
   B.art_matching_id
 INNER JOIN dbp_data.sal_kmo_2 AS C ON A.mandant_id = C.mandant_id AND B.art_id = C.art_id AND A.kjmo = C.kjmo
   
WHERE A.kjmo IN (SELECT MAX(kjmo)
   FROM dbp_data.sortiment_leistung_2
   WHERE mandant_id = ${mandant_id}
    AND mandant_id NOT IN (SELECT mandant_id
      FROM dbp_data.art_nielsen_fakten_kjmo_2
      WHERE art_nielsen_id <> - 9999999))
 AND A.mandant_id = ${mandant_id}
 AND A.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id})
 AND A.mandant_id NOT IN (SELECT mandant_id
   FROM dbp_data.art_nielsen_fakten_kjmo_2
   WHERE art_nielsen_id <> - 9999999
   GROUP BY mandant_id)
GROUP BY A.mandant_id,
 A.matching_id,
 A.kjmo,
 A.kl_owg_id;


UPDATE dbp_data.sortiment_leistung_2 SET
 rang_umsatz_wg = b.rang_umsatz_wg FROM (SELECT mandant_id,
   matching_id,
   kjmo,
   kl_wg_id,
   MAX(rang_umsatz_wg) AS rang_umsatz_wg
  FROM `_upd_rang_wg`
  GROUP BY mandant_id,
   matching_id,
   kjmo,
   kl_wg_id) AS b
WHERE sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.matching_id = b.matching_id AND sortiment_leistung.mandant_id
     = b.mandant_id AND sortiment_leistung.kl_wg_id = b.kl_wg_id AND sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update
     ) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id});


UPDATE dbp_data.sortiment_leistung_2 SET
 rang_umsatz_uwg = b.rang_umsatz_uwg,
 rang_absatz_uwg = b.rang_absatz_uwg FROM (SELECT mandant_id,
   matching_id,
   kjmo,
   kl_owg_id,
   MAX(rang_umsatz_uwg) AS rang_umsatz_uwg,
   MAX(rang_absatz_uwg) AS rang_absatz_uwg
  FROM `_upd_rang_uwg`
  GROUP BY mandant_id,
   matching_id,
   kjmo,
   kl_owg_id) AS b
WHERE sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.matching_id = b.matching_id AND sortiment_leistung.mandant_id
     = b.mandant_id AND sortiment_leistung.kl_owg_id = b.kl_owg_id AND sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update
     ) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id});


CREATE OR REPLACE TEMPORARY TABLE _upd_rank AS
SELECT mandant_id,
 matching_id,
 kjmo,
 kl_owg_id,
 rang_umsatz_uwg,
 rang_absatz_uwg,
 ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_umsatz_uwg IS NULL, rang_umsatz_uwg) AS rang_umsatz_uwg_,
 ROW_NUMBER() OVER (PARTITION BY kl_owg_id ORDER BY rang_absatz_uwg IS NULL, rang_absatz_uwg) AS rang_absatz_uwg_
FROM dbp_data.sortiment_leistung_2
WHERE kjmo IN (SELECT MAX(kjmo) AS a1886105636
   FROM dbp_data.sortiment_leistung_2
   WHERE mandant_id = ${mandant_id})
 AND mandant_id = ${mandant_id}
 AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id});


UPDATE dbp_data.sortiment_leistung_2 SET
 rang_umsatz_uwg = b.rang_umsatz_uwg_,
 rang_absatz_uwg = b.rang_absatz_uwg_ FROM `_upd_rank` AS b
WHERE sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id
      = b.matching_id AND sortiment_leistung.rang_umsatz_uwg = b.rang_umsatz_uwg AND sortiment_leistung.rang_absatz_uwg
   = b.rang_absatz_uwg AND sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id});


CREATE OR REPLACE TEMPORARY TABLE _upd_rank_wg AS
SELECT mandant_id,
 matching_id,
 kjmo,
 kl_wg_id,
 rang_umsatz_wg,
 ROW_NUMBER() OVER (PARTITION BY kl_wg_id ORDER BY rang_umsatz_wg IS NULL, rang_umsatz_wg) AS rang_umsatz_wg_
FROM dbp_data.sortiment_leistung_2
WHERE kjwo_update IN (SELECT MAX(kjwo_update) AS a1290333724
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id})
 AND mandant_id = ${mandant_id}
 AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per_2
   WHERE mandant_id = ${mandant_id});


UPDATE dbp_data.sortiment_leistung_2 SET
 rang_umsatz_wg = b.rang_umsatz_wg_ FROM `_upd_rank_wg` AS b
WHERE sortiment_leistung.kjmo = b.kjmo AND sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS a1290333724
      FROM dbp_data.art_kl_preislage_zu_per_2
      WHERE mandant_id = ${mandant_id}) AND sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id
    = b.matching_id AND sortiment_leistung.rang_umsatz_wg = b.rang_umsatz_wg;


UPDATE dbp_data.sortiment_leistung_2 SET
 bonreichweite_af = 0,
 bonreichweite_sa = 0,
 cherrypicker_quote = 0,
 restbon = 0
WHERE mandant_id = ${mandant_id} AND (absatz_total IS NULL OR absatz_total = 0) AND restbon <> 0 AND art_id IS NOT NULL;