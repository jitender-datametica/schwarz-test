set (shopperzeit) = (${SHOPWO});

CREATE OR REPLACE VOLATILE TABLE _dat_von_dat_bis AS (
SELECT a.mandant_id,
       b.dat_von,
       c.dat_bis
FROM dbp_data.mandant_2 a
JOIN (SELECT mandant_id,
             MIN(dat) AS dat_von
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-53 AND
            mandant_id > 1
      GROUP BY 1) b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT mandant_id,
             MAX(dat) AS dat_bis
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit AND
            mandant_id > 1
      GROUP BY 1) c
  ON a.mandant_id = c.mandant_id
WHERE a.mandant_id > 1
);

create or replace volatile table _ods_bon_verkauf_summit as (
select z.*,
       k.wrg_id
from dbp_spezial.v_ods_bon_verkauf_union_2 z
join dbp_spezial.v_ods_bon_kopf_union_2 k
  on k.mandant_id = z.mandant_id and 
     k.bon_id = z.bon_id and 
     k.wup_id = z.wup_id
where z.mandant_id > 1 and
      z.bon_dat between (select min(dat_von) from _dat_von_dat_bis) and (select max(dat_bis) from _dat_von_dat_bis)
);

update _ods_bon_verkauf_summit from (select *
                                     from dbp_data.mandant_wrg_zu_per_2
                                     where current_date between dat_von and dat_bis and
                                           von_wrg_id is not null) b

set umsatz_brutto = umsatz_brutto/b.umrechnungskurs

where _ods_bon_verkauf_summit.mandant_id = b.mandant_id and
      _ods_bon_verkauf_summit.wrg_id = b.von_wrg_id
;

create or replace volatile table _ods_bon_kopf_summit as (
select *
from dbp_spezial.v_ods_bon_kopf_union_2
where mandant_id > 1 and
      bon_dat between (select min(dat_von) from _dat_von_dat_bis) and (select max(dat_bis) from _dat_von_dat_bis)
);

update _ods_bon_kopf_summit from (select *
                                  from dbp_data.mandant_wrg_zu_per_2
                                  where current_date between dat_von and dat_bis and
                                        von_wrg_id is not null) b

set umsatz_brutto = umsatz_brutto/b.umrechnungskurs,
    umsatz_mwst = umsatz_mwst/b.umrechnungskurs

where _ods_bon_kopf_summit.mandant_id = b.mandant_id and
      _ods_bon_kopf_summit.wrg_id = b.von_wrg_id
;

CREATE OR REPLACE VOLATILE TABLE _bon_for_missing_aktion_id AS (
SELECT a.bon_id,
       a.mandant_id,
       a.kl_art_id,
       MAX(b.aktion_id) AS aktion_id
FROM dbp_spezial.v_ods_promotion_union_2 a
JOIN DBP_DATA.l_bonuskauf_2 b
  ON a.bonuskauf_id = b.bonuskauf_id AND 
     a.mandant_id = b.mandant_id
GROUP BY 1,2,3
);

--update only missing_aktion_id
UPDATE _ods_bon_verkauf_summit FROM (SELECT *
                                     FROM _bon_for_missing_aktion_id) b

SET aktion_id = b.aktion_id

WHERE _ods_bon_verkauf_summit.bon_id = b.bon_id AND 
      _ods_bon_verkauf_summit.mandant_id = b.mandant_id AND 
      _ods_bon_verkauf_summit.kl_art_id = b.kl_art_id AND 
      TRIM(_ods_bon_verkauf_summit.aktion_id) = ''
;

CREATE OR REPLACE VOLATILE TABLE _woche AS (
SELECT a.mandant_id,
       b.akt_kjwo_ww,
       b.woche_2,
       b.dat_von,
       b.dat_bis,
       c.woche_wn1,
       d.woche_wn2,
       e.woche_wn3
FROM dbp_data.mandant_2 a
JOIN (SELECT mandant_id,
             akt_kjwo_ww,
             kjwo_ww AS woche_2,
             MIN(dat) AS dat_von,
             MAX(dat) as dat_bis
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit AND
            mandant_id > 1
      GROUP BY 1,2,3) b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT mandant_id,
             kjwo_ww AS woche_wn1
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-1 AND
            mandant_id > 1
      GROUP BY 1,2) c
  ON a.mandant_id = c.mandant_id
JOIN (SELECT mandant_id,
             kjwo_ww AS woche_wn2
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-2 AND
            mandant_id > 1
      GROUP BY 1,2) d
  ON a.mandant_id = d.mandant_id
JOIN (SELECT mandant_id,
             kjwo_ww AS woche_wn3
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-3 AND
            mandant_id > 1
      GROUP BY 1,2) e
  ON a.mandant_id = e.mandant_id
WHERE a.mandant_id > 1
);

CREATE OR REPLACE VOLATILE TABLE _akt_dat_von_dat_bis AS (
SELECT a.mandant_id,
       b.akt_dat_von,
       c.akt_dat_bis
FROM dbp_data.mandant_2 a
JOIN (SELECT mandant_id,
             MIN(dat) AS akt_dat_von
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-1 AND
            mandant_id > 1
      GROUP BY 1) b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT mandant_id,
             MAX(dat) AS akt_dat_bis
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit AND
            mandant_id > 1
      GROUP BY 1) c
  ON a.mandant_id = c.mandant_id
WHERE a.mandant_id > 1
);

CREATE OR REPLACE VOLATILE TABLE _bl_dat_von_dat_bis AS (
SELECT a.mandant_id,
       b.bl_dat_von,
       c.bl_dat_bis
FROM dbp_data.mandant_2 a
JOIN (SELECT mandant_id,
             MIN(dat) AS bl_dat_von
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-53 AND
            mandant_id > 1
      GROUP BY 1) b
  ON a.mandant_id = b.mandant_id
JOIN (SELECT mandant_id,
             MAX(dat) AS bl_dat_bis
      FROM dbp_data.werbewoche_kl_2
      WHERE akt_kjwo_ww = $shopperzeit-2 AND
            mandant_id > 1
      GROUP BY 1) c
  ON a.mandant_id = c.mandant_id
WHERE a.mandant_id > 1
);

create or replace volatile table _perf_01 as (
select akt.mandant_id,
       akta.art_id,
       akta.wup_id,
       akt.dat_von,
       akt.dat_bis,
       akta.aktion_thema_id
from dbp_data.aktion_2 akt
join dbp_data.aktion_art_wup_zu_2 akta
  on akt.aktion_id = akta.aktion_id and 
     akt.mandant_id = akta.mandant_id
join _woche x
  on akt.dat_bis between x.dat_von and x.dat_bis and
     akt.mandant_id = x.mandant_id
where akta.grund_sperrung is null and
      akt.mandant_id > 1
);

create or replace volatile table _hit_the_actions as (
select y.mandant_id,
       w.wup_id,
       x.woche_2 as kjwo,
       -1 as aktion_thema_gruppe_id,
       y.art_id as art_id,
       a.kl_art_id as kl_art_id,
       'W' as muki,
       y.dat_bis,
       cast(1 as decimal(15,3)) as mengen_faktor,
       a.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from _perf_01 y
join dbp_data.art_2 a
  on y.mandant_id = a.mandant_id and 
     a.mutter_wb_id is null and 
     y.art_id = a.art_id
join dbp_data.wup_2 w
  on y.wup_id = w.wup_id and 
     y.mandant_id = w.mandant_id and 
     w.nb_id = 0 and 
     y.dat_von between w.dat_von and w.dat_bis 
join dbp_data.art_wg_zu_per_2 aw
  on y.art_id = aw.art_id and 
     y.mandant_id = aw.mandant_id and 
     y.art_id = aw.art_id and 
     aw.arthiertyp_id = 2 and 
     aw.dat_bis = '9999-12-31'
join dbp_data.wg_per_2 wp
  on aw.mandant_id = wp.mandant_id and 
     aw.arthiertyp_id = wp.arthiertyp_id and 
     aw.wg_id = wp.wg_id and 
     wp.dat_bis = '9999-12-31'
join _woche x
  on y.dat_bis between x.dat_von and x.dat_bis and
     y.mandant_id = x.mandant_id
group by 1,2,3,4,5,6,7,8,9,10,11
);

insert into _hit_the_actions
select y.mandant_id,
       w.wup_id,
       x.woche_2 as kjwo,
       -1 as aktion_thema_gruppe_id,
       y.art_id as art_id,
       a.kl_art_id as kl_art_id,
       'M' as muki,
       y.dat_bis,
       cast(1 as decimal(15,3)) as mengen_faktor,
       a.posten_id,
       cast(0 as decimal(9,2)) as vk_brutto
from _perf_01 y
join dbp_data.art_2 a
  on y.mandant_id = a.mandant_id and 
     a.mutter_wb_id is not null and 
     y.art_id = a.mutter_wb_id
join dbp_data.wup_2 w
  on y.wup_id = w.wup_id and 
     y.mandant_id = w.mandant_id and 
     w.nb_id = 0 and 
     y.dat_von between w.dat_von and w.dat_bis
join dbp_data.art_wg_zu_per_2 aw
  on y.art_id = aw.art_id and 
     y.mandant_id = aw.mandant_id and 
     y.art_id = aw.art_id and 
     aw.arthiertyp_id = 2 and 
     aw.dat_bis = '9999-12-31'
join dbp_data.wg_per_2 wp
  on aw.mandant_id = wp.mandant_id and 
     aw.arthiertyp_id = wp.arthiertyp_id and 
     aw.wg_id = wp.wg_id and 
     wp.dat_bis = '9999-12-31' 
join _woche x
  on y.dat_bis between x.dat_von and x.dat_bis and
     y.mandant_id = x.mandant_id
group by 1,2,3,4,5,6,7,8,9,10,11
;

UPDATE _hit_the_actions FROM (SELECT b.kl_art_id,
                                     a.mandant_id,
                                     a.wup_id,
                                     MAX(a.vk_brutto) AS vk_brutto
                              FROM dbp_data.art_wup_vk_per_2 a
                              JOIN (SELECT mandant_id,
                                           kl_art_id,
                                           wup_id,
                                           dat_bis
                                    FROM _hit_the_actions
                                    GROUP BY 1,2,3,4) b
                                ON a.mandant_id = b.mandant_id AND
                                   floor(a.art_id/10) = b.kl_art_id AND
                                   a.wup_id = b.wup_id AND
                                   '9999-12-31' BETWEEN a.dat_von AND a.dat_bis
                              GROUP BY 1,2,3) b

SET vk_brutto = b.vk_brutto

WHERE _hit_the_actions.mandant_id = b.mandant_id AND
      _hit_the_actions.wup_id = b.wup_id AND
      _hit_the_actions.kl_art_id = b.kl_art_id
;

