create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31' 
) ;

delete from dbp_etl.art_matching_nielsen_per_kmo_final_2 where (mandant_id,art_nielsen_id,gtin_id) in (select distinct mandant_id,art_nielsen_id,gtin_id from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2) ;

delete from dbp_etl.art_matching_nielsen_per_kmo_final_2 where (mandant_id,art_id,gtin_id) in (select distinct mandant_id,art_id,gtin_id from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2) ;


insert into dbp_etl.art_matching_nielsen_per_kmo_final_2 
select * from dbp_etl.art_matching_nielsen_per_kmo_mgtin_2 ;

EXECUTE IMMEDIATE $$
BEGIN
  LET loop_counter1 INTEGER := (select 1);
  LET loop_counter2 INTEGER := (select 1);
  LET loop_counter3 INTEGER := (select 1);
  LET loop_counter_value INTEGER := 0;
  
  WHILE ((loop_counter1+loop_counter2+loop_counter3) > 0) DO
    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_nielsen_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where art_nielsen_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id ;
    
    loop_counter1 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));

    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               art_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where art_id <> -1
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id ;

    loop_counter2 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               max(art_matching_id) as art_matching_id,
                                                               gtin_id
                                                        from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                        where gtin_id not in (-9999,-9998)
                                                        group by 1,3
                                                        having count(distinct art_matching_id) > 1) b
                                  
    set art_matching_id = b.art_matching_id

    where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
          dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id ;

    loop_counter3 := (SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())));
    
    loop_counter_value := loop_counter_value + 1;
  END WHILE;

RETURN loop_counter_value;

END;
$$
;

create or replace volatile table _trash as 
(
select * from dbp_etl.art_matching_nielsen_per_kmo_final_2 
where (mandant_id,ART_MATCHING_ID,art_id,gtin_id) in (select mandant_id,ART_MATCHING_ID,art_id,gtin_id from dbp_etl.art_matching_nielsen_per_kmo_final_2 group by 1,2,3,4 
having count (distinct art_nielsen_id) > 1 and SUM(CASE WHEN art_nielsen_id = -1 THEN 1 ELSE 0 END) > 0 )
order by MANDANT_ID,ART_MATCHING_ID
);

delete from dbp_etl.art_matching_nielsen_per_kmo_final_2 where (mandant_id,ART_MATCHING_ID,art_id,art_nielsen_id,gtin_id) in 
(
select distinct mandant_id,ART_MATCHING_ID,art_id,art_nielsen_id,gtin_id from _trash where art_nielsen_id = -1
) ;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT mandant_id,
                                                  art_id,
                                                  wg_id,
                                                  wug_id
                                           FROM dbp_data.art_wg_zu_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 arthiertyp_id = 2 AND
                                                 mandant_id > 1
                                           GROUP BY 1,2,3,4) b

SET kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id <> -1 AND
     (dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id <> b.wg_id OR
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_uwg_id <> b.wug_id)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT *
                                                  FROM dbp_data.wg_per_2
                                                  WHERE dat_bis = '9999-12-31' AND
                                                        mandant_id > 1 AND
                                                        owg_id <> -1) b

SET kl_wg_id = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id <> -1 AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_wg_id <> b.owg_id
;

-- 03.02.2019, -dbay-
--
-- Warengruppenhierarchie fuer Matchings ueber alle Ebenen sauber
-- hinstellen!

