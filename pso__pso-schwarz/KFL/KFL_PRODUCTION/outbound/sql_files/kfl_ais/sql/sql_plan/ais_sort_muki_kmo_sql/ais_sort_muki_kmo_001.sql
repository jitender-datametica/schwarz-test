CREATE OR REPLACE TEMPORARY TABLE _track01 AS
SELECT A.mandant_id,
 A.art_matching_id,
 A.art_id,
 B.mutter_wb_id,
 B.mutter_vk_id,
 c.mutter_ek_id,
 A.status
FROM dbp_etl.art_matching_nielsen_per_kmo AS A
 LEFT JOIN dbp_data.art AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
 LEFT JOIN (SELECT mandant_id,
   art_id,
   mutter_ek_id
  FROM dbp_data.art_gp_zu_per
  WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
   AND mandant_id = ${mandant_id}) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
WHERE A.art_id IS NOT NULL;




CREATE OR REPLACE TEMPORARY TABLE _track02 AS
SELECT mandant_id,
 art_matching_id,
 SUM(CASE
   WHEN mutter_wb_id IS NOT NULL AND mutter_wb_id <> art_id
   THEN 1
   ELSE 0
   END) AS anz_kind_wb,
 SUM(CASE
   WHEN mutter_vk_id IS NOT NULL AND mutter_vk_id <> art_id
   THEN 1
   ELSE 0
   END) AS anz_kind_vk,
 SUM(CASE
   WHEN mutter_ek_id IS NOT NULL AND mutter_ek_id <> art_id
   THEN 1
   ELSE 0
   END) AS anz_kind_ek,
 COUNT(*) AS anzahl_artikel,
 SUM(CASE
   WHEN mutter_wb_id = art_id
   THEN 1
   ELSE 0
   END) AS anz_mutter_wb,
 SUM(CASE
   WHEN mutter_vk_id = art_id
   THEN 1
   ELSE 0
   END) AS anz_mutter_vk,
 SUM(CASE
   WHEN mutter_ek_id = art_id
   THEN 1
   ELSE 0
   END) AS anz_mutter_ek,
 SUM(CASE
   WHEN mutter_wb_id IS NULL
   THEN 1
   ELSE 0
   END) AS anz_waise_wb,
 SUM(CASE
   WHEN mutter_vk_id IS NULL
   THEN 1
   ELSE 0
   END) AS anz_waise_vk,
 SUM(CASE
   WHEN mutter_ek_id IS NULL
   THEN 1
   ELSE 0
   END) AS anz_waise_ek
FROM `_track01`
GROUP BY mandant_id,
 art_matching_id;