UPDATE _hit_the_actions FROM (SELECT h.kjwo,
                                     h.mandant_id,
                                     h.wup_id,
                                     h.art_id AS MU, 
                                     h.kl_art_id AS Kind,
                                     MAX(w.vk_brutto) AS K_BR,
                                     MAX(x.vk_brutto) AS M_BR,
                                     CAST(m_br AS DECIMAL(18,3)) / CAST(k_br AS DECIMAL(18,3)) AS mengen_faktor
                              FROM _hit_the_actions h
                              JOIN dbp_data.art_2 a
                                ON h.mandant_id = a.mandant_id AND
                                   h.kl_art_id = a.kl_art_id AND
                                   a.dat_bis = '9999-12-31'
                              JOIN dbp_data.art_wg_zu_per_2 wg
                                ON h.mandant_id = wg.mandant_id AND
                                   h.kl_art_id = floor(wg.art_id/10) AND
                                   wg.arthiertyp_id = 2 AND
                                   wg.dat_bis = '9999-12-31'
                              JOIN dbp_data.art_wup_vk_per_2 w
                                ON h.wup_id = w.wup_id AND
                                   h.mandant_id = w.mandant_id AND
                                   a.art_id = w.art_id AND
                                   h.dat_bis BETWEEN w.dat_von AND w.dat_bis
                              JOIN dbp_data.art_wup_vk_per_2 x
                                ON h.mandant_id = x.mandant_id AND
                                   h.art_id = x.art_id AND
                                   w.wup_id = x.wup_id AND
                                   h.dat_bis BETWEEN x.dat_von AND x.dat_bis
                              WHERE (wg.mandant_id,wg.wg_id) IN (SELECT mandant_id,wg_id FROM dbp_data.wg_filter_zu_2 WHERE mandant_id > 1 AND wg_filter_id = 31)
                              GROUP BY 1,2,3,4,5) b

SET mengen_faktor = b.mengen_faktor

WHERE _hit_the_actions.kjwo = b.kjwo AND
      _hit_the_actions.wup_id = b.wup_id AND
      _hit_the_actions.art_id = b.mu AND
      _hit_the_actions.kl_art_id = b.kind AND
      _hit_the_actions.mandant_id = b.mandant_id
;

DELETE FROM dbp_process.bf_hit_the_actions_kmo_2
WHERE (mandant_id,wup_id,kjwo) IN (SELECT mandant_id,wup_id,kjwo FROM _hit_the_actions)
;

INSERT INTO dbp_process.bf_hit_the_actions_kmo_2
SELECT a.*,
       current_timestamp,
       current_timestamp
FROM _hit_the_actions a
;

CREATE OR REPLACE VOLATILE TABLE _kl_art AS (
SELECT mandant_id,
       kl_art_id,
       art_id
FROM _hit_the_actions
GROUP BY 1,2,3
UNION
SELECT mandant_id,
       kl_art_id,
       art_id
FROM dbp_data.art_2
WHERE dat_bis = '9999-12-31' AND
      mandant_id > 1 AND
      wg_art_fg = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _aktuelle_wg AS (
SELECT a.mandant_id,
       floor(b.art_id/10) AS kl_art_id,
       a.wg_id
FROM dbp_data.art_wg_zu_per_2 a
JOIN dbp_data.art_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
WHERE a.mandant_id > 1 AND
      b.art_id > 0 AND
      a.arthiertyp_id = 2 AND
      a.dat_bis = '9999-12-31' AND
      b.dat_bis = '9999-12-31'
);
  
CREATE OR REPLACE VOLATILE TABLE _mutter_art AS (
SELECT a.mandant_id,
       a.kl_art_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id,
       b.wg_id
FROM dbp_data.art_2 a
JOIN dbp_data.art_wg_zu_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
WHERE a.mandant_id > 1 AND
      a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.kl_art_id) IN (SELECT mandant_id,kl_art_id FROM _kl_art)
);

CREATE OR REPLACE VOLATILE TABLE _mutter_wg AS (
SELECT mandant_id,
       mutter_wb_id,
	   MAX(wg_id) AS wg_id
FROM _mutter_art
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _wochen AS (
SELECT a.mandant_id,
       a.dat
FROM dbp_data.werbewoche_kl_2 a
join _woche b
  on a.mandant_id = b.mandant_id and
     a.akt_kjwo_ww = b.akt_kjwo_ww
GROUP BY 1,2
);

INSERT INTO dbp_etl_process.shopper_maerkte_2
SELECT mandant_id,
       wup_id,
       current_timestamp,
       current_timestamp
FROM dbp_ods.ods_bon_kopf_2
WHERE mandant_id > 1 AND
     (mandant_id,wup_id) NOT IN (SELECT mandant_id,wup_id FROM dbp_etl_process.shopper_maerkte_2)
GROUP BY 1,2
;

CREATE OR REPLACE VOLATILE TABLE _test_upd AS (
SELECT x3.aktion_id,
       x3.mandant_id,
       floor(x4.art_id/10) AS kl_art_id,
       x4.wup_id,
       x3.dat_von,
       x3.dat_bis
FROM (SELECT x1.mandant_id,
             x1.aktion_id,
             x1.dat_von,
             x1.dat_bis
      FROM dbp_data.aktion_2 x1
      JOIN dbp_data.werbewoche_kl_2 x2
        ON x2.dat BETWEEN x1.dat_von AND x1.dat_bis and
           x1.mandant_id = x2.mandant_id
      join _dat_von_dat_bis x
        ON x2.mandant_id = x.mandant_id and
           x2.dat between x.dat_von and x.dat_bis
      GROUP BY 1,2,3,4) x3
JOIN dbp_data.aktion_art_wup_zu_2 x4
  ON x3.aktion_id = x4.aktion_id AND
     x3.mandant_id = x4.mandant_id
WHERE x4.grund_sperrung IS NULL
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _test_upd_kopf AS (
SELECT x1.mandant_id,
       x1.aktion_id,
       x1.dat_von,
       x1.dat_bis
FROM dbp_data.aktion_2 x1
JOIN dbp_data.werbewoche_kl_2 x2
  ON x2.dat BETWEEN x1.dat_von AND x1.dat_bis and
     x1.mandant_id = x2.mandant_id
join _dat_von_dat_bis x
  ON x2.mandant_id = x.mandant_id and
     x2.dat between x.dat_von and x.dat_bis
GROUP BY 1,2,3,4
);

CREATE OR REPLACE VOLATILE TABLE _artbew_complete AS (
SELECT m.mandant_id,
       m.dat,
       m.wup_id,
       m.art_id,
       m.aktion_id,
       m.umsatz_netto,
       m.menge,
       m.ek_mep,
       m.einstandspreis
FROM dbp_data.artbew_2 m
JOIN _dat_von_dat_bis x
  ON m.mandant_id = x.mandant_id and
     m.dat between x.dat_von and x.dat_bis
where (m.art_id,m.mandant_id) IN (SELECT art_id,mandant_id FROM _mutter_art) AND
       m.menge > 0
);

CREATE OR REPLACE VOLATILE TABLE _bon_snapshot AS (
SELECT v.bon_id
      ,v.kl_art_id
      ,b.wg_id
      ,COALESCE(v.menge/x0.mengen_faktor, v.menge) AS menge
      ,v.umsatz_brutto
      ,v.aktion_id
      ,v.mandant_id
      ,v.wup_id
      ,v.talon_id
      ,v.start_bon_zeile
      ,k.bon_nr
      ,k.bon_dat
      ,k.kasse_nr
      ,k.turnover_fg
FROM (SELECT a.bon_id
            ,a.kl_art_id
            ,a.wg_id
            ,a.menge
            ,a.umsatz_brutto
            ,a.aktion_id
            ,a.mandant_id
            ,a.wup_id
            ,a.talon_id
            ,a.start_bon_zeile
      FROM _ods_bon_verkauf_summit a) v
JOIN (SELECT a.bon_id
		    ,a.bon_dat
			,a.kasse_nr
			,a.turnover_fg
			,a.wup_id
			,a.bon_nr
			,a.mandant_id
      FROM _ods_bon_kopf_summit a) k
  ON k.mandant_id = v.mandant_id AND 
     k.wup_id = v.wup_id AND 
     k.bon_id = v.bon_id
JOIN _aktuelle_wg b
  ON v.mandant_id = b.mandant_id AND
     v.kl_art_id = b.kl_art_id
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  MIN(mengen_faktor) AS mengen_faktor
           FROM _hit_the_actions
		   GROUP BY 1,2,3
           UNION ALL
           SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  AVG(mengen_faktor) AS mengen_faktor
           FROM dbp_process.bf_hit_the_actions_kmo_2
		   WHERE (mandant_id,wup_id,kl_art_id) NOT IN (SELECT mandant_id,wup_id,kl_art_id FROM _hit_the_actions)
           GROUP BY 1,2,3) x0
  ON v.mandant_id = x0.mandant_id AND
     v.kl_art_id = x0.kl_art_id AND
     v.wup_id = x0.wup_id
WHERE (v.kl_art_id,v.mandant_id) IN (SELECT kl_art_id,mandant_id FROM _mutter_art) AND
       v.wg_id <> 980 AND 
      (k.bon_id, k.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
);

CREATE OR REPLACE VOLATILE TABLE _bon_keys AS (
SELECT mandant_id,
       bon_id
FROM _bon_snapshot
WHERE (mandant_id,kl_art_id) IN (SELECT mandant_id,kl_art_id FROM _kl_art)
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _aktionen_bon_snapshot AS (
SELECT v.*
FROM _bon_snapshot v
JOIN _test_upd_kopf y
  ON v.aktion_id = y.aktion_id AND
     v.bon_dat BETWEEN y.dat_von AND y.dat_bis AND
     v.mandant_id = y.mandant_id
WHERE v.aktion_id <> '' AND
	   (v.mandant_id,v.kl_art_id) IN (SELECT mandant_id,kl_art_id FROM _mutter_art)
);

CREATE OR REPLACE VOLATILE TABLE _aktionen AS (
SELECT v.*
FROM _aktionen_bon_snapshot v
JOIN _test_upd z
  ON v.aktion_id = z.aktion_id AND
     v.mandant_id = z.mandant_id AND
     v.wup_id = z.wup_id AND
     v.kl_art_id = z.kl_art_id
);

CREATE OR REPLACE VOLATILE TABLE _bon_snapshot2 AS (
SELECT v.bon_id
      ,v.kl_art_id
      ,v.wg_id
      ,COALESCE(v.menge/x0.mengen_faktor, v.menge) AS menge
      ,v.umsatz_brutto
      ,v.aktion_id
      ,v.mandant_id
      ,v.wup_id
      ,v.talon_id
      ,v.start_bon_zeile
      ,k.bon_nr
      ,k.bon_dat
      ,k.kasse_nr
      ,k.turnover_fg
FROM (SELECT a.bon_id
	        ,a.kl_art_id
			,a.wg_id
			,a.menge
			,a.umsatz_brutto
			,a.aktion_id
			,a.mandant_id
			,a.wup_id
			,a.talon_id
			,a.start_bon_zeile 
      FROM _ods_bon_verkauf_summit a
      where (a.mandant_id,a.bon_id) IN (SELECT mandant_id,bon_id FROM _bon_keys)) v
JOIN (SELECT a.bon_id
            ,a.bon_dat
            ,a.kasse_nr
            ,a.turnover_fg
            ,a.wup_id
            ,a.bon_nr
            ,a.mandant_id
      FROM _ods_bon_kopf_summit a
      where (a.mandant_id,a.bon_id) IN (SELECT mandant_id,bon_id FROM _bon_keys)) k
  ON k.mandant_id = v.mandant_id AND 
     k.wup_id = v.wup_id AND 
     k.bon_id = v.bon_id
JOIN _aktuelle_wg b
  ON v.mandant_id = b.mandant_id AND
     v.kl_art_id = b.kl_art_id
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  MIN(mengen_faktor) AS mengen_faktor
           FROM _hit_the_actions
		   GROUP BY 1,2,3
           UNION ALL
           SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  AVG(mengen_faktor) AS mengen_faktor
           FROM dbp_process.bf_hit_the_actions_kmo_2
		   WHERE (mandant_id,wup_id,kl_art_id) NOT IN (SELECT mandant_id,wup_id,kl_art_id FROM _hit_the_actions)
           GROUP BY 1,2,3) x0
  ON v.mandant_id = x0.mandant_id AND
     v.kl_art_id = x0.kl_art_id AND
     v.wup_id = x0.wup_id
WHERE v.wg_id <> 980 AND 
     (k.bon_id, k.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
);

-- 27.10.2016, -dbay-
--
-- Wichtige Ergaenzung auf Marktebene! Damit uns bei gesplitteten Artikelwerbewochen
-- mit verschiedenen Maerkten (!) selbige nicht mit Aktionsabsatz in die Shoppersuppe
-- spucken, muessen wir fuer die Kalkulation der aktionsrelevanten Zahlen aus dem 
-- Marktpool nur diese der jeweiligen Shopperwoche (Hit The Actions) ziehen, die tat-
-- saechlich eine_2 Aktionsreferenz haben! Sonst darf NUR AF bewertet werden!!!

CREATE OR REPLACE VOLATILE TABLE _markets_hta AS (
SELECT mandant_id,
       wup_id,
       kl_art_id
FROM _hit_the_actions
GROUP BY 1,2,3
);

/*
+-------------------------------------------------------------
+ 4. FALL 1 - Verarbeitung
+-------------------------------------------------------------
*/

CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2 LIKE dbp_etl.bf_bons_kpicp_akt_kmo;

INSERT INTO dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2
SELECT xxx.woche_2 AS shopperwoche,
       v.mandant_id AS mandant_id,
       v.wup_id AS wup_id, 
       v.bon_dat AS dat, 
       v.kasse_nr AS kasse_nr,
       v.bon_nr AS bon_nr,
       v.bon_id AS bon_id,
       floor(x.mutter_wb_id/10) AS kl_mutter_id_wb,
       x.mutter_wb_id AS mutter_id_wb, 
       0 AS ges_umsatz_af,
       0 AS ges_umsatz_sa,
       0 AS ges_umsatz_akt, 
       0 AS ges_absatz_af,
       0 AS ges_absatz_sa,
       0 AS ges_absatz_akt,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.umsatz_brutto ELSE 0 end) AS a_umsatz_af,
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.umsatz_brutto ELSE 0 end) AS a_umsatz_sa, 
       0 AS a_umsatz_akt,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.menge ELSE 0 end) AS a_absatz_af, 
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.menge ELSE 0 end) AS a_absatz_sa, 
       0 AS a_absatz_akt,
       y.wg_id AS wg_id,
       0 AS w_umsatz_af,
       0 AS w_umsatz_sa,
       0 AS w_umsatz_akt,
       0 AS w_absatz_af,
       0 AS w_absatz_sa,
       0 AS w_absatz_akt