-- 1. OWG
CREATE OR REPLACE VOLATILE TABLE _track_distinct AS (
SELECT mandant_id,
       art_matching_id,
       Count(*) AS anz,
       Count(DISTINCT kl_wg_id) AS anz_wg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2
HAVING Count(DISTINCT kl_wg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       Min(a.kl_wg_id) AS kl_wg_id,
       Min(a.kl_owg_id) AS kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct2
      WHERE kl_wg_id <> -3
      GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl
WHERE a.kl_wg_id <> -3
GROUP BY 1,2
) x

SET kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

-- 2. WG
CREATE OR REPLACE VOLATILE TABLE _track_distinct_owg_1 AS (
SELECT mandant_id,
       art_matching_id,
       kl_wg_id,
       Count(*) AS anz,
       Count(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2,3
HAVING Count(DISTINCT kl_owg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct_owg_2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct_owg_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       Min(a.kl_owg_id) AS kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct_owg_2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             kl_wg_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct_owg_2
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl AND
     a.kl_wg_id = b.kl_wg_id
WHERE a.kl_owg_id <> -3
GROUP BY 1,2,3) x

SET kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

-- 3. WGI
CREATE OR REPLACE VOLATILE TABLE _track_distinct_uwg_1 AS (
SELECT mandant_id,
       art_matching_id,
       kl_wg_id,
       kl_owg_id,
       Count(*) AS anz,
       Count(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2,3,4
HAVING Count(DISTINCT kl_uwg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct_uwg_2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct_uwg_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct_uwg_2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct_uwg_2
      WHERE kl_uwg_id <> -3
      GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl AND
     a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id
WHERE a.kl_uwg_id <> -3
GROUP BY 1,2,3,4) x

SET kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

-- 03.02.2019, -dbay-
--
-- Warengruppen von BI gepflegt muessen hier angezogen werden.

CREATE OR REPLACE VOLATILE TABLE _sort_pflege_fehler AS (
SELECT a.*
FROM dbp_data.art_nielsen_wug_zu_pflege_2 a
LEFT JOIN (SELECT a.mandant_id,
             a.wg_id
      FROM dbp_data.wg_per_2 a
      JOIN dbp_data.wg_filter_zu_2 wfz
        ON a.wg_id = wfz.wg_id AND 
           a.mandant_id = wfz.mandant_id AND 
           wfz.wg_filter_id = 11 AND 
           wfz.arthiertyp_id = 2
      GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.fb_pflege_wg_id = b.wg_id
WHERE b.wg_id IS NULL AND
      a.kalk_vorschl_wg_id <> -1
);

UPDATE dbp_data.art_nielsen_wug_zu_pflege_2 FROM (SELECT *
                                                FROM _sort_pflege_fehler) b

SET fb_pflege_wg_id = -1,
    fb_pflege_wug_id = -1
    
WHERE dbp_data.art_nielsen_wug_zu_pflege.mandant_id = b.mandant_id AND
      dbp_data.art_nielsen_wug_zu_pflege.art_nielsen_id = b.art_nielsen_id
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT mandant_id,
                                                         art_nielsen_id,
                                                         CASE WHEN fb_pflege_wg_id  = -1 THEN kalk_vorschl_wg_id  ELSE fb_pflege_wg_id  END AS wg_id_neu,
                                                         CASE WHEN fb_pflege_wug_id = -1 THEN kalk_vorschl_wug_id ELSE fb_pflege_wug_id END AS wug_id_neu
                                                  FROM dbp_data.art_nielsen_wug_zu_pflege_2) b

SET kl_owg_id = b.wg_id_neu,
    kl_uwg_id = b.wug_id_neu
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id  AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id = -1
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT *
                                                  FROM dbp_data.wg_per_2
                                                  WHERE dat_bis = '9999-12-31' AND
                                                        owg_id > 0) b

SET kl_wg_id = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id
;

CREATE OR REPLACE VOLATILE TABLE _potenzial_hier AS (
SELECT mandant_id,
       art_matching_id,
       gtin_id,
       Max(kl_wg_id) AS kl_wg_id,
       Max(kl_owg_id) AS kl_owg_id,
       Max(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
WHERE (mandant_id,gtin_id) IN (SELECT mandant_id,
                                      gtin_id
                               FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
                               WHERE art_id = -1 AND
                                     gtin_id NOT IN (-9999,-9998)
                               GROUP BY 1,2
                               HAVING Count(*) > 1)
GROUP BY 1,2,3
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT *
                                                  FROM _potenzial_hier) b
                                              
SET kl_wg_id  = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = b.art_matching_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;

-- 31.05.2019, -dbay-
--
-- An dieser Stelle wird das Listungskennzeichen platziert. 

update dbp_etl.art_matching_nielsen_per_kmo_final_2
set list_kz = NULL 
where
kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2) ;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT distinct mandant_id
                                                        ,art_id
                                                        ,list_kz
                                                             FROM dbp_etl.kl_basis_listung_kmo_2 where list_kz in ('A','B')
                                                             ) b
                                  
SET list_kz = b.list_kz

WHERE dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT distinct *
                                                             FROM dbp_etl.kl_basis_listung_kmo_2 where ART_NIELSEN_ID is null
                                                             ) b
                                  
SET list_kz = b.list_kz

WHERE dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and 
      dbp_etl.art_matching_nielsen_per_kmo_final.list_kz is null and 
      dbp_etl.art_matching_nielsen_per_kmo_final.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT distinct *
                                                             FROM dbp_etl.kl_basis_listung_kmo_2 where ART_NIELSEN_ID is not null
                                                             ) b
                                  
SET list_kz = b.list_kz

WHERE dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id and 
      dbp_etl.art_matching_nielsen_per_kmo_final.list_kz is null AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

--for products that are not occur in listing tables

CREATE OR REPLACE VOLATILE TABLE _artikel_nielsen_agg AS (
SELECT a.mandant_id,
       c.art_nielsen_id,
       SUM(a.menge) AS menge_,
       SUM(a.umsatz_brutto) AS umsatz_
FROM dbp_data.art_nielsen_fakten_kjmo_2 a
JOIN (SELECT kjmo AS kjmo
      FROM dbp_data.tag_2
      GROUP BY 1) x
  ON a.kjmo = x.kjmo
  JOIN (SELECT mandant_id,
             art_nielsen_id,
             art_matching_id
      FROM dbp_etl.art_matching_nielsen_per_kmo_2 where art_nielsen_id >-1 
      GROUP BY 1,2,3) c
  ON a.mandant_id = c.mandant_id AND
     a.art_nielsen_id = c.art_nielsen_id 
JOIN dbp_data.nielsen_market_2 d
  ON a.mandant_id = d.mandant_id AND
     a.nielsen_market_id = d.nielsen_market_id
WHERE (a.mandant_id,a.kjmo) IN (SELECT x.mandant_id,
                                       x.kjmo
                                FROM (SELECT mandant_id,
                                             kjmo,
                                             RANK() OVER (PARTITION BY mandant_id ORDER BY mandant_id,kjmo DESC) * (-1) AS akt_mo
                                      FROM dbp_data.art_nielsen_fakten_kjmo_2
                                      WHERE mandant_id > 1
                                      GROUP BY 1,2) x
                                WHERE akt_mo BETWEEN -12 AND -1) AND
      d.nielsen_market_cluster_id = 1 AND
      a.mandant_id > 1
GROUP BY 1,2
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select distinct mandant_id,art_id,art_nielsen_id from dbp_etl.art_matching_nielsen_per_kmo_final_2 where list_kz = 'D2' and ART_NIELSEN_ID<>-1 
                                                      and (mandant_id,art_nielsen_id) in ( select distinct mandant_id,art_nielsen_id from _artikel_nielsen_agg))b
set 
LIST_KZ = 'D1'
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.art_nielsen_id = b.art_nielsen_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2
SET
LIST_KZ = 'D2'
WHERE
LIST_KZ is NULL and ART_ID <> -1 and ART_NIELSEN_ID = -1 and 
kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
 ;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2
SET
LIST_KZ = 'D2'
WHERE
LIST_KZ is NULL and ART_ID <> -1 and ART_NIELSEN_ID <> -1 AND kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;


-- correct state settings, only differentiated between 'N' (regular) and 'T' (tupel)
  
update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select    mandant_id,
                                                                  art_matching_id,
                                                           count(distinct case when art_id = -1 then null else art_id end) as anz_art,
                                                           count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen
                                                    from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                    where mandant_id in (2,3,5,7,8)
                                                    group by 1,2
                                                    having (anz_art = 0 and
                                                            anz_art_nielsen = 1) or
                                                           (anz_art = 1 and
                                                            anz_art_nielsen = 0) or
                                                           (anz_art = 1 and
                                                            anz_art_nielsen = 1)) b

  set status_2 = 'N'

where dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id
;
  
update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select mandant_id,
                                                               art_matching_id,
                                                           count(distinct case when art_id = -1 then null else art_id end) as anz_art,
                                                           count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen
                                                    from dbp_etl.art_matching_nielsen_per_kmo_final_2
                                                    where mandant_id in (2,3,5,7,8)
                                                    group by 1,2
                                                    having anz_art > 1) b
set status_2 = 'T'

where dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = b.art_matching_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id
;

-- That's it --

CREATE OR REPLACE VOLATILE TABLE _upd_stable_xxx AS (
SELECT mandant_id,
       art_matching_id,
       Count(DISTINCT kl_wg_id) AS anz1,
       Count(DISTINCT kl_owg_id) AS anz2,
       Count(DISTINCT kl_uwg_id) AS anz3
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2
HAVING anz1 > 1 OR anz2 > 1 OR anz3 > 1
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       Max(a.kl_owg_id) AS kl_owg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _upd_stable_xxx b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
WHERE b.anz2 > 1 
GROUP BY 1,2
) b

SET kl_owg_id = b.kl_owg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = b.art_matching_id
;


UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _upd_stable_xxx b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
WHERE b.anz3 > 1 and a.kl_uwg_id > 0
GROUP BY 1,2
) b

SET kl_uwg_id = b.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = b.art_matching_id
;



UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT *
                                                  FROM dbp_data.wg_per_2
                                                  WHERE dat_bis = '9999-12-31' AND
                                                        owg_id NOT IN (-1,-3) AND
                                                        mandant_id > 1) b

SET kl_wg_id = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT mandant_id,
                                                  art_id,
                                                  wg_id,
                                                  wug_id
                                           FROM dbp_data.art_wg_zu_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 arthiertyp_id = 2 AND
                                                 mandant_id > 1
                                           GROUP BY 1,2,3,4) b

SET kl_owg_id = b.wg_id,
    kl_uwg_id = b.wug_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id <> -1 AND
     (dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id <> b.wg_id OR
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_uwg_id <> b.wug_id)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (SELECT *
                                                  FROM dbp_data.wg_per_2
                                                  WHERE dat_bis = '9999-12-31' AND
                                                        mandant_id > 1 AND
                                                        owg_id <> -1) b

SET kl_wg_id = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_owg_id = b.wg_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id <> -1 AND
      dbp_etl.art_matching_nielsen_per_kmo_final.kl_wg_id <> b.owg_id
;


--
CREATE OR REPLACE VOLATILE TABLE _track_distinct AS (
SELECT mandant_id,
       art_matching_id,
       Count(*) AS anz,
       Count(DISTINCT kl_wg_id) AS anz_wg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 
GROUP BY 1,2
HAVING Count(DISTINCT kl_wg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       Min(a.kl_wg_id) AS kl_wg_id,
       Min(a.kl_owg_id) AS kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct2
      WHERE kl_wg_id <> -3
      GROUP BY 1,2) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl
WHERE a.kl_wg_id <> -3
GROUP BY 1,2
) x

