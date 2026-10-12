create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

CREATE OR REPLACE VOLATILE TABLE _step1 AS (
SELECT a.mandant_id,
       a.art_id,
       a.art_nielsen_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       b.nielsen_wg_bez,
       b.nielsen_uwg1_bez,
       b.nielsen_uwg2_bez
FROM dbp_etl.art_matching_nielsen_per_kmo_2 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.mandant_id > 1 AND
      a.art_id <> -1 AND
      a.art_nielsen_id <> -1
GROUP BY 1,2,3,4,5,6,7,8,9
);

CREATE OR REPLACE VOLATILE TABLE _step2 AS (
SELECT nielsen_uwg2_bez,
       kl_wg_id,
       kl_owg_id,
       kl_uwg_id,
       Count(*) AS anz
FROM _step1
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _step3 AS (
SELECT a.*
FROM _step2 a
JOIN (SELECT nielsen_uwg2_bez,
             Max(anz) AS max_anz
      FROM _step2
      GROUP BY 1) b
  ON a.nielsen_uwg2_bez = b.nielsen_uwg2_bez AND
     a.anz = b.max_anz
);

CREATE OR REPLACE VOLATILE TABLE _step4 AS (
SELECT a.*
FROM _step3 a
JOIN (SELECT nielsen_uwg2_bez,
             Max(kl_wg_id) AS kl_wg_id
      FROM _step3
      GROUP BY 1
      HAVING Count(*) > 1) b
  ON a.nielsen_uwg2_bez = b.nielsen_uwg2_bez AND
     a.kl_wg_id = b.kl_wg_id
JOIN (SELECT nielsen_uwg2_bez,
             kl_wg_id,
             Max(kl_owg_id) AS kl_owg_id
      FROM _step3
      GROUP BY 1,2) c
  ON a.nielsen_uwg2_bez = c.nielsen_uwg2_bez AND
     a.kl_wg_id = c.kl_wg_id AND
     a.kl_owg_id = c.kl_owg_id
JOIN (SELECT nielsen_uwg2_bez,
             kl_wg_id,
             kl_owg_id,
             Max(kl_uwg_id) AS kl_uwg_id
      FROM _step3
      GROUP BY 1,2,3) d
  ON a.nielsen_uwg2_bez = d.nielsen_uwg2_bez AND
     a.kl_wg_id = d.kl_wg_id AND
     a.kl_owg_id = d.kl_owg_id AND
     a.kl_uwg_id = d.kl_uwg_id
);

DELETE FROM _step3
WHERE nielsen_uwg2_bez IN (SELECT nielsen_uwg2_bez FROM _step4)
;

INSERT INTO _step3
SELECT *
FROM _step4
;

CREATE OR REPLACE VOLATILE TABLE _pflege01 AS (
SELECT *
FROM _art_nielsen
WHERE (mandant_id,art_nielsen_id) NOT IN (SELECT mandant_id,art_nielsen_id
                                          FROM dbp_data.art_nielsen_wug_zu_pflege_2
                                          WHERE mandant_id > 1) AND
       mandant_id > 1 AND
      (mandant_id,art_nielsen_id) IN (SELECT mandant_id,
                                             art_nielsen_id
                                      FROM dbp_etl.art_matching_nielsen_per_kmo_2
                                      WHERE art_id = -1 AND
                                            mandant_id > 1)
);

CREATE OR REPLACE VOLATILE TABLE _pflege02 AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       Cast(-1 AS INTEGER) AS kl_wg_id,
       Cast(-1 AS INTEGER) AS kl_owg_id,
       Cast(-1 AS INTEGER) AS kl_uwg_id,
       a.nielsen_uwg2_bez
FROM _pflege01 a
GROUP BY 1,2,3,4,5,6
);

UPDATE _pflege02 FROM (SELECT *
                       FROM _step3) b
                       
SET kl_wg_id  = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
WHERE _pflege02.nielsen_uwg2_bez = b.nielsen_uwg2_bez
;

INSERT INTO dbp_data.art_nielsen_wug_zu_pflege_2
SELECT a.mandant_id,
       a.art_nielsen_id,
       b.art_nielsen_bez,
       -1 AS fb_pflege_wg_id,
       -1 AS fb_pflege_wug_id,
       b.nielsen_abteilung_bez,
       b.nielsen_wg_bez,
       b.nielsen_uwg1_bez,
       b.nielsen_uwg2_bez,
       a.kl_owg_id AS kalk_vorschl_wg_id,
       a.kl_uwg_id AS kalk_vorschl_wug_id,
       current_timestamp,
       current_timestamp,
       current_timestamp
FROM _pflege02 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.kl_wg_id NOT IN (0,-1,-3) AND
      a.kl_owg_id NOT IN (0,-1,-3) AND
      b.mandant_id > 1 AND
     (a.mandant_id,a.art_nielsen_id) NOT IN (SELECT mandant_id,art_nielsen_id FROM dbp_data.art_nielsen_wug_zu_pflege_2 WHERE mandant_id > 1)
;

update dbp_data.art_nielsen_wug_zu_pflege_2 from (select mandant_id,
                                                       wg_id,
                                                       min(wug_id) as wug_id
                                                from dbp_data.art_wg_zu_per_2 
                                                where arthiertyp_id = 2 and 
                                                      dat_bis = '9999-12-31' and
                                                      wug_id >= 0
                                                group by 1,2) b
                                                
set kalk_vorschl_wug_id = b.wug_id

where dbp_data.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id and
      dbp_data.art_nielsen_wug_zu_pflege.kalk_vorschl_wg_id = b.wg_id and
     (dbp_data.art_nielsen_wug_zu_pflege.mandant_id,dbp_data.art_nielsen_wug_zu_pflege.kalk_vorschl_wg_id,dbp_data.art_nielsen_wug_zu_pflege.kalk_vorschl_wug_id) not in (select mandant_id,wg_id,wug_id from dbp_data.art_wg_zu_per_2 where arthiertyp_id = 2 and dat_bis = '9999-12-31')
;