FROM (SELECT bon_id,
             mandant_id,
             wup_id,
			 bon_dat,
			 kasse_nr,
			 bon_nr,
             kl_art_id,
			 aktion_id,
	         SUM(menge) AS menge,
	         SUM(umsatz_brutto) AS umsatz_brutto
      FROM _bon_snapshot
      GROUP BY 1,2,3,4,5,6,7,8
      HAVING SUM(umsatz_brutto) > 0) v
JOIN _mutter_art x
  ON v.mandant_id = x.mandant_id AND
     v.kl_art_id = x.kl_art_id
JOIN dbp_data.art_wg_zu_per_2 y
  ON y.mandant_id = x.mandant_id AND
     y.arthiertyp_id = 2 AND
	 y.dat_bis = '9999-12-31' AND
	 x.mutter_wb_id = y.art_id
JOIN _woche xxx_2
  ON v.mandant_id = xxx.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,22
;

-- 1. Update

UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2 FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat, 
       v.kasse_nr AS _kasse_nr,
       v.bon_nr AS _bon_nr,
       v.bon_id AS _bon_id,
       floor(x.mutter_wb_id/10) AS _kl_mutter_id_wb,
       x.mutter_wb_id AS _mutter_id_wb, 
       SUM(v.umsatz_brutto) AS _a_umsatz_akt,
       SUM(v.menge) AS _a_absatz_akt
FROM _aktionen v
JOIN _mutter_art x
  ON v.kl_art_id = x.kl_art_id AND
     v.mandant_id = x.mandant_id
WHERE (v.mandant_id,v.wup_id,v.kl_art_id) IN (SELECT mandant_id,wup_id,kl_art_id FROM _markets_hta) 
GROUP BY 1,2,3,4,5,6,7,8) ods
SET a_umsatz_akt = _a_umsatz_akt,
    a_absatz_akt = _a_absatz_akt
WHERE mandant_id = _mandant_id
  AND wup_id = _wup_id
  AND dat = _dat
  AND kasse_nr = _kasse_nr
  AND bon_nr = _bon_nr
  AND bon_id = _bon_id
  AND mutter_id_wb = _mutter_id_wb
  AND (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

-- 2. Update

UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2 FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat,
       v.kasse_nr AS _kasse_nr,
       v.bon_nr AS _bon_nr,
       v.bon_id AS _bon_id,
       bf.mutter_id_wb AS _mutter_id_wb,
       SUM(v.umsatz_brutto) AS _ges_umsatz_akt,
       SUM(v.menge) AS _ges_absatz_akt,
       SUM(CASE WHEN v.wg_id = bf.wg_id THEN v.umsatz_brutto ELSE 0 end) AS _w_umsatz_akt,
       SUM(CASE WHEN v.wg_id = bf.wg_id THEN v.menge ELSE 0 end) AS _w_absatz_akt
FROM (SELECT *
      FROM _bon_snapshot2
      WHERE (mandant_id,wup_id,kl_art_id) IN (SELECT mandant_id,wup_id,kl_art_id FROM _markets_hta)) v
JOIN (SELECT *
      FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2
      WHERE (mandant_id,kl_mutter_id_wb) IN (SELECT mandant_id,floor(mutter_wb_id/10) FROM _mutter_art)) bf
  ON v.mandant_id = bf.mandant_id AND
     v.bon_dat = bf.dat AND
     v.wup_id = bf.wup_id AND
     v.kasse_nr = bf.kasse_nr AND
     v.bon_nr = bf.bon_nr AND
     v.turnover_fg = 1 AND
	   (bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche)
JOIN _test_upd x
  ON v.aktion_id = x.aktion_id AND
     v.mandant_id = x.mandant_id AND
     v.bon_dat BETWEEN x.dat_von AND x.dat_bis AND
     v.wup_id = x.wup_id AND
     v.kl_art_id = x.kl_art_id
GROUP BY 1,2,3,4,5,6,7) ods
SET
ges_umsatz_akt = _ges_umsatz_akt,
ges_absatz_akt = _ges_absatz_akt,
w_umsatz_akt = _w_umsatz_akt,
w_absatz_akt = _w_absatz_akt
WHERE
mandant_id = _mandant_id
AND wup_id = _wup_id
AND kasse_nr = _kasse_nr
AND bon_nr = _bon_nr
AND bon_id = _bon_id
AND mutter_id_wb = _mutter_id_wb
AND (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

-- 3. Update

UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2 FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat,
       v.kasse_nr AS _kasse_nr,
       v.bon_nr AS _bon_nr,
       v.bon_id AS _bon_id,
       bf.mutter_id_wb AS _mutter_id_wb,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.umsatz_brutto ELSE 0 end) AS _ges_umsatz_af,
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.umsatz_brutto ELSE 0 end) AS _ges_umsatz_sa,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.menge ELSE 0 end) AS _ges_absatz_af,
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.menge ELSE 0 end) AS _ges_absatz_sa,
       SUM(CASE WHEN v.wg_id = bf.wg_id AND trim(v.aktion_id) = '' THEN v.umsatz_brutto ELSE 0 end) AS _w_umsatz_af,
       SUM(CASE WHEN v.wg_id = bf.wg_id AND trim(v.aktion_id) <> '' THEN v.umsatz_brutto ELSE 0 end) AS _w_umsatz_sa,
       SUM(CASE WHEN v.wg_id = bf.wg_id AND trim(v.aktion_id) = '' THEN v.menge ELSE 0 end) AS _w_absatz_af,
       SUM(CASE WHEN v.wg_id = bf.wg_id AND trim(v.aktion_id) <> '' THEN v.menge ELSE 0 end) AS _w_absatz_sa
FROM (SELECT *
      FROM _bon_snapshot2) v
JOIN (SELECT *
      FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2
      WHERE (mandant_id,kl_mutter_id_wb) IN (SELECT mandant_id,floor(mutter_wb_id/10) FROM _mutter_art)) bf
  ON v.mandant_id = bf.mandant_id AND
     v.bon_dat = bf.dat AND
     v.wup_id = bf.wup_id AND
     v.kasse_nr = bf.kasse_nr AND
     v.bon_nr = bf.bon_nr AND
     v.turnover_fg = 1 AND
	(bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche)