SET kl_wg_id = x.kl_wg_id,
    kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

-- 2. WG
CREATE OR REPLACE VOLATILE TABLE _track_distinct_owg_1 AS (
SELECT mandant_id,
       art_matching_id,
       kl_wg_id,
       Count(*) AS anz,
       Count(DISTINCT kl_owg_id) AS anz_owg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2,3
HAVING Count(DISTINCT kl_owg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct_owg_2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct_owg_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       Min(a.kl_owg_id) AS kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct_owg_2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             kl_wg_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct_owg_2
      WHERE kl_owg_id <> -3
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl AND
     a.kl_wg_id = b.kl_wg_id
WHERE a.kl_owg_id <> -3
GROUP BY 1,2,3) x

SET kl_owg_id = x.kl_owg_id,
    kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

-- 3. WGI
CREATE OR REPLACE VOLATILE TABLE _track_distinct_uwg_1 AS (
SELECT mandant_id,
       art_matching_id,
       kl_wg_id,
       kl_owg_id,
       Count(*) AS anz,
       Count(DISTINCT kl_uwg_id) AS anz_uwg
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
GROUP BY 1,2,3,4
HAVING Count(DISTINCT kl_uwg_id) > 1
);

CREATE OR REPLACE VOLATILE TABLE _track_distinct_uwg_2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       a.kl_uwg_id,
       Count(*) AS anzahl
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2 a
JOIN _track_distinct_uwg_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id
where a.art_id <> -1
GROUP BY 1,2,3,4,5
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_final_2 FROM (
SELECT a.mandant_id,
       a.art_matching_id,
       a.kl_wg_id,
       a.kl_owg_id,
       Min(a.kl_uwg_id) AS kl_uwg_id
FROM _track_distinct_uwg_2 a
JOIN (SELECT mandant_id,
             art_matching_id,
             kl_wg_id,
             kl_owg_id,
             Max(anzahl) AS anzahl
      FROM _track_distinct_uwg_2
      WHERE kl_uwg_id <> -3
      GROUP BY 1,2,3,4) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.anzahl = b.anzahl AND
     a.kl_wg_id = b.kl_wg_id AND
     a.kl_owg_id = b.kl_owg_id
WHERE a.kl_uwg_id <> -3 
GROUP BY 1,2,3,4) x

SET kl_uwg_id = x.kl_uwg_id
    
WHERE dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = x.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id = x.art_matching_id
;

CREATE OR REPLACE VOLATILE TABLE _kill_dups AS (
SELECT mandant_id,
       art_nielsen_id,
       Count(DISTINCT art_matching_id) AS anz,
       Min(art_matching_id) AS min_match,
       Min(status_2) AS min_status,
       Max(status_2) AS max_status
FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
WHERE art_nielsen_id <> -1
GROUP BY 1,2
HAVING anz > 1
);

DELETE FROM dbp_etl.art_matching_nielsen_per_kmo_final_2
WHERE (mandant_id,art_nielsen_id,art_matching_id) IN (SELECT mandant_id,art_nielsen_id,min_match FROM _kill_dups)
;

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (
select mandant_id,
       art_id,
       count(distinct art_matching_id) as anz_match,
       max(art_matching_id) as max_match,
       min(art_matching_id) as min_match,
       min(status_2) as min_status,
       max(status_2) as max_status
from dbp_etl.art_matching_nielsen_per_kmo_final_2
where art_id <> -1
group by 1,2
having anz_match > 1
) b

set art_matching_id = b.max_match,
    status_2 = max_status

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.art_id = b.art_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.art_matching_id <> b.max_match
;

create or replace volatile table _xxx as (
select mandant_id,
       gtin_id,
       count(distinct art_matching_id) as anz_match,
       count(distinct case when art_id = -1 then null else art_id end) as anz_art_id,
       count(distinct case when art_nielsen_id = -1 then null else art_nielsen_id end) as anz_art_nielsen_id,
       min(art_matching_id) as min_match,
       max(art_matching_id) as max_match,
       min(art_id) as min_art,
       max(art_id) as max_art,
       min(art_nielsen_id) as min_art_nielsen,
       max(art_nielsen_id) as max_art_nielsen
from dbp_etl.art_matching_nielsen_per_kmo_final_2
where gtin_id not in (-9999,-9998)
group by 1,2
having anz_match > 1
);

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select *
                                                  from _xxx
                                                  where anz_art_id = 0 and
                                                        anz_art_nielsen_id = 1) b
                                                        
set art_matching_id = b.min_match,
    status_2 = 'N',
    art_nielsen_id = min_art_nielsen

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;
                                                  
delete from _xxx
where anz_art_id = 0 and
      anz_art_nielsen_id = 1
;

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select *
                                                  from _xxx
                                                  where anz_art_id = 0) b
                                                        
set art_matching_id = b.min_match,
    status_2 = 'N'

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;