UPDATE dbp_data.sortiment_leistung SET
 muki_wb_kz = b.muki_wb_kz,
 muki_vk_kz = b.muki_vk_kz,
 muki_ek_kz = b.muki_ek_kz FROM (SELECT mandant_id,
   art_matching_id,
    CASE
    WHEN anz_kind_wb = 0 AND anz_mutter_wb = 0 AND anz_waise_wb > 0
    THEN 'W'
    WHEN anz_kind_wb = 0 AND anz_mutter_wb > 0 AND anz_waise_wb = 0
    THEN 'M'
    WHEN anz_kind_wb > 0 AND anz_mutter_wb = 0 AND anz_waise_wb = 0
    THEN 'K'
    WHEN anz_kind_wb > 0 AND anz_mutter_wb > 0 AND anz_waise_wb = 0
    THEN 'M/K'
    WHEN anz_kind_wb > 0 AND anz_mutter_wb = 0 AND anz_waise_wb > 0
    THEN 'K/W'
    WHEN anz_kind_wb = 0 AND anz_mutter_wb > 0 AND anz_waise_wb > 0
    THEN 'M/W'
    WHEN anz_kind_wb > 0 AND anz_mutter_wb > 0 AND anz_waise_wb > 0
    THEN 'M/K/W'
    ELSE NULL
    END AS muki_wb_kz,
    CASE
    WHEN anz_kind_vk = 0 AND anz_mutter_vk = 0 AND anz_waise_vk > 0
    THEN 'W'
    WHEN anz_kind_vk = 0 AND anz_mutter_vk > 0 AND anz_waise_vk = 0
    THEN 'M'
    WHEN anz_kind_vk > 0 AND anz_mutter_vk = 0 AND anz_waise_vk = 0
    THEN 'K'
    WHEN anz_kind_vk > 0 AND anz_mutter_vk > 0 AND anz_waise_vk = 0
    THEN 'M/K'
    WHEN anz_kind_vk > 0 AND anz_mutter_vk = 0 AND anz_waise_vk > 0
    THEN 'K/W'
    WHEN anz_kind_vk = 0 AND anz_mutter_vk > 0 AND anz_waise_vk > 0
    THEN 'M/W'
    WHEN anz_kind_vk > 0 AND anz_mutter_vk > 0 AND anz_waise_vk > 0
    THEN 'M/K/W'
    ELSE NULL
    END AS muki_vk_kz,
    CASE
    WHEN anz_kind_ek = 0 AND anz_mutter_ek = 0 AND anz_waise_ek > 0
    THEN 'W'
    WHEN anz_kind_ek = 0 AND anz_mutter_ek > 0 AND anz_waise_ek = 0
    THEN 'M'
    WHEN anz_kind_ek > 0 AND anz_mutter_ek = 0 AND anz_waise_ek = 0
    THEN 'K'
    WHEN anz_kind_ek > 0 AND anz_mutter_ek > 0 AND anz_waise_ek = 0
    THEN 'M/K'
    WHEN anz_kind_ek > 0 AND anz_mutter_ek = 0 AND anz_waise_ek > 0
    THEN 'K/W'
    WHEN anz_kind_ek = 0 AND anz_mutter_ek > 0 AND anz_waise_ek > 0
    THEN 'M/W'
    WHEN anz_kind_ek > 0 AND anz_mutter_ek > 0 AND anz_waise_ek > 0
    THEN 'M/K/W'
    ELSE NULL
    END AS muki_ek_kz
  FROM `_track02`
  GROUP BY mandant_id,
   art_matching_id,
   muki_wb_kz,
   muki_vk_kz,
   muki_ek_kz) AS b
WHERE sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
   sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) AS a1290333724
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}) AND sortiment_leistung.mandant_id = ${mandant_id};




CREATE OR REPLACE TEMPORARY TABLE _track03 AS
SELECT mandant_id,
 art_matching_id,
  CASE
  WHEN mutter_wb_id = art_id
  THEN mutter_wb_id
  ELSE NULL
  END AS mutter_wb_id,
  CASE
  WHEN mutter_vk_id = art_id
  THEN mutter_vk_id
  ELSE NULL
  END AS mutter_vk_id,
  CASE
  WHEN mutter_ek_id = art_id
  THEN mutter_ek_id
  ELSE NULL
  END AS mutter_ek_id
FROM `_track01`
WHERE mutter_wb_id IS NOT NULL
 OR mutter_vk_id IS NOT NULL
 OR mutter_ek_id IS NOT NULL
GROUP BY mandant_id,
 art_matching_id,
 mutter_wb_id,
 mutter_vk_id,
 mutter_ek_id;



DELETE FROM `_track03`
WHERE mutter_wb_id IS NULL AND mutter_vk_id IS NULL AND mutter_ek_id IS NULL;




UPDATE dbp_data.sortiment_leistung SET muki_wb_kl_art_id_verkettung = b.mutter_wb_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       REPLACE(TRIM(
      STRING_AGG(CAST(mutter_wb_id / 10 AS STRING), ',' ORDER BY mutter_wb_id),
       ','), 
      ' ', ''
    ) AS mutter_wb_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_wb_id/10 || ',' ORDER BY mutter_wb_id) (STRING(10000)))),' ', '') AS mutter_wb_id
FROM _track03
WHERE mutter_wb_id IS NOT NULL
GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.matching_id = b.art_matching_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;



