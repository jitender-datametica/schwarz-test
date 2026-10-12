--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.art_matching_nielsen_per_1 
SET kl_owg_id = b.wg_id_neu,
    kl_uwg_id = b.wug_id_neu
	
FROM (SELECT mandant_id,
                                                                    art_nielsen_id,
                                                                    CASE WHEN wg_id  = -1 THEN wg_id_vorschl  ELSE wg_id  END AS wg_id_neu,
                                                                    CASE WHEN wug_id = -1 THEN wug_id_vorschl ELSE wug_id END AS wug_id_neu
                                                             FROM DBP_DATA.art_nielsen_wug_zu_pflege_1
                                                             WHERE mandant_id = 1) b
 WHERE DBP_ETL.art_matching_nielsen_per.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per.art_nielsen_id = b.art_nielsen_id AND
      DBP_ETL.art_matching_nielsen_per.art_id = -1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.art_matching_nielsen_per_1 
SET kl_wg_id = b.owg_id
	
FROM (SELECT *
                                                             FROM DBP_DATA.wg_per_1
                                                             WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
                                                                   owg_id <> -1) b
 WHERE DBP_ETL.art_matching_nielsen_per.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per.kl_owg_id = b.wg_id
;

CREATE OR REPLACE VOLATILE TABLE _upd_stable_xxx AS (
SELECT mandant_id,
       art_matching_id,
       COUNT(DISTINCT kl_wg_id) AS anz1,
       COUNT(DISTINCT kl_owg_id) AS anz2,
       COUNT(DISTINCT kl_uwg_id) AS anz3
FROM DBP_ETL.art_matching_nielsen_per_1
GROUP BY 1,2
HAVING anz1 > 1 OR anz2 > 1 OR anz3 > 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.art_matching_nielsen_per_1 
SET kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       MAX(a.kl_owg_id) AS kl_owg_id,
       MIN(a.kl_uwg_id) AS kl_uwg_id
FROM DBP_ETL.art_matching_nielsen_per_1 a
JOIN _upd_stable_xxx b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
WHERE b.anz2 > 1 OR b.anz3 > 1
GROUP BY 1,2
) b
 WHERE DBP_ETL.art_matching_nielsen_per.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per.art_matching_id = b.art_matching_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.art_matching_nielsen_per_1 
SET kl_wg_id = b.owg_id
	
FROM (SELECT *
                                                             FROM DBP_DATA.wg_per_1
                                                             WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
                                                                   owg_id NOT IN (-1,-3) AND
                                                                   mandant_id = 1) b
 WHERE DBP_ETL.art_matching_nielsen_per.mandant_id = b.mandant_id AND
      DBP_ETL.art_matching_nielsen_per.kl_owg_id = b.wg_id
;