delete from _xxx
where anz_art_id = 0
;

create or replace volatile table _distinct_recs as (
select  a.mandant_id
,min(a.art_matching_id) art_matching_id
,max(a.art_id) art_id
,max(a.art_nielsen_id) art_nielsen_id
,a.gtin_id
,max(a.kl_art_kat_id) kl_art_kat_id
,max(a.kl_wg_id     ) kl_wg_id
,max(a.kl_owg_id    ) kl_owg_id
,max(a.kl_uwg_id    ) kl_uwg_id
,max(a.umrech_faktor) umrech_faktor
,max(a.status_2       ) status_2
,max(a.list_kz      ) list_kz
,max(a.komponente_fg) komponente_fg
,max(a.kjwo_update  ) kjwo_update
,max(a.td_insert    ) td_insert
,max(a.td_update    ) td_update
from dbp_etl.art_matching_nielsen_per_kmo_final_2 a
where (a.mandant_id,a.gtin_id) in (select mandant_id,gtin_id from _xxx where anz_art_id = 1 and anz_art_nielsen_id = 1 and min_art = -1 and min_art_nielsen = -1)
group by 1,5
);

delete from dbp_etl.art_matching_nielsen_per_kmo_final_2
where (mandant_id,gtin_id) in (select mandant_id,gtin_id from _xxx where anz_art_id = 1 and anz_art_nielsen_id = 1 and min_art = -1 and min_art_nielsen = -1)
;

insert into dbp_etl.art_matching_nielsen_per_kmo_final_2
select *
from _distinct_recs
;

delete from _xxx 
where anz_art_id = 1 and 
      anz_art_nielsen_id = 1 and 
      min_art = -1 and 
      min_art_nielsen = -1
;

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select *
                                                  from _xxx
                                                  where anz_art_id = 1) b
                                                        
set art_matching_id = b.min_match,
    status_2 = 'N',
    art_id = max_art

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;

delete from _xxx
where anz_art_id = 1
;

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select *
                                                  from _xxx
                                                  where anz_art_nielsen_id = 1 and
                                                        anz_art_id > 1) b
                                                        
set art_matching_id = b.min_match,
    status_2 = 'T',
    art_nielsen_id = b.max_art_nielsen

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;

delete from _xxx
where anz_art_nielsen_id = 1 and
      anz_art_id > 1
;

update dbp_etl.art_matching_nielsen_per_kmo_final_2 from (select *
                                                  from _xxx
                                                  where anz_art_id > 1) b
                                                        
set art_matching_id = b.min_match,
    status_2 = 'T'

where dbp_etl.art_matching_nielsen_per_kmo_final.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo_final.gtin_id = b.gtin_id
;

delete from _xxx
where anz_art_nielsen_id = 1 and
      anz_art_id > 1
;

create or replace volatile table _ek_sort_art_matching_zu_kmo_tmp (
  mandant_id byteint,
  art_matching_id number(38,0),
  kombi_art_id varchar(5000),
  kombi_art_nielsen_id varchar(5000),
  kombi_gtin_id varchar(5000),
  dat_von date,
  dat_bis date
);