GROUP BY 1,2,3,4,5,6,7) ods
SET
ges_umsatz_af = _ges_umsatz_af,
ges_umsatz_sa = _ges_umsatz_sa,
ges_absatz_af = _ges_absatz_af,
ges_absatz_sa = _ges_absatz_sa,
w_umsatz_af = _w_umsatz_af,
w_umsatz_sa = _w_umsatz_sa,
w_absatz_af = _w_absatz_af,
w_absatz_sa = _w_absatz_sa
WHERE
mandant_id = _mandant_id
AND wup_id = _wup_id
AND kasse_nr = _kasse_nr
AND bon_nr = _bon_nr
AND bon_id = _bon_id
AND mutter_id_wb = _mutter_id_wb
AND (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

DELETE FROM dbp_etl.bf_bons_kpicp_akt_kmo 
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_etl.bf_bons_kpicp_akt_kmo
SELECT *
FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_2
;

/*
+-------------------------------------------------------------
+ 5. FALL 2 - Verarbeitung
+-------------------------------------------------------------
*/

CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 LIKE dbp_etl.bf_bons_kpia_akt_kmo;

INSERT INTO dbp_etl.bf_bons_kpia_akt_kmo_tmp_2
SELECT xxx.woche_2 AS shopperwoche,
       x._mandant_id,
       x._wup_id,
	   x._dat,
       floor(y.mutter_wb_id/10) AS _kl_mutter_id_wb,
       y.mutter_wb_id AS _mutter_wb_id,
	   -- Artikelzeilen 
       0,0,0,0,0,0,0,0,
	   MAX(y.wg_id) AS wg_id,
	   0 AS _w_bons,
	   0 AS _w_bon_zeilen,
	   0 AS _w_umsatz_AF,
	   0 AS _w_umsatz_SA,
	   0,
	   0 AS _w_Absatz_AF,
	   0 AS _w_Absatz_SA,
	   0
FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat,
       -- Artikelzeilen 
       0 AS eins,0 AS zwei,0 AS drei,0 AS vier,0 AS fuenf,0 AS sechs,0 AS sieben,0 AS acht,
       v.wg_id _wg_id,
       0 AS _w_bons, 
       0 AS _w_bon_zeilen,
       0 AS _w_umsatz_AF,
       0 AS _w_umsatz_SA,
       0 AS neun,
       0 AS _w_Absatz_AF,
       0 AS _w_Absatz_SA,
       0 AS zehn
FROM _bon_snapshot v
JOIN (SELECT mandant_id,
             wg_id
      FROM _mutter_wg
	  GROUP BY 1,2) x
  ON v.wg_id = x.wg_id AND
     v.mandant_id = x.mandant_id
GROUP BY 1,2,3,12) x
JOIN _mutter_wg y
  ON x._wg_id = y.wg_id AND
     x._mandant_id = y.mandant_id
JOIN _woche xxx_2
  ON x._mandant_id = xxx.mandant_id
GROUP BY 1,2,3,4,5,6,16
;

UPDATE dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat,
       floor(x.mutter_wb_id/10) AS _kl_mutter_id_wb,
       x.mutter_wb_id AS _mutter_id_wb, 
       COUNT(DISTINCT(v.bon_id)) AS _A_Bons,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.menge ELSE 0 end) AS _a_absatz_af, 
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.menge ELSE 0 end) AS _a_absatz_sa, 
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.umsatz_brutto ELSE 0 end) AS _a_umsatz_af,
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.umsatz_brutto ELSE 0 end) AS _a_umsatz_sa
FROM _bon_snapshot v
JOIN _mutter_art x
  ON v.kl_art_id = x.kl_art_id AND
     v.mandant_id = x.mandant_id
JOIN dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 bf
  ON v.mandant_id = bf.mandant_id AND 
     v.bon_dat = bf.dat AND 
     v.wup_id = bf.wup_id AND 
     x.mutter_wb_id = bf.mutter_id_wb AND
	(bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche)
GROUP BY 1,2,3,4,5) ods
SET a_bons = _a_bons, 
    a_umsatz_af = _a_umsatz_af,
    a_umsatz_sa = _a_umsatz_sa,
    a_absatz_af = _a_absatz_af,
    a_absatz_sa =  _a_absatz_sa
WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat AND 
      mutter_id_wb = _mutter_id_wb AND
	 (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

UPDATE dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 FROM (
SELECT v.mandant_id AS _mandant_id,
       v.wup_id AS _wup_id,
       v.bon_dat AS _dat,
       floor(x.mutter_wb_id/10) AS _kl_mutter_id_wb,
       x.mutter_wb_id AS _mutter_id_wb, 
       SUM(v.menge) AS _a_absatz_akt, 
       SUM(v.umsatz_brutto) AS _a_umsatz_akt
FROM (SELECT *
      FROM _aktionen
	  WHERE (mandant_id,wup_id,kl_art_id) IN (SELECT mandant_id,wup_id,kl_art_id FROM _markets_hta)) v
JOIN _mutter_art x
  ON v.kl_art_id = x.kl_art_id AND
     v.mandant_id = x.mandant_id
JOIN dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 bf
  ON v.mandant_id = bf.mandant_id AND 
     v.bon_dat = bf.dat AND 
     v.wup_id = bf.wup_id AND 
     x.mutter_wb_id = bf.mutter_id_wb AND
	 (bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche)
GROUP BY 1,2,3,4,5) ods
SET a_umsatz_akt = _a_umsatz_akt,
    a_absatz_akt = _a_absatz_akt
WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat AND 
      mutter_id_wb = _mutter_id_wb AND
	 (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

create or replace volatile table _lookie as (
select a.mandant_id,
       b.art_id,
       min(a.dat_von) as dat_von,
       max(a.dat_bis) as dat_bis
from dbp_data.aktion_2 a
join dbp_data.aktion_art_wup_zu_2 b
  on a.aktion_id = b.aktion_id and
     a.mandant_id = b.mandant_id
where a.mandant_id > 1 and
      a.aktion_typ_id is not null and
      b.grund_sperrung is null
group by 1,2
);

update dbp_etl.bf_bons_kpia_akt_kmo_tmp_2 from (select *
                                              from _lookie) b
                                              
set a_absatz_af = 0

where dbp_etl.bf_bons_kpia_akt_kmo_tmp.mandant_id = b.mandant_id and
      dbp_etl.bf_bons_kpia_akt_kmo_tmp.mutter_id_wb = b.art_id and
      dbp_etl.bf_bons_kpia_akt_kmo_tmp.dat between b.dat_von and b.dat_bis and
      dbp_etl.bf_bons_kpia_akt_kmo_tmp.dat between (select min(akt_dat_von)+7 from _akt_dat_von_dat_bis) and (select max(akt_dat_bis) from _akt_dat_von_dat_bis)
;

DELETE FROM dbp_etl.bf_bons_kpia_akt_kmo 
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_etl.bf_bons_kpia_akt_kmo
SELECT *
FROM dbp_etl.bf_bons_kpia_akt_kmo_tmp_2
;


/*
+-------------------------------------------------------------
+ 6. FALL 3 - Verarbeitung
+-------------------------------------------------------------
*/

CREATE OR REPLACE VOLATILE TABLE _artbew AS (
SELECT m.mandant_id,
       m.dat,
       m.wup_id,
       m.art_id,
       m.aktion_id,
       m.umsatz_netto,
       COALESCE(m.menge/x0.mengen_faktor, m.menge) AS menge,
       m.ek_mep,
       m.einstandspreis
FROM _artbew_complete m
LEFT JOIN (SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  MIN(mengen_faktor) AS mengen_faktor
           FROM _hit_the_actions
           GROUP BY 1,2,3
           UNION ALL
           SELECT mandant_id,
                  wup_id,
                  kl_art_id,
                  AVG(mengen_faktor) AS mengen_faktor
           FROM dbp_process.bf_hit_the_actions_kmo_2
           WHERE (mandant_id,wup_id,kl_art_id) NOT IN (SELECT mandant_id,wup_id,kl_art_id FROM _hit_the_actions)
           GROUP BY 1,2,3) x0
  ON m.mandant_id = x0.mandant_id AND
     floor(m.art_id/10) = x0.kl_art_id AND
     m.wup_id = x0.wup_id
JOIN _dat_von_dat_bis b
  on m.mandant_id = b.mandant_id and
     m.dat between b.dat_von and b.dat_bis
WHERE (m.art_id,m.mandant_id) IN (SELECT art_id,mandant_id FROM _mutter_art) AND
	     m.menge > 0
);

DELETE FROM dbp_etl.bf_bons_kpi1x_kmo 
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_etl.bf_bons_kpi1x_kmo
SELECT xxx.woche_2 AS shopperwoche,
       m.mandant_id,
       m.dat,
       m.wup_id,
       a.mutter_wb_id,
       MAX(a.wg_id) AS wg_id, 
       COUNT(DISTINCT(m.aktion_id)) AS Aktionen,
       SUM(CASE WHEN trim(m.aktion_id) = '' THEN m.umsatz_netto ELSE 0 end) AS AF_Ums_Netto, 
       SUM(CASE WHEN trim(m.aktion_id) <> '' THEN m.umsatz_netto ELSE 0 end) AS SA_Ums_Netto,  
       0 AS AKT_Ums_Netto,
       SUM(CASE WHEN trim(m.aktion_id) = '' THEN m.menge ELSE 0 end) AS AF_Absatz,
       SUM(CASE WHEN trim(m.aktion_id) <> '' THEN m.menge ELSE 0 end) AS SA_Absatz, 
       0 AS AKT_Absatz,
       SUM(CASE WHEN trim(m.aktion_id) = '' AND m.mandant_id IN (2,5,8) THEN CAST(m.ek_mep AS DECIMAL(18,4)) 
	              WHEN trim(m.aktion_id) = '' AND m.mandant_id IN (3,6,7) THEN CAST(m.ek_mep AS DECIMAL(18,4)) 
	              ELSE 0 end) AS AF_MEP,
       SUM(CASE WHEN m.aktion_id <> '' AND m.mandant_id IN (2,5,8) THEN CAST(m.ek_mep AS DECIMAL(18,4))
	            WHEN m.aktion_id <> '' AND m.mandant_id IN (3,6,7) THEN CAST(m.ek_mep AS DECIMAL(18,4))
	            ELSE 0 end) AS SA_MEP,
       0 AS AKT_Mep,
       af_ums_netto - af_mep AS  AF_Ertrag,
       sa_ums_netto - sa_mep AS  SA_Ertrag,
       CAST(0 AS DECIMAL (18,4)) AS AKT_Ertrag
FROM _artbew m
JOIN _mutter_art a
  ON m.mandant_id = a.mandant_id AND
     m.art_id = a.art_id
JOIN _woche xxx_2
  ON m.mandant_id = xxx.mandant_id
JOIN _dat_von_dat_bis b
  on m.mandant_id = b.mandant_id and
     m.dat between b.dat_von and b.dat_bis
WHERE m.menge > 0
GROUP BY 1,2,3,4,5
;

UPDATE dbp_etl.bf_bons_kpi1x_kmo
FROM (SELECT m.mandant_id AS _mandant_id,
             m.dat AS _dat,
             m.wup_id AS _wup_id,
             x.mutter_wb_id AS _mutter_wb_id,
             SUM(m.umsatz_netto) AS _ums_netto,
             SUM(m.menge) AS _menge,
             SUM(m.ek_mep)  AS _mep,
             _ums_netto - _mep AS _Ertrag
      FROM (SELECT mandant_id,
	                 art_id,
                   dat,
                   wup_id,
                   aktion_id,
                   SUM(menge) AS menge,
                   SUM(umsatz_netto) AS umsatz_netto,
                   SUM(CASE
			                   WHEN mandant_id IN (2,5,8)
				                 THEN CAST(ek_mep AS DECIMAL(18,4))
				                 ELSE CAST(ek_mep AS DECIMAL(18,4))
				               END) AS ek_mep
            FROM _artbew
			      GROUP BY 1,2,3,4,5) m
	  JOIN _test_upd x1
	    ON m.aktion_id = x1.aktion_id AND
         m.mandant_id = x1.mandant_id AND
         m.dat BETWEEN x1.dat_von AND x1.dat_bis AND
         m.wup_id = x1.wup_id AND
         floor(m.art_id/10) = x1.kl_art_id
      JOIN _mutter_art x
        ON m.art_id = x.art_id AND
           m.mandant_id = x.mandant_id
      JOIN _dat_von_dat_bis b
        on m.mandant_id = b.mandant_id and
           m.dat between b.dat_von and b.dat_bis
      WHERE (m.wup_id,floor(m.art_id/10),m.mandant_id) IN (SELECT wup_id,kl_art_id,mandant_id FROM _markets_hta) 
      GROUP BY 1,2,3,4) ak

SET akt_ums_netto = _ums_netto,
    akt_absatz = _menge,
    akt_mep = _mep,
    akt_ertrag = _ertrag
	
WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat AND 
      mutter_id_wb = _mutter_wb_id AND
	   (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

/*
+-------------------------------------------------------------
+ 7. FALL 4 - Verarbeitung
+-------------------------------------------------------------
*/

create or replace volatile table _ods_bon_verkauf_kpim as (
select *
from _ods_bon_verkauf_summit
where bon_dat between (select min(dat) from _wochen) and (select max(dat) from _wochen)
);

create or replace volatile table _ods_bon_kopf_kpim as (
select *
from _ods_bon_kopf_summit
where bon_dat between (select min(dat) from _wochen) and (select max(dat) from _wochen)
);


DELETE FROM dbp_etl.bf_bons_kpim_akt_kmo_2
;

INSERT INTO dbp_etl.bf_bons_kpim_akt_kmo_2
SELECT ok.mandant_id,
       ok.wup_id,
       ok.bon_dat,
       COUNT(DISTINCT(ok.bon_id)) AS _bons,
       SUM(v.zeilen) AS _bon_zeilen,
       COUNT(DISTINCT(CASE WHEN trim(v.aktion_id) = '' THEN v.bon_id ELSE NULL END)) _bons_af,
       COUNT(DISTINCT(CASE WHEN trim(v.aktion_id) <> '' THEN v.bon_id ELSE NULL END)) _bons_sa,
       0 AS _bons_akt,
       SUM(CASE WHEN trim(v.aktion_id) = '' THEN v.umsatz_brutto ELSE 0 END ) AS _ges_umsatz_AF,
       SUM(CASE WHEN trim(v.aktion_id) <> '' THEN v.umsatz_brutto ELSE 0 END ) AS _ges_umsatz_SA,
       0 AS _ges_umsatz_akt
FROM (SELECT v.bon_id,
             v.mandant_id,
             v.wup_id,
             v.kl_art_id,
             v.aktion_id,
             COUNT(*) AS zeilen,
             SUM(v.umsatz_brutto) AS umsatz_brutto
      FROM _ods_bon_verkauf_kpim v
      WHERE v.wg_id <> 980
      GROUP BY 1,2,3,4,5
      HAVING SUM(v.umsatz_brutto) > 0) v
JOIN _ods_bon_kopf_kpim ok
  ON ok.mandant_id = v.mandant_id AND 
     ok.wup_id = v.wup_id AND 
     ok.bon_id = v.bon_id
JOIN _wochen x
  ON ok.bon_dat = x.dat AND
     ok.mandant_id = x.mandant_id
WHERE ok.mandant_id > 1 AND
      ok.turnover_fg = 1 AND
     (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
GROUP BY 1,2,3
;

-- KPI  fortschreiben kpim_akt Bons-Summen noch nur echte aktionen
UPDATE dbp_etl.bf_bons_kpim_akt_kmo_2 FROM (SELECT ok.mandant_id AS _mandant_id,
                                                 ok.wup_id AS _wup_id,
                                                 ok.bon_dat AS _dat,
                                                 COUNT(DISTINCT v.bon_id) AS _bons_akt,
                                                 SUM(v.umsatz_brutto) AS _akt_umsatz_SA
                                          FROM _ods_bon_verkauf_kpim v
                                          JOIN _ods_bon_kopf_kpim ok
                                            ON ok.mandant_id = v.mandant_id AND 
                                               ok.wup_id = v.wup_id AND 
                                               ok.bon_id = v.bon_id
                                           JOIN _wochen x
                                            ON ok.bon_dat = x.dat AND
                                               ok.mandant_id = x.mandant_id
                                          JOIN dbp_data.aktion_2 akt
                                            ON v.aktion_id = akt.aktion_id AND
                                               ok.bon_dat BETWEEN akt.dat_von AND akt.dat_bis AND
                                               ok.mandant_id = akt.mandant_id
                                          JOIN dbp_data.aktion_art_wup_zu_2 akta
                                            ON akt.aktion_id = akta.aktion_id AND
                                               akt.mandant_id = akta.mandant_id AND
                                               v.wup_id = akta.wup_id AND
                                               v.kl_art_id = floor(akta.art_id/10)
                                          WHERE ok.mandant_id > 1 AND
                                                ok.turnover_fg = 1 AND
                                                v.wg_id <> 980 AND
                                                akta.grund_sperrung IS NULL AND
                                               (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
                                          GROUP BY 1,2,3 ) ods

SET ges_umsatz_akt = _akt_umsatz_SA,
    bons_akt       = _bons_akt

WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat
;

DELETE FROM dbp_process.bf_bons_kpim_akt_kmo_2
WHERE (mandant_id,dat) IN (SELECT mandant_id,dat FROM _wochen)
;

INSERT INTO dbp_process.bf_bons_kpim_akt_kmo_2
SELECT a.*,
       current_timestamp,
       current_timestamp
FROM dbp_etl.bf_bons_kpim_akt_kmo_2 a
;

/*
+-------------------------------------------------------------
+ 7. F I N A L E
+-------------------------------------------------------------
*/

UPDATE dbp_etl.bf_bons_kpia_akt_kmo FROM (SELECT c.mandant_id AS _mandant_id,
                                                 c.wup_id AS _wup_id,
						 c.shopperwoche AS _shopperwoche,
                                                 c.dat AS _dat,
                                                 c.mutter_id_wb AS _mutter_id_wb,
                                                 COUNT(*) AS _a_bons
                                        FROM dbp_etl.bf_bons_kpicp_akt_kmo c
                                        WHERE (c.mandant_id,c.shopperwoche) in (select mandant_id,woche_2 from _woche) and
					       c.a_absatz_af + c.a_absatz_sa > 0 AND
					       c.mandant_id > 1
				  	GROUP BY 1,2,3,4,5) xxx_2

SET a_bons = _a_bons

WHERE mandant_id = _mandant_id AND 
      mutter_id_wb = _mutter_id_wb AND 
      wup_id = _wup_id AND 
      dat = _dat AND
      shopperwoche = _shopperwoche
;

CREATE OR REPLACE VOLATILE TABLE _exclude_displays AS (
SELECT c.mandant_id,
       c.kl_art_id
FROM dbp_data.stueckliste_2 a
JOIN dbp_data.stueckliste_det_2 b
  ON a.mandant_id = b.mandant_id AND
     a.stueckliste_id = b.stueckliste_id
JOIN dbp_process.bf_hit_the_actions_kmo_2 c
  ON a.mandant_id = c.mandant_id AND
     floor(a.art_id/10) = c.kl_art_id
WHERE a.dat_bis = '9999-12-31' AND
      (c.mandant_id,c.kjwo) in (select mandant_id,woche_2 from _woche) AND
	  b.komponentenmenge <> 1
GROUP BY 1,2
);

DELETE FROM dbp_etl.bf_shopper_front_kmo
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_etl.bf_shopper_front_kmo
select distinct x.* from (
SELECT m.mandant_id
  , w.aktuell_wup_id as wup_id
  , w.nb_id
  , 1 AS baseline
  , m.mutter_id_wb
  , shopperwoche                    AS shopperwoche   
  , MIN ( m.dat )               AS Min_Tag_BL     
  , MAX ( m.dat )               AS Max_Tag_BL     
  , COUNT ( DISTINCT ( m.wup_id ) ) AS anz_af_maerkte 
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AF_Ums_Netto   
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AKT_Ums_Netto  
  , CAST( 0 AS DEC ( 18 , 3 ) )     AS AF_Absatz      
  , CAST( 0 AS DEC ( 18 , 3 ) )     AS AKT_Absatz     
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AF_Ertrag      
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AKT_Ertrag     
  , CAST( 0 AS DEC ( 12 ) )         AS BL_AF_Kaeufer  
  , CAST( 0 AS DEC ( 12 ) )         AS BL_AKT_Kaeufer 
  , CAST( 0 AS DEC ( 12 ) )         AS RW_Tage        
  , CAST( 0 AS DEC ( 12 ) )         AS RW_Akt_Tage    
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS BL_AF_KD_RW    
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS BL_AKT_KD_RW   
  , CAST( 0 AS DEC ( 12 ) )         AS CP_Kaeufer     
  , CAST( 0 AS DEC ( 12 ) )         AS CP_alle_70     
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS RestBon_AF     
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS RestBon_gesamt 
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS akt_NP_Umsatz
  , CAST( 0 AS INTEGER )            AS anz_markt_sa
  , CAST( 0 AS INTEGER )            AS anz_kaeufer_af
  , CAST( 0 AS INTEGER )            AS anz_kaeufer_sa
  , CAST( 0 AS INTEGER )            AS anz_bon_af
  , CAST( 0 AS INTEGER )            AS anz_bon_sa
  , CAST( 0 AS INTEGER )            AS anz_bon_aktion
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS ges_umsatz_ohne_art
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS ges_umsatz_inkl_wv
FROM dbp_etl.bf_bons_kpi1x_kmo m                 
   , dbp_data.wup_2 w              
   , dbp_data.werbewoche_kl_2 z
   , _bl_dat_von_dat_bis xxx_2
WHERE m.mandant_id = xxx.mandant_id AND
      z.dat BETWEEN xxx.bl_dat_von AND xxx.bl_dat_bis AND
     (m.mandant_id,m.shopperwoche) in (select mandant_id,woche_2 from _woche) and
      z.mandant_id > 1 AND
      z.dat = m.dat AND
      m.mandant_id = z.mandant_id AND
      m.mandant_id = w.mandant_id AND
      m.wup_id = w.wup_id
GROUP BY 1,2,3,4,5,6) x
;

-- 20.06.2016, -dbay-
--
-- Ergaenzung von MAKs ohne Baseline-Abverkauf!

INSERT INTO dbp_etl.bf_shopper_front_kmo
select distinct x.* from (
SELECT m.mandant_id
  , w.aktuell_wup_id as wup_id
  , w.nb_id
  , 1 AS baseline
  , m.mutter_id_wb
  , shopperwoche                    AS shopperwoche   
  , CAST('1900-01-01' AS DATE)      AS Min_Tag_BL     
  , CAST('1900-01-01' AS DATE)      AS Max_Tag_BL 
  , 0  AS anz_af_maerkte 
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AF_Ums_Netto   
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AKT_Ums_Netto  
  , CAST( 0 AS DEC ( 18 , 3 ) )     AS AF_Absatz      
  , CAST( 0 AS DEC ( 18 , 3 ) )     AS AKT_Absatz     
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AF_Ertrag      
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS AKT_Ertrag     
  , CAST( 0 AS DEC ( 12 ) )         AS BL_AF_Kaeufer  
  , CAST( 0 AS DEC ( 12 ) )         AS BL_AKT_Kaeufer 
  , CAST( 0 AS DEC ( 12 ) )         AS RW_Tage        
  , CAST( 0 AS DEC ( 12 ) )         AS RW_Akt_Tage    
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS BL_AF_KD_RW    
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS BL_AKT_KD_RW   
  , CAST( 0 AS DEC ( 12 ) )         AS CP_Kaeufer     
  , CAST( 0 AS DEC ( 12 ) )         AS CP_alle_70     
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS RestBon_AF     
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS RestBon_gesamt 
  , CAST( 0 AS DEC ( 12 , 3 ) )     AS akt_NP_Umsatz
  , CAST( 0 AS INTEGER )            AS anz_markt_sa
  , CAST( 0 AS INTEGER )            AS anz_kaeufer_af
  , CAST( 0 AS INTEGER )            AS anz_kaeufer_sa
  , CAST( 0 AS INTEGER )            AS anz_bon_af
  , CAST( 0 AS INTEGER )            AS anz_bon_sa
  , CAST( 0 AS INTEGER )            AS anz_bon_aktion
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS ges_umsatz_ohne_art
  , CAST( 0 AS DEC ( 18 , 4 ) )     AS ges_umsatz_inkl_wv
FROM dbp_etl.bf_bons_kpi1x_kmo m                 
  , dbp_data.wup_2 w              
  , dbp_data.werbewoche_kl_2 z
  , _akt_dat_von_dat_bis xxx_2
WHERE m.mandant_id = xxx.mandant_id AND
      z.dat BETWEEN xxx.akt_dat_von AND xxx.akt_dat_bis AND
     (m.mandant_id,m.shopperwoche) in (select mandant_id,woche_2 from _woche) and
      z.mandant_id > 1 AND
      z.dat          = m.dat AND
      m.mandant_id = z.mandant_id AND
      m.mandant_id   = w.mandant_id AND
      m.wup_id       = w.wup_id AND
     (m.mandant_id,w.aktuell_wup_id,m.mutter_id_wb) NOT IN (SELECT mandant_id,wup_id,mutter_id_wb 
                                                            FROM dbp_etl.bf_shopper_front_kmo
                                                            WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche))) x
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT m.mandant_id            AS _mandant_id
      , w.aktuell_wup_id           AS _wup_id
      , m.mutter_id_wb             AS _mutter_id_wb
      , m.shopperwoche             AS _shopperwoche
      , 1                          AS _baseline
      , SUM(m.af_ums_netto)        AS _AF_Ums_Netto
      , SUM(m.af_absatz)           AS _AF_Absatz
      , SUM(af_ums_netto - af_mep) AS _AF_ertrag
    FROM dbp_etl.bf_bons_kpi1x_kmo m
       , dbp_data.wup_2 w
       , dbp_data.werbewoche_kl_2 z
       , _bl_dat_von_dat_bis xxx_2
    WHERE m.mandant_id = xxx.mandant_id AND
          z.dat BETWEEN xxx.bl_dat_von AND xxx.bl_dat_bis AND
          z.dat = m.dat AND
		  z.mandant_id > 1 AND
		  m.mandant_id = z.mandant_id AND
          af_absatz      > 0 AND
          sa_absatz      = 0 AND
          m.mandant_id   = w.mandant_id AND
          m.wup_id       = w.wup_id AND
         (m.mandant_id,m.shopperwoche) in (select mandant_id,woche_2 from _woche)
    GROUP BY 1,2,3,4,5) xxx_2
SET AF_Ums_netto = _af_Ums_Netto
  , AF_Absatz    = _af_Absatz
  , AF_Ertrag    = _af_Ertrag
WHERE mandant_id = _mandant_id AND
    wup_id       = _wup_id AND
    mutter_id_wb = _mutter_id_wb AND
    shopperwoche = _shopperwoche AND
	baseline = _baseline
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT a.mandant_id AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , a.mutter_id_wb  AS _mutter_id_wb
      , a.shopperwoche  AS _shopperwoche
	  , 1 AS _baseline
	  , SUM(m.bons) AS _anz_bon_af
	  , SUM(m.bons_sa) AS _anz_bon_sa
	  , SUM(CASE WHEN a_absatz_af > 0 AND a_absatz_sa = 0 THEN a_bons ELSE 0 END) AS _anz_kaeufer_af
      , SUM(CASE WHEN a_absatz_af > 0 AND a_absatz_sa = 0 THEN a_bons ELSE 0 END)/COUNT(DISTINCT(m.wup_id||m.dat)) AS _BL_AF_Kaeufer
      , 100.000 * SUM(CASE WHEN a_absatz_af > 0 AND a_absatz_sa = 0 THEN a_bons ELSE 0 END)/SUM(m.bons) AS _BL_AF_KD_RW
      , COUNT(DISTINCT(m.wup_id||m.dat)) AS _rw_tage
    FROM dbp_etl.bf_bons_kpia_akt_kmo a
      , dbp_process.bf_bons_kpim_akt_kmo_2 m
      , dbp_data.wup_2 w
      , dbp_data.werbewoche_kl_2 z
      , _bl_dat_von_dat_bis xxx_2
    WHERE m.mandant_id = xxx.mandant_id AND
          z.dat BETWEEN xxx.bl_dat_von AND xxx.bl_dat_bis AND
          a.mandant_id   > 1 AND
          a.mandant_id   = m.mandant_id AND
          a.wup_id       = m.wup_id AND
          a.dat          = m.dat AND
		  z.mandant_id > 1 AND
		  m.mandant_id = z.mandant_id AND
          a_absatz_af    > 0 AND
          a_absatz_sa    = 0 AND
          z.dat          = m.dat AND
          m.mandant_id   = w.mandant_id AND
          m.wup_id       = w.wup_id AND
          w.nb_id        = 0 AND
         (a.mandant_id,a.shopperwoche) in (select mandant_id,woche_2 from _woche)
    GROUP BY 1,2,3,4,5) xxx_2
SET BL_AF_KAEUFER = _BL_AF_KAEUFER
  , BL_AF_KD_RW   = _BL_AF_KD_RW
  , RW_AF_Tage    = _rw_tage
  , anz_kaeufer_af = _anz_kaeufer_af
  , anz_bon_af = _anz_bon_af
  , anz_bon_sa = 0 
WHERE mandant_id  = _mandant_id AND
    wup_id         = _wup_id AND
    mutter_id_wb  = _mutter_id_wb AND
    shopperwoche  = _shopperwoche AND
	baseline = _baseline
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT m.mandant_id                     AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , m.mutter_id_wb                      AS _mutter_id_wb
      , m.shopperwoche                      AS _shopperwoche
	  , 1                                   AS _baseline
      , SUM ( m.akt_ums_netto )             AS _AKT_Ums_Netto
      , SUM ( m.akt_absatz )                AS _AKT_Absatz
      , SUM ( m.akt_ums_netto - m.akt_mep ) AS _AKT_ertrag
    FROM dbp_etl.bf_bons_kpi1x_kmo m
      , dbp_data.wup_2 w
      , dbp_data.werbewoche_kl_2 z
      , _akt_dat_von_dat_bis xxx_2
    WHERE m.mandant_id = xxx.mandant_id AND
          z.dat BETWEEN xxx.akt_dat_von AND xxx.akt_dat_bis AND
         (m.mandant_id,m.shopperwoche) in (select mandant_id,woche_2 from _woche) and  
          z.dat = m.dat AND
          z.mandant_id > 1 AND
		  m.mandant_id = z.mandant_id AND
          akt_absatz     > 0 AND
          m.mandant_id   = w.mandant_id AND
          m.wup_id       = w.wup_id
    GROUP BY 1,2,3,4,5) xxx_2
SET AKT_Ums_netto = _akt_Ums_Netto
  , AKT_Absatz    = _akt_Absatz
  , AKT_Ertrag    = _akt_Ertrag
WHERE mandant_id  = _mandant_id AND
    wup_id         = _wup_id AND
    mutter_id_wb  = _mutter_id_wb AND
    shopperwoche  = _shopperwoche AND
	baseline = _baseline
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT m.mandant_id AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , a.mutter_id_wb  AS _mutter_id_wb
      , a.shopperwoche AS _shopperwoche
	  , 1 AS _baseline
      , SUM(m.bons) AS _anz_bon_aktion
	  , SUM(CASE WHEN a_absatz_akt > 0 AND a_absatz_af = 0 THEN a_bons ELSE 0 END) AS _anz_kaeufer_sa
      , SUM(CASE WHEN a_absatz_akt > 0 AND a_absatz_af = 0 THEN a_bons ELSE 0 END)/COUNT(DISTINCT(m.wup_id||m.dat)) AS _BL_AKT_Kaeufer
      , 100.000 * SUM(CASE WHEN a_absatz_akt > 0 AND a_absatz_af = 0 THEN a_bons ELSE 0 END)/SUM(m.bons) AS _BL_AKT_KD_RW
      , COUNT(DISTINCT(m.wup_id||m.dat)) AS _rw_akt_tage
	  , COUNT(DISTINCT m.wup_id) AS _anz_markt_sa
    FROM dbp_etl.bf_bons_kpia_akt_kmo a
      , dbp_process.bf_bons_kpim_akt_kmo_2 m
      , dbp_data.wup_2 w
      , dbp_data.werbewoche_kl_2 z
      , _akt_dat_von_dat_bis xxx_2
    WHERE m.mandant_id = xxx.mandant_id AND
          z.dat BETWEEN xxx.akt_dat_von AND xxx.akt_dat_bis AND
          a.mandant_id   > 1 AND
          a.mandant_id   = m.mandant_id AND
          a.wup_id       = m.wup_id AND
          a.dat          = m.dat AND
          a_absatz_akt   > 0 AND
          a_absatz_af    = 0 AND
          z.dat          = m.dat AND
		  z.mandant_id   > 1 AND
		  m.mandant_id = z.mandant_id AND
          m.mandant_id   = w.mandant_id AND
          m.wup_id       = w.wup_id AND
          w.nb_id        = 0 AND
		 (a.mandant_id,a.shopperwoche) in (select mandant_id,woche_2 from _woche)
    GROUP BY 1,2,3,4,5) xxx_2
