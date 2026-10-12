CREATE OR REPLACE VOLATILE TABLE _dup_art_1 AS (
SELECT a.mandant_id,
       a.kjwo_update,
       b.art_id,
       COUNT(DISTINCT b.art_matching_id) AS anzahl
FROM DBP_DATA.sortiment_leistung_1 a
JOIN DBP_ETL.art_matching_nielsen_per_1 b
  ON a.matching_id = b.art_matching_id AND
     a.mandant_id = b.mandant_id
WHERE a.art_id IS NOT NULL AND b.art_id <> -1 AND 
      a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1) 
GROUP BY 1,2,3
HAVING anzahl > 1
);

CREATE OR REPLACE VOLATILE TABLE _dup_art_2 AS (
SELECT a.art_matching_id AS art_matching_id_ref,
       a.art_id,
       b.matching_id AS matching_id_sort,
       b.kjwo_update,
       b.mandant_id,
       b.rang_umsatz_wg,
       a.status_1
FROM DBP_ETL.art_matching_nielsen_per_1 a
JOIN _dup_art_1 x
  ON a.art_id = x.art_id AND
     a.mandant_id = x.mandant_id
JOIN DBP_DATA.sortiment_leistung_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.matching_id AND
     x.kjwo_update = b.kjwo_update
WHERE b.art_id IS NOT NULL AND a.art_id <> -1 AND 
      b.mandant_id = 1 AND
      b.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
);

DELETE FROM _dup_art_2
WHERE (matching_id_sort,art_id) IN (
SELECT matching_id_sort,
       art_id
FROM _dup_art_2
WHERE (art_id,rang_umsatz_wg) IN (SELECT art_id,MIN(rang_umsatz_wg) AS min_rang FROM _dup_art_2 GROUP BY 1)
GROUP BY 1,2)
;

DELETE FROM DBP_DATA.sortiment_leistung_1
WHERE (mandant_id,kjwo_update,matching_id) IN (SELECT mandant_id,kjwo_update,matching_id_sort FROM _dup_art_2)
;

CREATE OR REPLACE VOLATILE TABLE _dup_art_1 AS (
SELECT a.mandant_id,
       a.kjwo_update,
       b.art_id,
       COUNT(DISTINCT b.art_matching_id) AS anzahl
FROM DBP_DATA.sortiment_leistung_1 a
JOIN DBP_ETL.art_matching_nielsen_per_1 b
  ON a.matching_id = b.art_matching_id AND
     a.mandant_id = b.mandant_id
WHERE a.art_id IS NOT NULL AND b.art_id <> -1 AND 
      a.mandant_id = 1 AND
      a.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1) 
GROUP BY 1,2,3
HAVING anzahl > 1
);

CREATE OR REPLACE VOLATILE TABLE _dup_art_2 AS (
SELECT a.art_matching_id AS art_matching_id_ref,
       a.art_id,
       b.matching_id AS matching_id_sort,
       b.kjwo_update,
       b.mandant_id,
       b.rang_umsatz_wg,
       a.status_1
FROM DBP_ETL.art_matching_nielsen_per_1 a
JOIN _dup_art_1 x
  ON a.art_id = x.art_id AND
     a.mandant_id = x.mandant_id
JOIN DBP_DATA.sortiment_leistung_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.matching_id AND
     x.kjwo_update = b.kjwo_update
WHERE b.art_id IS NOT NULL AND a.art_id <> -1 AND 
      b.mandant_id = 1 AND
      b.kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
);

DELETE FROM _dup_art_2
WHERE (matching_id_sort,art_id) IN (
SELECT matching_id_sort,
       art_id
FROM _dup_art_2
WHERE (art_id,matching_id_sort) IN (SELECT art_id,MAX(matching_id_sort) AS max_rang FROM _dup_art_2 GROUP BY 1)
GROUP BY 1,2)
;

DELETE FROM DBP_DATA.sortiment_leistung_1
WHERE (mandant_id,kjwo_update,matching_id) IN (SELECT mandant_id,kjwo_update,matching_id_sort FROM _dup_art_2)
;