insert into _ek_sort_art_matching_zu_kmo_tmp
select mandant_id,
       art_matching_id,
       substr(replace(trim((listagg(cast(cast(cast(art_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(art_id)) ), ','),' ', ''),1,5000) as art_id,
       substr(replace(trim((listagg(cast(cast(cast(art_nielsen_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(art_nielsen_id)) ), ','),' ', ''),1,5000) as art_nielsen_id,
       substr(replace(trim((listagg(cast(cast(cast(gtin_id as varchar(600)) as decimal(38,0)) as varchar(38)), ',') within group (order by floor(gtin_id)) ), ','),' ', ''),1,5000) as gtin_id,
       '1900-01-01',
       '9999-12-31'
from dbp_etl.art_matching_nielsen_per_kmo_final_2
group by 1,2
;

update dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO_2 from (select mandant_id,
                                                            art_matching_id
                                                     from dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO_2
                                                     where (mandant_id,art_matching_id) not in (select mandant_id,art_matching_id from _ek_sort_art_matching_zu_kmo_tmp) and
                                                            dat_bis = '9999-12-31') b
                                                     
set dat_bis = current_date-1

where dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.mandant_id = b.mandant_id and
      dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.art_matching_id = b.art_matching_id and
      dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.dat_bis = '9999-12-31'
;

create or replace volatile table _changes as (
select a.*
from dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO_2 a
left join _ek_sort_art_matching_zu_kmo_tmp b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id and
     a.kombi_art_id = b.kombi_art_id and
     a.kombi_art_nielsen_id = b.kombi_art_nielsen_id
where b.dat_von is null and
      a.dat_bis = '9999-12-31'
);

create or replace volatile table _news as (
select *
from _ek_sort_art_matching_zu_kmo_tmp
where (mandant_id,art_matching_id) in (select mandant_id,art_matching_id from _changes)
);

update dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO_2 from (select *
                                                     from _changes) b
                                                           
set dat_bis = current_date-1

where dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.mandant_id = b.mandant_id and
      dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.art_matching_id = b.art_matching_id and
      dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO.dat_bis = '9999-12-31'
;

insert into dbp_etl_process.EK_SORT_ART_MATCHING_ZU_KMO_2 (mandant_id,
                                                     art_matching_id,
                                                     kombi_art_id,
                                                     kombi_art_nielsen_id,
                                                     kombi_gtin_id,
                                                     dat_von,
                                                     dat_bis)
select mandant_id,
       art_matching_id,
       kombi_art_id,
       kombi_art_nielsen_id,
       kombi_gtin_id,
       current_date as dat_von,
       '9999-12-31' as dat_bis
from _news
;

--- final exchange

--- 1st: keeping the old, useleass records for frontend purpose
insert into dbp_etl.art_matching_nielsen_per_kmo_olds_2
select *
from dbp_etl.art_matching_nielsen_per_kmo_2
where (mandant_id,art_matching_id) not in (select mandant_id,art_matching_id from dbp_etl.art_matching_nielsen_per_kmo_final_2)
;

--- maintenance
delete from dbp_etl.art_matching_nielsen_per_kmo_olds_2
where kjwo_update not in (select kjwo from dbp_data.woche_2 where akt_wo between -6 and 1)
;

--- 2nd: new registration
delete from dbp_etl.art_matching_nielsen_per_kmo_2;
insert into dbp_etl.art_matching_nielsen_per_kmo_2
select *
from dbp_etl.art_matching_nielsen_per_kmo_final_2
;

create or replace volatile table _schrott as (
select mandant_id,
art_matching_id,
count(distinct case when art_id <> -1 then art_id else null end) as anz_art
from dbp_etl.art_matching_nielsen_per_kmo_2
where kl_owg_id = 0
group by 1,2
having anz_art >= 1
);

UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT a.mandant_id,
a.art_id,
a.wg_id,
a.wug_id
FROM dbp_data.art_wg_zu_per_2 a
WHERE dat_bis = '9999-12-31' AND
arthiertyp_id = 2 AND
mandant_id > 1 and
(a.mandant_id,a.art_id) in (select mandant_id,art_id
from dbp_etl.art_matching_nielsen_per_kmo_2
where (mandant_id,art_matching_id) in (select mandant_id,art_matching_id from _schrott))
GROUP BY 1,2,3,4) b
SET kl_owg_id = b.wg_id,
kl_uwg_id = b.wug_id
WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
dbp_etl.art_matching_nielsen_per_kmo.art_id = b.art_id AND
dbp_etl.art_matching_nielsen_per_kmo.art_id <> -1 AND
(dbp_etl.art_matching_nielsen_per_kmo.kl_owg_id <> b.wg_id OR
dbp_etl.art_matching_nielsen_per_kmo.kl_uwg_id <> b.wug_id)
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT *
FROM dbp_data.wg_per_2
WHERE dat_bis = '9999-12-31' AND
mandant_id > 1 AND
owg_id <> -1) b
SET kl_wg_id = b.owg_id
WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
dbp_etl.art_matching_nielsen_per_kmo.kl_owg_id = b.wg_id AND
dbp_etl.art_matching_nielsen_per_kmo.art_id <> -1 AND
dbp_etl.art_matching_nielsen_per_kmo.kl_wg_id <> b.owg_id
;

-- correct product groups before transformation

-- 1. external matching using wg_filter_id = 47 to get the most best fitting product group

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(d.owg_id) as kl_wg_id,
       max(c.wg_id) as kl_owg_id,
       min(c.wug_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo_2 a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo_2
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
join dbp_data.art_wg_zu_per_2 c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id and
     c.dat_bis = '9999-12-31' and
     c.arthiertyp_id = 2
join dbp_data.wg_per_2 d
  on a.mandant_id = d.mandant_id and
     c.wg_id = d.wg_id and
     d.arthiertyp_id = 2 and
     d.dat_bis = '9999-12-31'
where c.wg_id in (select wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 47 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo_2 from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;

-- 2. internal matching using wg_filter_id = 47

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo_2 a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo_2
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
where a.kl_owg_id in (select wg_id from dbp_data.wg_filter_zu_2 where wg_filter_id = 47 group by 1)
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo_2 from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;

-- 3. maybe useless, but you never know...last scan with all product groups

create or replace volatile table _track_distinct as (
select a.mandant_id,
       a.art_matching_id,
       max(a.kl_wg_id) as kl_wg_id,
       max(a.kl_owg_id) as kl_owg_id,
       min(a.kl_uwg_id) as kl_uwg_id
from dbp_etl.art_matching_nielsen_per_kmo_2 a
join (select mandant_id,
             art_matching_id
      from dbp_etl.art_matching_nielsen_per_kmo_2
      group by 1,2
      having count(distinct kl_wg_id)  > 1 or
             count(distinct kl_owg_id) > 1 or
             count(distinct kl_uwg_id) > 1) b
  on a.mandant_id = b.mandant_id and
     a.art_matching_id = b.art_matching_id
group by 1,2
);

update dbp_etl.art_matching_nielsen_per_kmo_2 from (select mandant_id,
                                                         art_matching_id,
                                                         kl_wg_id,
                                                         kl_owg_id,
                                                         kl_uwg_id
                                                  from _track_distinct) b
                                                     
set kl_wg_id = b.kl_wg_id,
    kl_owg_id = b.kl_owg_id,
    kl_uwg_id = b.kl_uwg_id
    
where dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id and
      dbp_etl.art_matching_nielsen_per_kmo.art_matching_id = b.art_matching_id
;


----

------loading of dbp_data.art_nielsen_art_wg_zu_2

delete from dbp_data.art_nielsen_art_wg_zu_2
where (mandant_id,kjwo) in (select mandant_id,max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2 group by 1) ;

insert into dbp_data.art_nielsen_art_wg_zu_2 (mandant_id,art_nielsen_id,art_id,kjwo,wg_id,wug_id,td_update,td_insert)
select distinct a.mandant_id,a.art_nielsen_id,b.art_id,b.kjwo_update,-1,-1,current_timestamp,current_timestamp from dbp_data.art_nielsen_2 a
join
dbp_etl.art_matching_nielsen_per_kmo_2 b
on
a.mandant_id = b.mandant_id and
a.art_nielsen_id = b.art_nielsen_id
where a.dat_bis='9999-12-31' and b.art_nielsen_id <> -1 and b.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2) ;

insert into dbp_data.art_nielsen_art_wg_zu_2 (mandant_id,art_nielsen_id,art_id,kjwo,wg_id,wug_id,td_update,td_insert)
select distinct mandant_id,art_nielsen_id,art_id,kjwo_update,-1,-1,current_timestamp,current_timestamp from 
dbp_etl.art_matching_nielsen_per_kmo_2 
where art_nielsen_id = -1 and art_id > -1 and kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2) ;

--lvl_4
update dbp_data.art_nielsen_art_wg_zu_2 from (select * from dbp_data.art_nielsen_wug_zu_pflege_2 where mandant_id > 1)b

set
wg_id = b.kalk_vorschl_wg_id,
wug_id = b.kalk_vorschl_wug_id,
WG_QUELLE_BEZ = 'vorschl_dwh',
WG_QUELLE_HIERARCHIE_LVL_ID = 4

where
dbp_data.art_nielsen_art_wg_zu.mandant_id = b.mandant_id and
dbp_data.art_nielsen_art_wg_zu.art_nielsen_id =b.art_nielsen_id and
dbp_data.art_nielsen_art_wg_zu.art_id = -1 and
dbp_data.art_nielsen_art_wg_zu.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2);

--lvl_3
update dbp_data.art_nielsen_art_wg_zu_2 from (select * from dbp_data.art_nielsen_2 where dat_bis='9999-12-31' and mandant_id > 1 and NIELSEN_VORSCHL_WG_ID is not null and NIELSEN_VORSCHL_WUG_ID is not null )b

set
wg_id = b.nielsen_vorschl_wg_id,
wug_id = b.nielsen_vorschl_wug_id,
WG_QUELLE_BEZ = 'vorschl_nielsen',
WG_QUELLE_HIERARCHIE_LVL_ID = 3

where
dbp_data.art_nielsen_art_wg_zu.mandant_id = b.mandant_id and
dbp_data.art_nielsen_art_wg_zu.art_nielsen_id =b.art_nielsen_id and
dbp_data.art_nielsen_art_wg_zu.art_id = -1 and
dbp_data.art_nielsen_art_wg_zu.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2);

--lvl_2
update dbp_data.art_nielsen_art_wg_zu_2 from (select * from dbp_data.art_nielsen_wug_zu_pflege_2 where fb_pflege_wg_id > -1)b

set
wg_id = b.fb_pflege_wg_id,
wug_id = b.fb_pflege_wug_id,
WG_QUELLE_BEZ = 'fb_pflege',
WG_QUELLE_HIERARCHIE_LVL_ID = 2

where
dbp_data.art_nielsen_art_wg_zu.mandant_id = b.mandant_id and
dbp_data.art_nielsen_art_wg_zu.art_nielsen_id =b.art_nielsen_id and
dbp_data.art_nielsen_art_wg_zu.art_id = -1 and
dbp_data.art_nielsen_art_wg_zu.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2);

--lvl_1
update dbp_data.art_nielsen_art_wg_zu_2 from (select * from dbp_data.art_wg_zu_per_2 where dat_bis='9999-12-31' and mandant_id > 1 and  ARTHIERTYP_ID = 2)b

set
wg_id = b.wg_id,
wug_id = b.wug_id,
WG_QUELLE_BEZ = 'kaufland_article',
WG_QUELLE_HIERARCHIE_LVL_ID = 1

where
dbp_data.art_nielsen_art_wg_zu.mandant_id = b.mandant_id and
dbp_data.art_nielsen_art_wg_zu.art_id = b.art_id and 
dbp_data.art_nielsen_art_wg_zu.art_id <> -1 and
dbp_data.art_nielsen_art_wg_zu.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2);