SET BL_AKT_Kaeufer = _BL_AKT_Kaeufer
  , BL_AKT_KD_RW   = _BL_AKT_KD_RW
  , RW_Akt_tage    = _rw_akt_tage
  , anz_markt_sa   = _anz_markt_sa
  , anz_kaeufer_sa = _anz_kaeufer_sa
  , anz_bon_aktion = _anz_bon_aktion
WHERE mandant_id   = _mandant_id AND
    wup_id          = _wup_id AND
    mutter_id_wb   = _mutter_id_wb AND
    shopperwoche   = _shopperwoche AND
	baseline = _baseline
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT w.mandant_id AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , mutter_id_wb    AS _mutter_id_wb
      , bf.shopperwoche AS _shopperwoche
	  , 1 AS _baseline
      , COUNT(DISTINCT(bf.wup_id|| bf.dat)) AS Tage
      , SUM ( CASE WHEN a_absatz_akt > 0 THEN 1 ELSE 0 END ) AS _CP_Kaeufer
      , SUM ( CASE WHEN ( ( a_umsatz_af + a_umsatz_akt
                    ) / NULLIFZERO(( ges_umsatz_af + ges_umsatz_akt )) >= CASE
                                                                WHEN COALESCE(x.vk_brutto,0) > 7.99
                                                                THEN 0.85
                                                                ELSE 0.70
                                                              END OR ( a_absatz_af + a_absatz_akt
                    ) / NULLIFZERO(( ges_absatz_af + ges_absatz_akt )) >= 0.7
                ) THEN 1 ELSE 0 END )  AS _CP_Alle_70
    FROM dbp_etl.bf_bons_kpicp_akt_kmo bf
    JOIN _akt_dat_von_dat_bis xxx_2
      ON bf.mandant_id = xxx.mandant_id and
         bf.dat between xxx.akt_dat_von and xxx.akt_dat_bis
	JOIN dbp_data.werbewoche_kl_2 z
	  ON z.dat BETWEEN xxx.akt_dat_von and xxx.akt_dat_bis AND
         z.dat = bf.dat AND
		 z.mandant_id = xxx.mandant_id AND
		 bf.mandant_id = z.mandant_id
    JOIN dbp_data.wup_2 w
	  ON bf.wup_id = w.wup_id AND
        bf.mandant_id = w.mandant_id
    LEFT JOIN (SELECT mandant_id,
	                  wup_id,
                      art_id,
                      MAX(vk_brutto) AS vk_brutto
               FROM dbp_process.bf_hit_the_actions_kmo_2
               WHERE (mandant_id,kjwo) in (select mandant_id,woche_2 from _woche) AND
			         (mandant_id,kl_art_id) NOT IN (SELECT mandant_id,kl_art_id FROM _exclude_displays)
               GROUP BY 1,2,3) x
      ON bf.wup_id = x.wup_id AND
         bf.mutter_id_wb = x.art_id AND
		 bf.mandant_id = x.mandant_id
    WHERE a_absatz_akt  > 0 AND
		 (bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche)
    GROUP BY 1,2,3,4,5) xxx_2
