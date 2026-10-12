create or replace volatile table _art_nielsen as
(
 select * from dbp_data.art_nielsen_2 where DAT_BIS='9999-12-31'
) ;

CREATE OR REPLACE TABLE dbp_etl.not_listed_basis_2  (
      mandant_id BYTEINT,
      art_matching_id INTEGER,
      art_id INTEGER,
      gtin_id DECIMAL(18,0),
      list_kz VARCHAR(2) COLLATE 'en-ci')
;

CREATE OR REPLACE VOLATILE TABLE _not_listed_basis1 AS (
SELECT a.mandant_id,
       d.art_matching_id,
       a.art_id,
       c.gtin_id,
       a.list_kz
FROM (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) a
JOIN dbp_etl_process.art_gtin_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN _art_nielsen c
  ON a.mandant_id = c.mandant_id AND
     b.gtin_id = c.gtin_id
JOIN dbp_etl.art_matching_nielsen_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     c.gtin_id = d.gtin_id
WHERE a.list_kz IN ('C1','C2','D1','D2','X')
GROUP BY 1,2,3,4,5
);

INSERT INTO _not_listed_basis1
SELECT a.mandant_id,
       d.art_matching_id,
       a.art_id,
       c.gtin_id,
       a.list_kz
FROM (select distinct mandant_id,art_id,list_kz from dbp_etl.kl_basis_listung_2) a
JOIN dbp_etl_process.art_gtin_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN _art_nielsen c
  ON a.mandant_id = c.mandant_id AND
     b.gtin_id = c.gtin_id
JOIN dbp_etl.art_matching_nielsen_per_2 d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id AND
     c.gtin_id = d.gtin_id
WHERE a.list_kz IN ('A','B') AND
      d.art_matching_id IN (SELECT art_matching_id FROM _not_listed_basis1)
GROUP BY 1,2,3,4,5
;

--- check for flagging the article constellations

DELETE FROM _not_listed_basis1
WHERE (art_matching_id) IN (SELECT art_matching_id
                            FROM _not_listed_basis1
                            GROUP BY 1
                            HAVING Min(list_kz) IN ('A','B'))
;

