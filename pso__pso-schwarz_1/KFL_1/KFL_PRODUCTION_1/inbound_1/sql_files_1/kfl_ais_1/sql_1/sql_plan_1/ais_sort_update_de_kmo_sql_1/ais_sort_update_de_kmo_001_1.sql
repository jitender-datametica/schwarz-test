create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_1 where DAT_BIS='9999-12-31'
) ;


UPDATE DBP_DATA.art_nielsen_wug_zu_pflege_1 

SET art_nielsen_bez = b.art_nielsen_bez

FROM (SELECT *
      FROM _art_nielsen) b
      
WHERE DBP_DATA.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_bez <> b.art_nielsen_bez
;


UPDATE DBP_DATA.art_nielsen_wug_zu_pflege_1

SET nielsen_abteilung_bez = b.nielsen_abteilung_bez

FROM (SELECT *
      FROM _art_nielsen) b

WHERE DBP_DATA.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.nielsen_abteilung_bez <> b.nielsen_abteilung_bez
;


UPDATE DBP_DATA.art_nielsen_wug_zu_pflege_1 

SET nielsen_wg_bez = b.nielsen_wg_bez

FROM (SELECT *
      FROM _art_nielsen) b

WHERE DBP_DATA.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.nielsen_wg_bez <> b.nielsen_wg_bez
;


UPDATE DBP_DATA.art_nielsen_wug_zu_pflege_1 

SET nielsen_uwg1_bez = b.nielsen_uwg1_bez

FROM (SELECT *
      FROM _art_nielsen) b

WHERE DBP_DATA.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.nielsen_uwg1_bez <> b.nielsen_uwg1_bez
;


UPDATE DBP_DATA.art_nielsen_wug_zu_pflege_1 

SET nielsen_uwg2_bez = b.nielsen_uwg2_bez

FROM (SELECT *
      FROM _art_nielsen) b

WHERE DBP_DATA.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id AND
      DBP_DATA.art_nielsen_wug_zu_pflege.nielsen_uwg2_bez <> b.nielsen_uwg2_bez
;

UPDATE DBP_DATA.sortiment_leistung_1 

SET kl_art_id = b.kl_art_id

FROM (
SELECT matching_id,
       art_id,
       kjwo_update,
       mandant_id,
       max(LPAD(kl_art_id,8,'0')) AS kl_art_id
FROM DBP_DATA.sortiment_leistung_1
WHERE art_id IS NOT NULL AND
      POSITION(',' IN kl_art_id) = 0 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per_1)
group by 1,2,3,4
) b
 WHERE DBP_DATA.sortiment_leistung.mandant_id = b.mandant_id AND
      DBP_DATA.sortiment_leistung.art_id = b.art_id AND
      DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update
;

CREATE OR REPLACE VOLATILE TABLE _art_bez1_1 AS (
SELECT c.status_1,
       a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       CAST(a.art_bez AS VARCHAR(255)) AS art_bez_alt,
       CAST(b.art_bez AS VARCHAR(255)) AS art_bez_neu
FROM DBP_DATA.sortiment_leistung_1 a
JOIN DBP_DATA.art_spr_zu_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.spr_id = 22
JOIN (SELECT art_matching_id,
             status_1
      FROM DBP_ETL.art_matching_nielsen_per_1
      GROUP BY 1,2) c
  ON a.matching_id = c.art_matching_id
WHERE ((a.art_bez <> b.art_bez) OR
       (a.art_bez IS NULL AND
        b.art_bez IS NOT NULL)) AND
        a.mandant_id = 1 AND
        a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1) AND
        c.status_1 <> 'G'
);

INSERT INTO _art_bez1_1 (status_1
                      ,mandant_id
                      ,kjwo_update
                      ,matching_id
                      ,art_bez_alt
                      ,art_bez_neu)
SELECT 'G' AS status_1,
       a.mandant_id,
       a.kjwo_update,
       a.matching_id,
       a.art_bez AS art_bez_alt,
       c.art_gruppe_bez AS art_bez_neu
FROM DBP_DATA.sortiment_leistung_1 a
JOIN (SELECT a.art_matching_id,
             Max(c.art_gruppe_bez) AS art_gruppe_bez
      FROM DBP_ETL.art_matching_nielsen_per_1 a
      JOIN DBP_DATA.art_gruppe_art_zu_1 b
        ON a.art_id = b.art_id
      JOIN DBP_DATA.art_gruppe_1 c
        ON b.art_gruppe_id = c.art_gruppe_id
      WHERE a.status_1 = 'G'
      GROUP BY 1) c
  ON a.matching_id = c.art_matching_id
WHERE ((a.art_bez <> c.art_gruppe_bez) OR
       (a.art_bez IS NULL AND
        c.art_gruppe_bez IS NOT NULL)) AND
        a.mandant_id = 1 AND
        a.kjwo_update IN (SELECT MAX(kjwo_update) FROM DBP_DATA.art_kl_preislage_zu_per_1 WHERE mandant_id = 1)
;

UPDATE DBP_DATA.sortiment_leistung_1 
SET art_bez = b.art_bez_neu

FROM (SELECT mandant_id,
             kjwo_update,
             matching_id,
             max(art_bez_alt) as art_bez_alt,
             max(art_bez_neu) as art_bez_neu
      FROM _art_bez1_1
      group by 1,2,3) b
      
 WHERE DBP_DATA.sortiment_leistung.matching_id = b.matching_id AND
      DBP_DATA.sortiment_leistung.mandant_id = 1 AND
      DBP_DATA.sortiment_leistung.kjwo_update = b.kjwo_update AND
      COALESCE(DBP_DATA.sortiment_leistung.art_bez,'murks') = COALESCE(b.art_bez_alt,'murks')
;