SET CP_Kaeufer   = _cp_kaeufer
  , CP_Alle_70   = _CP_Alle_70
WHERE mandant_id = _mandant_id AND
    wup_id        = _wup_id AND
    mutter_id_wb = _mutter_id_wb AND
    shopperwoche = _shopperwoche AND
	baseline = _baseline
;

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT w.mandant_id AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , mutter_id_wb    AS _mutter_id_wb
      , bf.shopperwoche AS _shopperwoche
	  , 1 AS _baseline
	  ,COUNT(DISTINCT(w.wup_id||bf.bon_id)) AS _anz_bon_sa
      ,(SUM(ges_umsatz_af + ges_umsatz_sa)-SUM(a_umsatz_af + a_umsatz_sa))/COUNT(DISTINCT(w.wup_id||bf.bon_id)) AS _rb_errechnet
      , SUM(ges_umsatz_af + ges_umsatz_sa - ges_umsatz_akt)/COUNT(DISTINCT(w.wup_id||bf.bon_id)) AS _restbon_af
      , SUM(ges_umsatz_af + ges_umsatz_sa - ges_umsatz_akt)/COUNT(DISTINCT(w.wup_id||bf.dat)) AS _akt_NP_umsatz
    FROM dbp_etl.bf_bons_kpicp_akt_kmo bf
      , dbp_data.werbewoche_kl_2 z
      , dbp_data.wup_2 w
      , _akt_dat_von_dat_bis xxx_2
    WHERE bf.mandant_id = xxx.mandant_id AND
          bf.dat BETWEEN xxx.akt_dat_von AND xxx.akt_dat_bis AND
          a_absatz_akt  > 0 AND
          z.dat = bf.dat AND
		  z.mandant_id  > 1 AND
          bf.wup_id = w.wup_id AND
          bf.mandant_id = w.mandant_id AND
         (bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche) AND
		  bf.mandant_id = z.mandant_id
    GROUP BY 1,2,3,4,5) xxx_2
SET RestBon_AF     = _restbon_af
  , RestBon_gesamt = _rb_errechnet
  , akt_NP_Umsatz  = _akt_NP_umsatz
  , anz_bon_sa = _anz_bon_sa
WHERE mandant_id   = _mandant_id AND
    wup_id          = _wup_id AND
    mutter_id_wb   = _mutter_id_wb AND
    shopperwoche   = _shopperwoche AND
	baseline = _baseline
;

-- Jetzt Gesamtumsatz ueber den Baseline-Zeitraum, nicht mehr
-- ueber Aktionszeitraum.

UPDATE dbp_etl.bf_shopper_front_kmo
FROM (
    SELECT w.mandant_id AS _mandant_id
      , w.aktuell_wup_id                   AS _wup_id
      , mutter_id_wb    AS _mutter_id_wb
      , bf.shopperwoche AS _shopperwoche
	  , 1 AS _baseline
      , SUM(ges_umsatz_af + ges_umsatz_sa)-SUM(a_umsatz_af + a_umsatz_sa) AS _ums_gesamt_ausser_artikel
      , SUM(ges_umsatz_af + ges_umsatz_sa - ges_umsatz_akt) AS _ums_gesamt_af_mit_wv
    FROM dbp_etl.bf_bons_kpicp_akt_kmo bf
      , dbp_data.werbewoche_kl_2 z
      , dbp_data.wup_2 w
      , _akt_dat_von_dat_bis xxx_2
    WHERE bf.mandant_id = xxx.mandant_id AND
          bf.dat BETWEEN xxx.akt_dat_von AND xxx.akt_dat_bis AND
          a_absatz_akt  > 0 AND
          z.dat         = bf.dat AND
		  z.mandant_id  > 1 AND
          bf.wup_id     = w.wup_id AND
          bf.mandant_id = w.mandant_id AND
         (bf.mandant_id,bf.shopperwoche) in (select mandant_id,woche_2 from _woche) AND
		  bf.mandant_id = z.mandant_id
    GROUP BY 1,2,3,4,5) xxx_2
SET ges_umsatz_ohne_art = _ums_gesamt_ausser_artikel
  , ges_umsatz_inkl_wv = _ums_gesamt_af_mit_wv
WHERE mandant_id   = _mandant_id AND
    wup_id          = _wup_id AND
    mutter_id_wb   = _mutter_id_wb AND
    shopperwoche   = _shopperwoche AND
	baseline = _baseline
;

DELETE FROM dbp_etl.bf_shopper_kmo
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_etl.bf_shopper_kmo
SELECT *
FROM dbp_etl.bf_shopper_front_kmo
WHERE (mandant_id,shopperwoche) in (select mandant_id,woche_2 from _woche)
;

-- Jetzt die Aufbereitung der SHOPPER_2-Tabelle!!!

DELETE FROM dbp_data.shopper_2
WHERE (mandant_id,kjwo_werbe_ende) in (select mandant_id,woche_2 from _woche)
;

INSERT INTO dbp_data.shopper_2 (wup_id
                             ,nb_id
                             ,mandant_id
                             ,art_id_werbung
                             ,baseline
                             ,kjwo_werbe_ende
                             ,dat_baseline_von
                             ,dat_baseline_bis
                             ,anz_markt_baseline_af
                             ,ums_netto_baseline_af
                             ,ums_netto_sa
                             ,menge_baseline_af
                             ,menge_sa
                             ,ertrag_baseline_af
                             ,ertrag_sa
                             ,anz_kaeufer_af
                             ,anz_kaeufer_sa
                             ,anz_bon_af 
                             ,anz_bon_sa
                             ,anz_bon_aktion
                             ,anz_tage_baseline_af
                             ,anz_tage_sa
                             ,kaeufer_prozent_baseline_af
                             ,kaeufer_prozent_sa
                             ,anz_cp_kaeufer
                             ,anz_cp_kaeufer_70_prozent
                             ,ums_rest_bon_af
                             ,ums_rest_bon_gesamt
                             ,ums_aktivierter_normalpreis
                             ,wrg_id
                             ,aktion_thema_gruppe_id
                             ,medien_kz
                             ,menge_wo1
                             ,menge_wo2
                             ,menge_wo3
                             ,anz_tage_wo1
                             ,anz_tage_wo2
                             ,anz_tage_wo3
                             ,vk_brutto_af_mittel
                             ,vk_brutto_sa_mittel
                             ,ums_gesamt_ausser_artikel
                             ,ums_gesamt_af_mit_wv
                             ,anz_markt_sa)
SELECT a.wup_id
      ,a.nb_id
      ,a.mandant_id
      ,a.mutter_id_wb AS art_id_werbung
      ,a.baseline AS baseline
      ,a.shopperwoche AS kjwo_werbe_ende
      ,a.min_dat_BL AS dat_baseline_von
      ,a.max_dat_BL AS dat_baseline_bis
      ,a.anz_af_maerkte AS anz_markt_baseline_af
      ,a.af_ums_netto AS ums_netto_baseline_af
      ,a.akt_ums_netto AS ums_netto_sa
      ,a.af_absatz AS menge_baseline_af
      ,a.akt_absatz AS menge_sa
      ,a.af_ertrag AS ertrag_baseline_af
      ,a.akt_ertrag AS ertrag_sa
      ,a.anz_kaeufer_af AS anz_kaeufer_af
      ,a.anz_bon_sa AS anz_kaeufer_sa
      ,a.anz_bon_af AS anz_bon_af
      ,a.anz_bon_sa AS anz_bon_sa
      ,a.anz_bon_aktion AS anz_bon_aktion
      ,a.RW_AF_Tage AS anz_tage_baseline_af
      ,a.RW_AKT_Tage AS anz_tage_sa
      ,a.BL_AF_KD_RW AS kaeufer_prozent_baseline_af
      ,a.BL_AKT_KD_RW AS kaeufer_prozent_sa
      ,a.CP_Kaeufer AS anz_cp_kaeufer
      ,a.CP_alle_70 AS anz_cp_kaeufer_70_prozent
      ,a.RestBon_AF AS ums_rest_bon_af
      ,a.RestBon_gesamt AS ums_rest_bon_gesamt
      ,a.akt_NP_Umsatz AS ums_aktivierter_normalpreis
      ,b.default_wrg AS wrg_id
      ,-1 AS aktion_thema_gruppe_id
      ,'' AS medien_kz
      ,0 AS menge_wo1
      ,0 AS menge_wo2
      ,0 AS menge_wo3
      ,0 AS anz_tage_wo1
      ,0 AS anz_tage_wo2
      ,0 AS anz_tage_wo3
      ,0 AS vk_brutto_af_mittel
      ,0 AS vk_brutto_sa_mittel
      ,a.ges_umsatz_ohne_art
      ,a.ges_umsatz_inkl_wv
      ,a.anz_markt_sa
