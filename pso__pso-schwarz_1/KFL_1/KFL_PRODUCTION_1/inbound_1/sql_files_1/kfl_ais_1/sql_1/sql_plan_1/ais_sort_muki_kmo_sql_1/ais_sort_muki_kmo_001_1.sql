CREATE OR REPLACE VOLATILE TABLE _track01 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.art_id,
       b.mutter_wb_id,
       b.mutter_vk_id,
       c.mutter_ek_id,
       a.status_1
FROM DBP_ETL.art_matching_nielsen_per_kmo_1 a
LEFT JOIN DBP_DATA.art_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
LEFT JOIN (SELECT mandant_id,
                  art_id,
                  mutter_ek_id
           FROM DBP_DATA.art_gp_zu_per_1
           WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
                 mandant_id = ${mandant_id}) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.art_id IS NOT NULL
);

CREATE OR REPLACE VOLATILE TABLE _track02 AS (
SELECT mandant_id,
       art_matching_id,
       SUM(CASE WHEN mutter_wb_id IS NOT NULL AND mutter_wb_id <> art_id THEN 1 ELSE 0 END) AS anz_kind_wb,
       SUM(CASE WHEN mutter_vk_id IS NOT NULL AND mutter_vk_id <> art_id THEN 1 ELSE 0 END) AS anz_kind_vk,
       SUM(CASE WHEN mutter_ek_id IS NOT NULL AND mutter_ek_id <> art_id THEN 1 ELSE 0 END) AS anz_kind_ek,
       COUNT(*) AS anzahl_artikel,
       SUM(CASE WHEN mutter_wb_id = art_id THEN 1 ELSE 0 END) AS anz_mutter_wb,
       SUM(CASE WHEN mutter_vk_id = art_id THEN 1 ELSE 0 END) AS anz_mutter_vk,
       SUM(CASE WHEN mutter_ek_id = art_id THEN 1 ELSE 0 END) AS anz_mutter_ek,
       SUM(CASE WHEN mutter_wb_id IS NULL THEN 1 ELSE 0 END) AS anz_waise_wb,
       SUM(CASE WHEN mutter_vk_id IS NULL THEN 1 ELSE 0 END) AS anz_waise_vk,
       SUM(CASE WHEN mutter_ek_id IS NULL THEN 1 ELSE 0 END) AS anz_waise_ek
FROM _track01
GROUP BY 1,2
);

UPDATE DBP_DATA.sortiment_leistung_1 SET muki_wb_kz = b.muki_wb_kz,
    muki_vk_kz = b.muki_vk_kz,
    muki_ek_kz = b.muki_ek_kz
    
FROM (
SELECT mandant_id,
       art_matching_id,
-- WBs
       CASE
         WHEN anz_kind_wb   = 0 AND
              anz_mutter_wb = 0 AND
              anz_waise_wb  > 0
         THEN 'W'
         WHEN anz_kind_wb   = 0 AND
              anz_mutter_wb > 0 AND
              anz_waise_wb  = 0 
         THEN 'M'
         WHEN anz_kind_wb   > 0 AND
              anz_mutter_wb = 0 AND
              anz_waise_wb  = 0
         THEN 'K'
         WHEN anz_kind_wb   > 0 AND
              anz_mutter_wb > 0 AND
              anz_waise_wb  = 0
         THEN 'M/K'
         WHEN anz_kind_wb   > 0 AND
              anz_mutter_wb = 0 AND
              anz_waise_wb  > 0
         THEN 'K/W'
         WHEN anz_kind_wb   = 0 AND
              anz_mutter_wb > 0 AND
              anz_waise_wb  > 0
         THEN 'M/W'  
         WHEN anz_kind_wb   > 0 AND
              anz_mutter_wb > 0 AND
              anz_waise_wb  > 0
         THEN 'M/K/W'
       END AS muki_wb_kz,
-- VKs
       CASE
         WHEN anz_kind_vk   = 0 AND
              anz_mutter_vk = 0 AND
              anz_waise_vk  > 0
         THEN 'W'
         WHEN anz_kind_vk   = 0 AND
              anz_mutter_vk > 0 AND
              anz_waise_vk  = 0 
         THEN 'M'
         WHEN anz_kind_vk   > 0 AND
              anz_mutter_vk = 0 AND
              anz_waise_vk  = 0
         THEN 'K'
         WHEN anz_kind_vk   > 0 AND
              anz_mutter_vk > 0 AND
              anz_waise_vk  = 0
         THEN 'M/K'
         WHEN anz_kind_vk   > 0 AND
              anz_mutter_vk = 0 AND
              anz_waise_vk  > 0
         THEN 'K/W'
         WHEN anz_kind_vk   = 0 AND
              anz_mutter_vk > 0 AND
              anz_waise_vk  > 0
         THEN 'M/W'  
         WHEN anz_kind_vk   > 0 AND
              anz_mutter_vk > 0 AND
              anz_waise_vk  > 0
         THEN 'M/K/W'
       END AS muki_vk_kz,
-- EKs
CASE
         WHEN anz_kind_ek   = 0 AND
              anz_mutter_ek = 0 AND
              anz_waise_ek  > 0
         THEN 'W'
         WHEN anz_kind_ek   = 0 AND
              anz_mutter_ek > 0 AND
              anz_waise_ek  = 0 
         THEN 'M'
         WHEN anz_kind_ek   > 0 AND
              anz_mutter_ek = 0 AND
              anz_waise_ek  = 0
         THEN 'K'
         WHEN anz_kind_ek   > 0 AND
              anz_mutter_ek > 0 AND
              anz_waise_ek  = 0
         THEN 'M/K'
         WHEN anz_kind_ek   > 0 AND
              anz_mutter_ek = 0 AND
              anz_waise_ek  > 0
         THEN 'K/W'
         WHEN anz_kind_ek   = 0 AND
              anz_mutter_ek > 0 AND
              anz_waise_ek  > 0
         THEN 'M/W'  
         WHEN anz_kind_ek   > 0 AND
              anz_mutter_ek > 0 AND
              anz_waise_ek  > 0
         THEN 'M/K/W'
       END AS muki_ek_kz
FROM _track02
GROUP BY 1,2,3,4,5) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