CREATE OR REPLACE VOLATILE TABLE _not_listed_basis2 AS (
SELECT a.mandant_id,
       a.art_matching_id,
       Max(a.art_id) AS art_id,
       a.gtin_id,
       a.list_kz
FROM _not_listed_basis1 a
JOIN (SELECT mandant_id,
             art_matching_id,
	     gtin_id,
	     Min(list_kz) AS min_list_kz
      FROM _not_listed_basis1
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id AND
     a.art_matching_id = b.art_matching_id AND
     a.gtin_id = b.gtin_id AND
     a.list_kz = b.min_list_kz
GROUP BY 1,2,4,5
);

INSERT INTO dbp_etl.not_listed_basis_2 (mandant_id
                                     ,art_matching_id
                                     ,art_id
                                     ,gtin_id
                                     ,list_kz)
SELECT mandant_id
      ,art_matching_id
      ,art_id
      ,gtin_id
      ,list_kz
FROM _not_listed_basis2
;

-- Maximale Auspraegung fuer OWG --

CREATE OR REPLACE VOLATILE TABLE _owg_ct AS (
SELECT b.nielsen_wg_bez AS owg_bez,
       a.kl_wg_id AS owg_id,
       Count(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_2 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
WHERE a.mandant_id = 1 AND
      a.kl_wg_id NOT IN (-1,-3) AND
      a.kl_owg_id NOT IN (-1,-3) AND
      a.kl_uwg_id NOT IN (-1,-3) AND
      b.nielsen_wg_bez <> '-1' and
      a.kl_owg_id between 120 and 665
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _owg_ct_max AS (
SELECT a.owg_bez,
       Max(a.owg_id) AS owg_id
FROM _owg_ct a
JOIN (SELECT owg_bez,
             Max(anz) AS max_anz
      FROM _owg_ct
      GROUP BY 1) b
  ON a.owg_bez = b.owg_bez AND
     a.anz = b.max_anz
GROUP BY 1
);

-- Maximale Auspraegung fuer WG --

CREATE OR REPLACE VOLATILE TABLE _wg_ct AS (
SELECT x.owg_bez,
       b.nielsen_uwg1_bez AS wg_bez,
       a.kl_owg_id AS wg_id,
       Count(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_2 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN _owg_ct_max x
  ON b.nielsen_wg_bez = x.owg_bez
WHERE a.mandant_id = 1 AND
      a.kl_wg_id NOT IN (-1,-3) AND
      a.kl_owg_id NOT IN (-1,-3) AND
      a.kl_uwg_id NOT IN (-1,-3) and
      a.kl_owg_id between 120 and 665
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _wg_ct_max AS (
SELECT a.owg_bez,
       a.wg_bez,
       Max(a.wg_id) AS wg_id
FROM _wg_ct a
JOIN (SELECT owg_bez,
             wg_bez,
             Max(anz) AS max_anz
      FROM _wg_ct
      GROUP BY 1,2) b
  ON a.owg_bez = b.owg_bez AND
     a.wg_bez = b.wg_bez AND
     a.anz = b.max_anz
GROUP BY 1,2
);

-- Maximale Auspraegung fuer WGI --

CREATE OR REPLACE VOLATILE TABLE _wgi_ct AS (
SELECT x.owg_bez,
       b.nielsen_uwg1_bez AS wg_bez,
       b.nielsen_uwg2_bez AS wug_bez,
       a.kl_uwg_id AS wug_id,
       Count(*) AS anz
FROM dbp_etl.art_matching_nielsen_per_2 a
JOIN _art_nielsen b
  ON a.mandant_id = b.mandant_id AND
     a.art_nielsen_id = b.art_nielsen_id
JOIN _wg_ct_max x
  ON b.nielsen_wg_bez = x.owg_bez AND
     b.nielsen_uwg1_bez = x.wg_bez
WHERE a.mandant_id = 1 AND
      a.kl_wg_id NOT IN (-1,-3) AND
      a.kl_owg_id NOT IN (-1,-3) AND
      a.kl_uwg_id NOT IN (-1,-3) and
      a.kl_owg_id between 120 and 665
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _wgi_ct_max AS (
SELECT a.owg_bez,
       a.wg_bez,
       a.wug_bez,
       Max(a.wug_id) AS wug_id
FROM _wgi_ct a
JOIN (SELECT owg_bez,
             wg_bez,
             wug_bez,
             Max(anz) AS max_anz
      FROM _wgi_ct
      GROUP BY 1,2,3) b
  ON a.owg_bez = b.owg_bez AND
     a.wg_bez = b.wg_bez AND
     a.wug_bez = b.wug_bez AND
     a.anz = b.max_anz
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _pflege01 AS (
SELECT *
FROM _art_nielsen
WHERE (mandant_id,art_nielsen_id) NOT IN (SELECT mandant_id,art_nielsen_id
                                          FROM dbp_data.art_nielsen_wug_zu_pflege_2
                                          WHERE mandant_id = 1) AND
       mandant_id = 1 AND
      (mandant_id,art_nielsen_id) IN (SELECT mandant_id,
                                             art_nielsen_id
                                      FROM dbp_etl.art_matching_nielsen_per_2
                                      WHERE art_id = -1 AND
                                            mandant_id = 1)
);

CREATE OR REPLACE VOLATILE TABLE _pflege02 AS (
SELECT a.mandant_id,
       a.art_nielsen_id,
       Cast(-1 AS INTEGER) AS kl_wg_id,
       Cast(-1 AS INTEGER) AS kl_owg_id,
       Cast(-1 AS INTEGER) AS kl_uwg_id,
       a.nielsen_wg_bez,
       a.nielsen_uwg1_bez,
       a.nielsen_uwg2_bez
FROM _pflege01 a
GROUP BY 1,2,3,4,5,6,7,8
);

UPDATE _pflege02 FROM (SELECT owg_bez,
                              Max(owg_id) AS owg_id
                       FROM _owg_ct_max
                       GROUP BY 1) b
                       
SET kl_wg_id = b.owg_id
    
WHERE _pflege02.nielsen_wg_bez = b.owg_bez
;

UPDATE _pflege02 FROM (SELECT wg_bez,
                              Max(wg_id) AS wg_id
                       FROM _wg_ct_max
                       GROUP BY 1) b
                       
SET kl_owg_id = b.wg_id
    
WHERE _pflege02.nielsen_uwg1_bez = b.wg_bez
;

UPDATE _pflege02 FROM (SELECT wug_bez,
                              Max(wug_id) AS wug_id
                       FROM _wgi_ct_max
                       GROUP BY 1) b
                       
SET kl_uwg_id = b.wug_id
    
WHERE _pflege02.nielsen_uwg2_bez = b.wug_bez
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
     (a.mandant_id,a.art_nielsen_id) NOT IN (SELECT mandant_id,art_nielsen_id FROM dbp_data.art_nielsen_wug_zu_pflege_2)
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