create or replace volatile table _art_nielsen_category_match_1 as
(
select distinct b.art_matching_id,a.* from dbp_data.art_nielsen_art_wg_zu_2 a
join dbp_etl.art_matching_nielsen_per_kmo_2 b
on
 a.mandant_id = b.mandant_id and
 a.art_id = b.art_id and
 a.art_nielsen_id = b.art_nielsen_id 
where 
  b.kjwo_update in (select max(kjwo_update) from dbp_etl.art_matching_nielsen_per_kmo_2) and
  a.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2)
);

create or replace volatile table _art_nielsen_category_match_2 as
(
select * from _art_nielsen_category_match_1 where (mandant_id,art_matching_id) in
(select distinct mandant_id,art_matching_id from _art_nielsen_category_match_1 where wg_id=-1 and wug_id=-1)
);

update _art_nielsen_category_match_1 from (select mandant_id,art_matching_id,max(wg_id) as wg_id, max(wug_id) as wug_id 
                                                        from _art_nielsen_category_match_2 group by 1,2) b
set
wg_id = b.wg_id,
wug_id = b.wug_id
where
_art_nielsen_category_match_1.mandant_id = b.mandant_id and
_art_nielsen_category_match_1.art_matching_id =b.art_matching_id;

--lvl_5
update dbp_data.art_nielsen_art_wg_zu_2 from (select * from _art_nielsen_category_match_1 where mandant_id > 1 and wg_id<>-1 and wug_id<>-1 )b