CREATE OR REPLACE VOLATILE TABLE _track03 AS (
SELECT mandant_id,
       art_matching_id,
       CASE
         WHEN mutter_wb_id = art_id
         THEN mutter_wb_id
         ELSE NULL
       END mutter_wb_id,
       CASE
         WHEN mutter_vk_id = art_id
         THEN mutter_vk_id
         ELSE NULL
       END mutter_vk_id,
       CASE
         WHEN mutter_ek_id = art_id
         THEN mutter_ek_id
         ELSE NULL
       END mutter_ek_id
FROM _track01
WHERE mutter_wb_id IS NOT NULL OR
      mutter_vk_id IS NOT NULL OR
      mutter_ek_id IS NOT NULL
GROUP BY 1,2,3,4,5
);

DELETE FROM _track03
WHERE mutter_wb_id IS NULL AND
      mutter_vk_id IS NULL AND
      mutter_ek_id IS NULL
;

UPDATE DBP_DATA.sortiment_leistung_1 SET muki_wb_kl_art_id_verkettung = b.mutter_wb_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       REPLACE(TRIM((LISTAGG(mutter_wb_id/10, ',') within group (ORDER BY mutter_wb_id) ), ','),' ', '') AS mutter_wb_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_wb_id/10 || ',' ORDER BY mutter_wb_id) (VARCHAR(10000)))),' ', '') AS mutter_wb_id
FROM _track03
WHERE mutter_wb_id IS NOT NULL
GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

UPDATE DBP_DATA.sortiment_leistung_1 SET muki_vk_kl_art_id_verkettung = b.mutter_vk_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       REPLACE(TRIM((LISTAGG(mutter_vk_id/10, ',') within group (ORDER BY mutter_vk_id) ), ','),' ', '') AS mutter_vk_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_vk_id/10 || ',' ORDER BY mutter_vk_id) (VARCHAR(10000)))),' ', '') AS mutter_vk_id
FROM _track03
WHERE mutter_vk_id IS NOT NULL
GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

UPDATE DBP_DATA.sortiment_leistung_1 SET muki_ek_kl_art_id_verkettung = b.mutter_ek_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       --mfialkiewicz
       REPLACE(TRIM((LISTAGG(mutter_ek_id/10, ',') within group (ORDER BY mutter_ek_id) ), ','),' ', '') AS mutter_ek_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_ek_id/10 || ',' ORDER BY mutter_ek_id) (VARCHAR(10000)))),' ', '') AS mutter_ek_id
FROM _track03
WHERE mutter_ek_id IS NOT NULL
GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.art_matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

CREATE OR REPLACE VOLATILE TABLE _upd_wb AS (
SELECT *
FROM DBP_DATA.art_1
WHERE mutter_wb_id IS NOT NULL AND
      mandant_id = ${mandant_id}
);

CREATE OR REPLACE VOLATILE TABLE _upd_vk AS (
SELECT *
FROM DBP_DATA.art_1
WHERE mutter_vk_id IS NOT NULL AND
      mandant_id = ${mandant_id}
);

CREATE OR REPLACE VOLATILE TABLE _upd_ek AS (
SELECT *
FROM DBP_DATA.art_gp_zu_per_1
WHERE mutter_ek_id IS NOT NULL AND
      mandant_id = ${mandant_id} AND
      dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
);

UPDATE DBP_DATA.sortiment_leistung_1 

SET muki_wb_kl_art_id_verkettung = b.mutter_wb_id
    
FROM (SELECT a.mandant_id,
             a.art_id,
             REPLACE(TRIM((LISTAGG(mutter_wb_id/10, ',') within group (ORDER BY mutter_wb_id) ), ','),' ', '') AS mutter_wb_id
      FROM DBP_DATA.sortiment_leistung_1 a
      JOIN _upd_wb b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
            a.muki_wb_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

UPDATE DBP_DATA.sortiment_leistung_1 

SET muki_vk_kl_art_id_verkettung = b.mutter_vk_id
    
FROM (SELECT a.mandant_id,
             a.art_id,
             REPLACE(TRIM((LISTAGG(b.mutter_vk_id/10, ',') within group (ORDER BY b.mutter_vk_id) ), ','),' ', '') AS mutter_vk_id
      FROM DBP_DATA.sortiment_leistung_1 a
      JOIN _upd_vk b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
            a.muki_vk_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

UPDATE DBP_DATA.sortiment_leistung_1 

SET muki_ek_kl_art_id_verkettung = b.mutter_ek_id
    
FROM (SELECT a.mandant_id,
             a.art_id,
             REPLACE(TRIM((LISTAGG(b.mutter_ek_id/10, ',') within group (ORDER BY b.mutter_ek_id) ), ','),' ', '') AS mutter_ek_id
      FROM DBP_DATA.sortiment_leistung_1 a
      JOIN _upd_ek b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
            a.muki_ek_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = ${mandant_id}) AND
      DBP_DATA.sortiment_leistung.mandant_id = ${mandant_id}
;