UPDATE dbp_data.sortiment_leistung SET muki_vk_kl_art_id_verkettung = b.mutter_vk_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       REPLACE(TRIM(
      STRING_AGG(CAST(mutter_vk_id / 10 AS STRING), ',' ORDER BY mutter_vk_id),
       ','), 
      ' ', ''
    )        AS mutter_vk_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_vk_id/10 || ',' ORDER BY mutter_vk_id) (STRING(10000)))),' ', '') AS mutter_vk_id
FROM _track03
WHERE mutter_vk_id IS NOT NULL
GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.matching_id = b.art_matching_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;



UPDATE dbp_data.sortiment_leistung SET muki_ek_kl_art_id_verkettung = b.mutter_ek_id
    
FROM (
SELECT mandant_id,
       art_matching_id,
       --mfialkiewicz
        REPLACE(TRIM(
      STRING_AGG(CAST(mutter_ek_id / 10 AS STRING), ',' ORDER BY mutter_ek_id),
       ','), 
      ' ', ''
    )       AS mutter_ek_id
       --OTRANSLATE(TRIM(TRAILING ',' FROM (XMLAGG(mutter_ek_id/10 || ',' ORDER BY mutter_ek_id) (STRING(10000)))),' ', '') AS mutter_ek_id
FROM _track03
WHERE mutter_ek_id IS NOT NULL
GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.matching_id = b.art_matching_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;



CREATE OR REPLACE TEMPORARY TABLE _upd_wb AS
SELECT *
FROM dbp_data.art
WHERE mutter_wb_id IS NOT NULL
 AND mandant_id = ${mandant_id};


CREATE OR REPLACE TEMPORARY TABLE _upd_vk AS
SELECT *
FROM dbp_data.art
WHERE mutter_vk_id IS NOT NULL
 AND mandant_id = ${mandant_id};


CREATE OR REPLACE TEMPORARY TABLE _upd_ek AS
SELECT *
FROM dbp_data.art_gp_zu_per
WHERE mutter_ek_id IS NOT NULL
 AND mandant_id = ${mandant_id}
 AND dat_bis = PARSE_DATE('%F', '9999-12-31');



UPDATE dbp_data.sortiment_leistung 

SET muki_wb_kl_art_id_verkettung = b.mutter_wb_id
    
FROM (SELECT a.mandant_id,
             a.art_id,

               REPLACE(TRIM(
      STRING_AGG(CAST(mutter_wb_id / 10 AS STRING), ',' ORDER BY mutter_wb_id),
       ','), 
      ' ', ''
    )             AS mutter_wb_id
      FROM dbp_data.sortiment_leistung a
      JOIN _upd_wb b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
            a.muki_wb_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.art_id = b.art_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;




UPDATE dbp_data.sortiment_leistung 

SET muki_vk_kl_art_id_verkettung = b.mutter_vk_id
    
FROM (SELECT a.mandant_id,
             a.art_id,
             REPLACE(TRIM(
      STRING_AGG(CAST(mutter_vk_id / 10 AS STRING), ',' ORDER BY mutter_vk_id),
       ','), 
      ' ', ''
    )                          AS mutter_vk_id
      FROM dbp_data.sortiment_leistung a
      JOIN _upd_vk b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
            a.muki_vk_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.art_id = b.art_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;



UPDATE dbp_data.sortiment_leistung 

SET muki_ek_kl_art_id_verkettung = b.mutter_ek_id
    
FROM (SELECT a.mandant_id,
             a.art_id,

              REPLACE(TRIM(
      STRING_AGG(CAST(mutter_ek_id / 10 AS STRING), ',' ORDER BY mutter_ek_id),
       ','), 
      ' ', ''
    )              AS mutter_ek_id
      FROM dbp_data.sortiment_leistung a
      JOIN _upd_ek b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.mandant_id = ${mandant_id} AND
            a.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
            a.muki_ek_kl_art_id_verkettung IS NULL
      GROUP BY 1,2) b

WHERE sortiment_leistung.mandant_id = b.mandant_id AND
      sortiment_leistung.art_id = b.art_id AND
      sortiment_leistung.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_data.art_kl_preislage_zu_per WHERE mandant_id = ${mandant_id}) AND
      sortiment_leistung.mandant_id = ${mandant_id}
;