FROM dbp_etl.bf_shopper_kmo a
JOIN dbp_data.mandant_2 b
  ON a.mandant_id = b.mandant_id
WHERE (a.mandant_id,a.shopperwoche) in (select mandant_id,woche_2 from _woche)
;

-- Updates fuer VK_2-Preise!

UPDATE dbp_data.shopper_2 FROM (SELECT a.mandant_id,
                                     a.wup_id,
                                     a.art_id_werbung,
                                     a.kjwo_werbe_ende,
                                     a.baseline,
                                     CAST(ZEROIFNULL((a.ums_netto_baseline_af/NULLIFZERO(a.menge_baseline_af))) * (c.mwst/100+1) AS DECIMAL(18,2)) AS vk_brutto_af_mittel,
                                     CAST(ZEROIFNULL((a.ums_netto_sa/NULLIFZERO(a.menge_sa))) * (c.mwst/100+1) AS DECIMAL(18,2)) AS vk_brutto_sa_mittel
                               FROM dbp_data.shopper_2 a
                               JOIN (SELECT mandant_id,
                                            kjwo_ww AS kjwo,
                                            MAX(dat) AS dat
                                     FROM dbp_data.werbewoche_kl_2
                               	WHERE kjwo >= 201601 AND
                                      mandant_id > 1
                               	GROUP BY 1,2) x
                                 ON a.kjwo_werbe_ende = x.kjwo and
                                    a.mandant_id = x.mandant_id
                               JOIN dbp_data.art_2 b
                                 ON a.mandant_id = b.mandant_id AND
                                    a.art_id_werbung = b.art_id
                               JOIN dbp_data.mwst_per_2 c
                                 ON a.mandant_id = c.mandant_id AND
                                    b.mwst_id = c.mwst_id AND
                                    x.dat BETWEEN c.dat_von AND c.dat_bis	 
                               WHERE (a.mandant_id,a.kjwo_werbe_ende) in (select mandant_id,woche_2 from _woche)
                               GROUP BY 1,2,3,4,5,6,7) b

SET vk_brutto_af_mittel = b.vk_brutto_af_mittel,
    vk_brutto_sa_mittel = b.vk_brutto_sa_mittel
    
WHERE dbp_data.shopper.mandant_id = b.mandant_id AND
      dbp_data.shopper.wup_id = b.wup_id AND
      dbp_data.shopper.art_id_werbung = b.art_id_werbung AND
      dbp_data.shopper.kjwo_werbe_ende = b.kjwo_werbe_ende AND
      dbp_data.shopper.baseline = b.baseline
;

CREATE OR REPLACE VOLATILE TABLE _upd AS (SELECT a.mandant_id,
                                                 a.wup_id,
                                                 a.art_id_werbung,
                                                 a.kjwo_werbe_ende,
                                                 MAX(x1.vk_aktion_brutto) AS max_vk_brutto_sa
                                          FROM dbp_data.shopper_2 a
                                          JOIN (SELECT mandant_id,
                                                       kjwo_ww AS kjwo,
                                                       MAX(dat) AS dat
                                                FROM dbp_data.werbewoche_kl_2
                                                WHERE kjwo >= 201601 AND
						      mandant_id > 1
                              	                GROUP BY 1,2) x
                                            ON a.kjwo_werbe_ende = x.kjwo and
                                               a.mandant_id = x.mandant_id
                                          JOIN (SELECT akt.mandant_id, 
						       akt.dat_von,
						       akt.dat_bis,
						       akta.wup_id,
						       akta.art_id,
						       akta.vk_aktion_brutto
						FROM dbp_data.aktion_2 akt
                                                JOIN dbp_data.aktion_art_wup_zu_2 akta
                                                  ON akt.aktion_id = akta.aktion_id AND 
                                                     akt.mandant_id = akta.mandant_id
                                                WHERE akta.grund_sperrung IS NULL AND
	                                              akt.mandant_id > 1) x1
                                            ON a.mandant_id = x1.mandant_id AND
					       a.wup_id = x1.wup_id AND
					       a.art_id_werbung = x1.art_id
                                          JOIN (SELECT mandant_id,
                                                       kjwo_ww AS kjwo,
                                                       MIN(dat) AS min_dat,
			                               MAX(dat) AS max_dat
                                                FROM dbp_data.werbewoche_kl_2
	                                        WHERE (mandant_id,kjwo) in (select mandant_id,woche_2 from _woche)
	                                        GROUP BY 1,2) x2
                                            ON x1.dat_bis BETWEEN x2.min_dat AND x2.max_dat and
                                               x1.mandant_id = x2.mandant_id
                                          WHERE (a.mandant_id,a.kjwo_werbe_ende) in (select mandant_id,woche_2 from _woche)
					  GROUP BY 1,2,3,4
);

UPDATE dbp_data.shopper_2 FROM (SELECT *
                              FROM _upd) b
							  
SET vk_brutto_sa_max = b.max_vk_brutto_sa

WHERE dbp_data.shopper.mandant_id = b.mandant_id AND
      dbp_data.shopper.wup_id = b.wup_id AND
      dbp_data.shopper.art_id_werbung = b.art_id_werbung AND
      dbp_data.shopper.kjwo_werbe_ende = b.kjwo_werbe_ende
;

-- Werbenachbetrachtung

-- fuer 3. Woche_2

UPDATE dbp_data.shopper_2 FROM (SELECT a.mandant_id,
                                      x0.kjwo,
                                      d.aktuell_wup_id as wup_id,
                                      x0.art_id AS art_id_werbung,
                                      SUM(COALESCE(a.menge/x0.mengen_faktor, a.menge)) AS menge,
                                      COUNT(DISTINCT a.dat) AS anz_mt
                               FROM dbp_data.artbew_2 a
                               JOIN dbp_data.werbewoche_kl_2 b
                                 ON a.dat = b.dat AND
                                    b.mandant_id > 1 AND
                                    a.mandant_id = b.mandant_id
                               join dbp_data.wup_2 d
                                 on a.mandant_id = d.mandant_id and
                                    a.wup_id = d.wup_id
                               JOIN (SELECT mandant_id,
                                            kjwo,
                                            wup_id,
                                            art_id,
                                            kl_art_id,
                                            MIN(mengen_faktor) AS mengen_faktor
                                     FROM dbp_process.bf_hit_the_actions_kmo_2
                                     WHERE (mandant_id,kjwo) in (select mandant_id,woche_wn3 from _woche)
                                     GROUP BY 1,2,3,4,5) x0
                                 ON a.mandant_id = x0.mandant_id AND
                                    floor(a.art_id/10) = x0.kl_art_id AND
                                    a.wup_id = x0.wup_id
                                WHERE (a.mandant_id,b.kjwo_ww) in (select mandant_id,woche_2 from _woche)
                                GROUP BY 1,2,3,4) b

SET menge_wo3 = b.menge,
    anz_tage_wo3 = b.anz_mt
    
WHERE dbp_data.shopper.mandant_id = b.mandant_id AND
      dbp_data.shopper.kjwo_werbe_ende = b.kjwo AND
      dbp_data.shopper.art_id_werbung = b.art_id_werbung AND
      dbp_data.shopper.wup_id = b.wup_id 
;

-- fuer 2. Woche_2

UPDATE dbp_data.shopper_2 FROM (SELECT a.mandant_id,
                                      x0.kjwo,
                                      d.aktuell_wup_id as wup_id,
                                      x0.art_id AS art_id_werbung,
                                      SUM(COALESCE(a.menge/x0.mengen_faktor, a.menge)) AS menge,
                                      COUNT(DISTINCT a.dat) AS anz_mt
                               FROM dbp_data.artbew_2 a
                               JOIN dbp_data.werbewoche_kl_2 b
                                 ON a.dat = b.dat AND
                                    b.mandant_id > 1 AND
                                    a.mandant_id = b.mandant_id
                               join dbp_data.wup_2 d
                                 on a.mandant_id = d.mandant_id and
                                    a.wup_id = d.wup_id
                               JOIN (SELECT mandant_id,
                                            kjwo,
                                            wup_id,
                                            art_id,
                                            kl_art_id,
                                            MIN(mengen_faktor) AS mengen_faktor
                                     FROM dbp_process.bf_hit_the_actions_kmo_2
                                     WHERE (mandant_id,kjwo) in (select mandant_id,woche_wn2 from _woche)
                                     GROUP BY 1,2,3,4,5) x0
                                 ON a.mandant_id = x0.mandant_id AND
                                    floor(a.art_id/10) = x0.kl_art_id AND
                                    a.wup_id = x0.wup_id
                               WHERE (a.mandant_id,b.kjwo_ww) in (select mandant_id,woche_2 from _woche)
                               GROUP BY 1,2,3,4) b

SET menge_wo2 = b.menge,
    anz_tage_wo2 = b.anz_mt
    
WHERE dbp_data.shopper.mandant_id = b.mandant_id AND
      dbp_data.shopper.kjwo_werbe_ende = b.kjwo AND
      dbp_data.shopper.art_id_werbung = b.art_id_werbung AND
      dbp_data.shopper.wup_id = b.wup_id 
;

-- fuer 1. Woche_2

UPDATE dbp_data.shopper_2 FROM (SELECT a.mandant_id,
                                      x0.kjwo,
                                      d.aktuell_wup_id as wup_id,
                                      x0.art_id AS art_id_werbung,
                                      SUM(COALESCE(a.menge/x0.mengen_faktor, a.menge)) AS menge,
                                      COUNT(DISTINCT a.dat) AS anz_mt
                               FROM dbp_data.artbew_2 a
                               JOIN dbp_data.werbewoche_kl_2 b
                                 ON a.dat = b.dat AND
                                    b.mandant_id > 1 AND
                                    a.mandant_id = b.mandant_id
                               join dbp_data.wup_2 d
                                 on a.mandant_id = d.mandant_id and
                                    a.wup_id = d.wup_id
                               JOIN (SELECT mandant_id,
                                            kjwo,
                                            wup_id,
                                            art_id,
                                            kl_art_id,
                                            MIN(mengen_faktor) AS mengen_faktor
                                     FROM dbp_process.bf_hit_the_actions_kmo_2
                                     WHERE (mandant_id,kjwo) in (select mandant_id,woche_wn1 from _woche)
                                     GROUP BY 1,2,3,4,5) x0
                                 ON a.mandant_id = x0.mandant_id AND
                                    floor(a.art_id/10) = x0.kl_art_id AND
                                    a.wup_id = x0.wup_id
                               WHERE (a.mandant_id,b.kjwo_ww) in (select mandant_id,woche_2 from _woche)
                               GROUP BY 1,2,3,4) b

SET menge_wo1 = b.menge,
    anz_tage_wo1 = b.anz_mt
    
WHERE dbp_data.shopper.mandant_id = b.mandant_id AND
      dbp_data.shopper.kjwo_werbe_ende = b.kjwo AND
      dbp_data.shopper.art_id_werbung = b.art_id_werbung AND
      dbp_data.shopper.wup_id = b.wup_id 
;