set
wg_id = b.wg_id,
wug_id = b.wug_id,
WG_QUELLE_BEZ = 'from matching_id',
WG_QUELLE_HIERARCHIE_LVL_ID = 5

where
dbp_data.art_nielsen_art_wg_zu.mandant_id = b.mandant_id and
dbp_data.art_nielsen_art_wg_zu.art_nielsen_id =b.art_nielsen_id and
dbp_data.art_nielsen_art_wg_zu.art_id = b.art_id and
dbp_data.art_nielsen_art_wg_zu.wg_id = -1 and
dbp_data.art_nielsen_art_wg_zu.wug_id = -1 and
dbp_data.art_nielsen_art_wg_zu.kjwo in (select max(kjwo) from dbp_data.art_nielsen_art_wg_zu_2);


--update dbp_etl.art_matching_nielsen_per_kmo_2
--art_id > 0
UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT DISTINCT MANDANT_ID,ART_ID,WG_ID,WUG_ID,KJWO FROM dbp_data.art_nielsen_art_wg_zu_2 
                                           where ART_ID <> -1 and kjwo in (SELECT MAX(kjwo) FROM dbp_data.art_nielsen_art_wg_zu_2)) b

SET KL_OWG_ID = b.wg_id,
    KL_UWG_ID   = b.wug_id

WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo.art_id = b.art_id AND
      dbp_etl.art_matching_nielsen_per_kmo.kjwo_update = b.kjwo
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT *
                                           FROM dbp_data.wg_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 mandant_id > 1 AND
                                                 owg_id <> -1) b

SET KL_WG_ID = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo.KL_OWG_ID = b.wg_id AND
      dbp_etl.art_matching_nielsen_per_kmo.art_id <> -1 AND
      dbp_etl.art_matching_nielsen_per_kmo.KL_WG_ID <> b.owg_id AND
      dbp_etl.art_matching_nielsen_per_kmo.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_etl.art_matching_nielsen_per_kmo_2)
;

--art_id = -1
UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT * FROM dbp_data.art_nielsen_art_wg_zu_2 
                                           where ART_ID = -1 AND kjwo in (SELECT MAX(kjwo) FROM dbp_data.art_nielsen_art_wg_zu_2)) b

SET KL_OWG_ID = b.wg_id,
    KL_UWG_ID   = b.wug_id

WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo.art_nielsen_id = b.ART_NIELSEN_ID AND
      dbp_etl.art_matching_nielsen_per_kmo.art_id = -1 AND 
      dbp_etl.art_matching_nielsen_per_kmo.kjwo_update = b.kjwo 
;

UPDATE dbp_etl.art_matching_nielsen_per_kmo_2 FROM (SELECT *
                                           FROM dbp_data.wg_per_2
                                           WHERE dat_bis = '9999-12-31' AND
                                                 owg_id NOT IN (-1,-3) AND
                                                 mandant_id > 1) b
                                                    
SET KL_WG_ID = b.owg_id
	
WHERE dbp_etl.art_matching_nielsen_per_kmo.mandant_id = b.mandant_id AND
      dbp_etl.art_matching_nielsen_per_kmo.KL_OWG_ID = b.wg_id AND
      dbp_etl.art_matching_nielsen_per_kmo.art_id = -1 AND
      dbp_etl.art_matching_nielsen_per_kmo.KL_WG_ID <> b.owg_id AND
      dbp_etl.art_matching_nielsen_per_kmo.kjwo_update IN (SELECT MAX(kjwo_update) FROM dbp_etl.art_matching_nielsen_per_kmo_2)
;
