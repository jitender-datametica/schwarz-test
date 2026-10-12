set (wkw) = (${WKW});

CREATE OR REPLACE VOLATILE TABLE _werbeartikel_1  (
  kjwo INTEGER,
  werbetyp_id BYTEINT,
  aktion_id VARCHAR(10),
  dat_von DATE,
  dat_bis DATE,
  wup_id INTEGER,
  mandant_id BYTEINT,
  art_id INTEGER,
  akt_wo SMALLINT,
  vk_brutto DECIMAL(9,2),
  mutter_wb_id INTEGER,
  avq_relevant_fg byteint,
  dat_sperrung date
);

INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       2 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
	  -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 6 = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,2) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       3 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
	  -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 2 = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,3) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x2.kjwo,
       3 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von+1 AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x2.akt_wo,
       0 AS vk_brutto,
      -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 7 AND
	 x1.akt_wo = $wkw-1
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 3 = x1.dat AND
	 x2.akt_wo = $wkw
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw-1 AND
      -- 04.10.2017, -dbay-
      -- Filter auf regulaere Wochenstartaktionen! Korrekturaktionen zu der Standardwerbewoche werden ausgespart!
	    akta.aktion_thema_id IN ('1072','1075','1310','4001','1300','1311','1312','1320','1330') AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,3) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       c.werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
      -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN (SELECT mandant_id,
             dat_von,
             dat_bis,
             werbe_typ_id AS werbetyp_id
      FROM dbp_data.ts_avq_werbezeitraum_abw
      WHERE mandant_id = 1) c
  ON akt.mandant_id = c.mandant_id AND
     akt.dat_von = c.dat_von AND
	 akt.dat_bis = c.dat_bis
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,c.werbetyp_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
                    
INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       15 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
      -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 9 = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,15) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
                    
INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       16 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
      -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 6
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 0 = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,16) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
                    
INSERT INTO _werbeartikel_1 (kjwo
                            ,werbetyp_id
                            ,aktion_id
                            ,dat_von
                            ,dat_bis
                            ,wup_id
                            ,mandant_id
                            ,art_id
                            ,akt_wo
                            ,vk_brutto
                            ,mutter_wb_id
                            ,avq_relevant_fg
                            ,dat_sperrung)
SELECT x1.kjwo,
       18 AS werbetyp_id,
       akta.aktion_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
      -999 AS mutter_wb_id,
	   max(case when (akta.dat_sperrung is null or akta.dat_sperrung >= akt.dat_von) then akt.avq_relevant_fg else 0 end) as avq_relevant_fg,
       max(coalesce(akta.dat_sperrung,'9999-12-31')) as dat_sperrung
FROM (select a.*,
             case when a.preisaktiviert_fg = 1 then 1 when b.bonuskauf_id is not null and a.preisaktiviert_fg = 0 then 0 else null end as avq_relevant_fg
      from dbp_data.aktion a
      left join (select *
                 from dbp_data.l_bonuskauf
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
      where a.mandant_id = 1 and
	       ((a.preisaktiviert_fg = 1) or 
	       ((b.bonuskauf_id is not null and 
		    a.preisaktiviert_fg = 0)))) akt
JOIN dbp_data.aktion_art_wup_zu akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 5
JOIN dbp_data.tag x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 1 = x1.dat
WHERE akt.mandant_id = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,18) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
                                        art_id
                                 FROM _werbeartikel_1
                                 GROUP BY 1,2)
GROUP BY 1,2,3
);

UPDATE _werbeartikel_1

SET mutter_wb_id = b.mutter_wb_id

FROM (SELECT *
      FROM _ff_mutter_art) b

WHERE _werbeartikel_1.mandant_id = b.mandant_id AND
      _werbeartikel_1.art_id = b.art_id AND
      _werbeartikel_1.mutter_wb_id = -999
;
                    
UPDATE _werbeartikel_1 SET mutter_wb_id = art_id
WHERE mutter_wb_id = -999
;

create or replace volatile table _pp as (
select a.*,
       cast(0 as decimal(18,4)) as vk_vor_aktion_brutto,
       cast(0 as decimal(18,4)) as vk_aktion_brutto,
       cast(0 as decimal(18,4)) as vk_kcard_brutto
from _werbeartikel_1 a
);

create or replace volatile table _werbeartikel_1 as (
select *
from _pp
);
                    
UPDATE _werbeartikel_1 

SET vk_brutto = b.vk_brutto

FROM (SELECT a.art_id,
             a.mandant_id,
             a.wup_id,
             MAX(a.vk_brutto) AS vk_brutto
      FROM dbp_data.art_wup_vk_per a
      JOIN _werbeartikel_1 b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.wup_id = b.wup_id AND
           b.dat_von BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3) b
			
 WHERE _werbeartikel_1.mandant_id = b.mandant_id AND
       _werbeartikel_1.wup_id = b.wup_id AND
       _werbeartikel_1.art_id = b.art_id
;

UPDATE _werbeartikel_1 
SET vk_vor_aktion_brutto = b.vk_vor_aktion_brutto,
    vk_aktion_brutto = b.vk_aktion_brutto
FROM (SELECT a.art_id,
             a.mandant_id,
             a.wup_id,
             b.werbetyp_id,
             MAX(a.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
             MIN(CASE WHEN a.vk_aktion_brutto > 0 THEN a.vk_aktion_brutto ELSE a.vk_vor_aktion_brutto END) as vk_aktion_brutto
      FROM dbp_data.aktion c
      join dbp_data.aktion_art_wup_zu a
        on c.mandant_id = a.mandant_id and
           c.aktion_id = a.aktion_id
      JOIN _werbeartikel_1 b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.wup_id = b.wup_id AND
           b.dat_von BETWEEN c.dat_von AND c.dat_bis
      GROUP BY 1,2,3,4) b
WHERE _werbeartikel_1.mandant_id = b.mandant_id AND
      _werbeartikel_1.wup_id = b.wup_id AND
      _werbeartikel_1.art_id = b.art_id AND
      _werbeartikel_1.werbetyp_id = b.werbetyp_id
;

update _werbeartikel_1 
set vk_kcard_brutto = b.vk_kcard_brutto
from (select a.art_id,
             a.mandant_id,
             a.wup_id,
             b.werbetyp_id,
             min(d.preis_aktion) as vk_kcard_brutto
      from dbp_data.aktion c
      join dbp_data.aktion_art_wup_zu a
        on c.mandant_id = a.mandant_id and
           c.aktion_id = a.aktion_id
      join dbp_data.pmr_angebot_art_wup_zu d
        on a.mandant_id and d.mandant_id and
           a.wup_id = d.wup_id and
           a.art_id = d.art_id and
           a.aktion_id = d.aktion_id
      join _werbeartikel_1 b
        on a.mandant_id = b.mandant_id and
           a.art_id = b.art_id and
           a.wup_id = b.wup_id and
           b.dat_von = c.dat_von and 
           b.dat_bis = c.dat_bis
      where d.preis_aktion <> 0 and
            c.aktion_typ_id <> 'KDP'
      group by 1,2,3,4) b
where _werbeartikel_1.mandant_id = b.mandant_id and
      _werbeartikel_1.wup_id = b.wup_id and
      _werbeartikel_1.art_id = b.art_id and
      _werbeartikel_1.werbetyp_id = b.werbetyp_id
;

DELETE FROM _werbeartikel_1
WHERE wup_id IN (SELECT wup_id FROM dbp_data.wup WHERE mandant_id = 1 AND wup_name_v LIKE '%online%')
;

create or replace volatile table _werbeartikel_1 as (
select a.kjwo,
       a.werbetyp_id,
       a.dat_von,
       a.dat_bis,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       a.akt_wo,
       a.vk_brutto,
       a.mutter_wb_id,
       max(a.avq_relevant_fg) as avq_relevant_fg,
       max(a.dat_sperrung) as dat_sperrung,
       max(a.vk_vor_aktion_brutto) as vk_vor_aktion_brutto,
       max(a.vk_aktion_brutto) as vk_aktion_brutto,
       max(a.vk_kcard_brutto) as vk_kcard_brutto
from _werbeartikel_1 a
group by 1,2,3,4,5,6,7,8,9,10
);

CREATE OR REPLACE VOLATILE TABLE _werbetyp_tage AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       CASE 
         -- kunftige und abgeschlossene aktionen volle anzahl tage
	 WHEN b.dat_von >= CURRENT_DATE OR b.dat_bis < CURRENT_DATE THEN b.dat_bis-b.dat_von+1
	 -- laufende aktionen anzahl tage start bis heute
	 ELSE CURRENT_DATE-b.dat_von 
       END AS anz_tage_aktion
FROM _werbeartikel_1 b
GROUP BY 1,2,3
);
                    
CREATE OR REPLACE VOLATILE TABLE _die_tage AS (
SELECT b.mandant_id,
       a.dat
FROM dbp_data.tag a
JOIN _werbeartikel_1 b
  ON a.dat BETWEEN b.dat_von AND b.dat_bis
GROUP BY 1,2
);
                    
create or replace volatile table _test1_ff as (
select w.kjwo,
       w.werbetyp_id,
       case
         when w.werbetyp_id = 1
         then w.dat_von+1
         else w.dat_von
       end as dat_von,
       w.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       sum(v.umsatz_netto) as umsatz_netto,
       sum(v.menge) as menge_,
       6-count(distinct v.dat) as tage_menge_0
from dbp_data.artbew v
join _werbeartikel_1 w
  on v.mandant_id = w.mandant_id and
     v.wup_id = w.wup_id and
     v.art_id = w.art_id and
     v.dat between w.dat_von and w.dat_bis
where (v.mandant_id,v.dat) in (select mandant_id,dat from _die_tage)
group by 1,2,3,4,5,6,7,8
having menge_ > 0
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we1 AS (
SELECT a.mandant_id,
       a.kjwo,
       a.dat_von,
       a.dat_bis,
       a.werbetyp_id,
       a.wup_id,
       a.nb_id,
       a.art_id
FROM _test1_ff a
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we2 AS (
SELECT a.*,
       b.dat,
       b.dat_2
FROM _ff_we1 a
JOIN (SELECT a.kjwo,
             a.werbetyp_id,
             CASE
	             WHEN b.dat BETWEEN a.dat_von AND a.dat_bis
               THEN b.dat
		           ELSE NULL
             END AS dat,
             CASE
	             WHEN b.dat NOT BETWEEN a.dat_von AND a.dat_bis
               THEN b.dat
               ELSE NULL
             END AS dat_2
      FROM _ff_we1 a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von-7 AND a.dat_bis
      GROUP BY 1,2,3,4) b
  ON a.kjwo = b.kjwo AND
     a.werbetyp_id = b.werbetyp_id
);
                    
CREATE OR REPLACE VOLATILE TABLE _track_feuerwerk AS (
SELECT a.mandant_id,
       a.art_id
FROM _ff_we2 a
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
	 b.arthiertyp_id = 2 AND
	 b.dat_bis = '9999-12-31'
WHERE b.wg_id = 805
GROUP BY 1,2
);
                    
DELETE FROM _ff_we2
WHERE (mandant_id,art_id) IN (SELECT mandant_id,art_id FROM _track_feuerwerk) AND
       dat IS NULL
;
                    
INSERT INTO _ff_we2
SELECT a.mandant_id,
       a.kjwo,
	   a.dat_von,
	   a.dat_bis,
	   a.werbetyp_id,
	   a.wup_id,
	   a.nb_id,
	   a.art_id,
       NULL AS dat,
	   c.dat AS dat_2
FROM _ff_we2 a
JOIN _track_feuerwerk b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id
JOIN dbp_data.tag c
  ON 1 = 1
WHERE a.dat IS NOT NULL AND
      c.dat BETWEEN a.dat_von-45 AND a.dat_von-1
GROUP BY 1,2,3,4,5,6,7,8,9,10
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we3 AS (
SELECT a.mandant_id,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.kjwo,
       COALESCE(a.dat,a.dat_2) AS dat,
       a.wup_id,
       a.nb_id,
       a.art_id,
       COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
       COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
FROM _ff_we2 a
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2
				 WHERE dat IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			      b.art_id = x.art_id AND
				    x.arthiertyp_id = 2 AND
				    x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	              c1.dat_best_beleg = c2.dat_best_beleg  AND
	              b.best_beleg_id = c2.best_beleg_id AND
	              b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	              b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
		             b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                         FROM dbp_data.lager_bewart_spr_zu
                                           WHERE mandant_id = 1 AND
                                                 spr_id = 22 AND
	                                               lager_bewart_bez LIKE '%Retoure%') AND
           	     CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1)  AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2 WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2 WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
           SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2
				 WHERE dat IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
		   WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                       FROM dbp_data.lager_bewart_spr_zu
                                           WHERE mandant_id = 1 AND
                                                 spr_id = 22 AND
	                                             lager_bewart_bez LIKE '%Retoure%') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2 WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2 WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat_buch  AND
	 a.werbetyp_id = b.werbetyp_id
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
                 b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2 WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2 WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
           SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
		   WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2 WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2 WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
           UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              c.dat_2 AS dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2-7
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
                 b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 30 AND mandant_id = 1) AND --NONFOOD
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2 WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2 WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_2 = c.dat_buch AND
	 a.werbetyp_id = c.werbetyp_id
);
                    
CREATE OR REPLACE VOLATILE TABLE _stpo AS (
SELECT a.mandant_id,
       a.stueckliste_id,
	   a.art_id AS kopf_art
FROM dbp_data.stueckliste a
WHERE a.dat_bis = '9999-12-31' AND
      a.mandant_id = 1
GROUP BY 1,2,3
);
                    
CREATE OR REPLACE VOLATILE TABLE _x_ray AS (
SELECT a.mandant_id,
       a.wup_id,
	   a.werbetyp_id,
	   b.kopf_art AS art_id,
	   a.dat,
	   a.dat_2
FROM (SELECT mandant_id,
             wup_id,
			 werbetyp_id,
             dat,
             dat_2
	  FROM _ff_we2
	  GROUP BY 1,2,3,4,5) a
JOIN (SELECT kopf_art
	  FROM _stpo
	  GROUP BY 1) b
  ON 1 = 1
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _help_me1 AS (
SELECT mandant_id,
       dat
FROM _x_ray
WHERE dat IS NOT NULL
GROUP BY 1,2
);
                    
CREATE OR REPLACE VOLATILE TABLE _help_me2 AS (
SELECT mandant_id,
       dat_2
FROM _x_ray
WHERE dat_2 IS NOT NULL
GROUP BY 1,2
);

create or replace volatile table _mseg_package_ekpo as (
select b.*
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
     a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
     a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
     c1.dat_best_beleg = c2.dat_best_beleg  AND
	   b.best_beleg_id = c2.best_beleg_id AND
	   b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	   b.art_id = c2.art_id
WHERE a.vorgangsart_id = 'WE' AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                        FROM dbp_data.lager_bewart_spr_zu
                            WHERE mandant_id = 1 AND
                                  spr_id = 22 AND
	                              lager_bewart_bez LIKE '%Retoure%') AND
	    CASE
        WHEN b.dat_buch < '2020-02-01' AND
             c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
        THEN 1
        WHEN b.dat_buch >= '2020-02-01' AND
             c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
        THEN 1
        ELSE 0
      END = 1 and
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me1 union SELECT min(dat_2) as dat FROM _help_me2)) and
      a.mandant_id = 1
);

create or replace volatile table _mseg_package_not_ekpo as (
select b.*
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
	 c1.dat_best_beleg = c2.dat_best_beleg  AND
	 b.best_beleg_id = c2.best_beleg_id AND
	 b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	 b.art_id = c2.art_id
WHERE a.vorgangsart_id = 'WE' AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                        FROM dbp_data.lager_bewart_spr_zu
                            WHERE mandant_id = 1 AND
                                  spr_id = 22 AND
	                              lager_bewart_bez LIKE '%Retoure%') AND
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me1 union SELECT min(dat_2) as dat FROM _help_me2)) and
      a.mandant_id = 1
);

CREATE OR REPLACE VOLATILE TABLE _x_track1 AS (
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo a
JOIN (SELECT *
      FROM _x_ray
      WHERE dat IS NOT NULL) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me1)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo a
JOIN (SELECT *
      FROM _x_ray
	  WHERE dat IS NOT NULL)  c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
	 a.art_id = x.art_id AND
	 x.arthiertyp_id = 2 AND
	 x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
     (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me1)
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _x_track2 AS (
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo a
JOIN (SELECT *
      FROM _x_ray
      WHERE dat_2 IS NOT NULL)  c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	   (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me2)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo a
JOIN (SELECT *
      FROM _x_ray
      WHERE dat_2 IS NOT NULL)  c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me2)
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _display_update AS (
SELECT b.mandant_id,
       c.werbetyp_id,
       b.wup_id,
	   b.art_id,
	   b.dat_buch,
	   SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN (SELECT c.mandant_id,
             c.werbetyp_id,
			 c.lagerbew_beleg_id,
	         c.wup_id,
	         b.art_id,
	         c.dat_buch
      FROM dbp_data.stueckliste a
      JOIN dbp_data.stueckliste_det b
        ON a.mandant_id = b.mandant_id AND
           a.stueckliste_id = b.stueckliste_id
      JOIN (SELECT a.mandant_id,
                   a.werbetyp_id,
				   c.lagerbew_beleg_id,
			       a.wup_id,
			       a.art_id,
			       a.dat_buch
            FROM _x_track1 a
            JOIN dbp_data.lagerbew b
              on a.mandant_id = b.mandant_id and
                 a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                 a.dat_buch = b.dat_buch
            JOIN dbp_data.lagerbew c
              on a.mandant_id = c.mandant_id and
                 b.ref_lagerbew_beleg_id = c.ref_lagerbew_beleg_id and
                 b.dat_buch = c.dat_buch
	        GROUP BY 1,2,3,4,5,6
	        UNION ALL
            SELECT a.mandant_id,
                   a.werbetyp_id,
				   c.lagerbew_beleg_id,
			       a.wup_id,
			       a.art_id,
			       a.dat_buch
            FROM _x_track2 a
            JOIN dbp_data.lagerbew b
              on a.mandant_id = b.mandant_id and
                 a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                 a.dat_buch = b.dat_buch
            JOIN dbp_data.lagerbew c
              on a.mandant_id = c.mandant_id and
                 b.ref_lagerbew_beleg_id = c.ref_lagerbew_beleg_id and
                 b.dat_buch = c.dat_buch
	        GROUP BY 1,2,3,4,5,6) c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id
        WHERE a.dat_bis = '9999-12-31'
        GROUP BY 1,2,3,4,5,6) c
  ON b.mandant_id = c.mandant_id AND
     b.wup_id = c.wup_id AND
	 b.art_id = c.art_id AND
	 b.dat_buch = c.dat_buch AND
	 b.lagerbew_beleg_id = c.lagerbew_beleg_id
WHERE a.vorgangsart_id IN ('WA','WE') AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                        FROM dbp_data.lager_bewart_spr_zu
                            WHERE mandant_id = 1 AND
                                  spr_id = 22 AND
	                              lager_bewart_bez LIKE '%Retoure%')
GROUP BY 1,2,3,4,5
);
                    
UPDATE _ff_we3 
SET we_menge = b.menge_lagerbew_bme+_ff_we3.we_menge

FROM (SELECT *
                     FROM _display_update) b
					  WHERE _ff_we3.mandant_id = b.mandant_id AND
      _ff_we3.wup_id = b.wup_id AND
	  _ff_we3.art_id = b.art_id AND
	  _ff_we3.werbetyp_id = b.werbetyp_id AND
	  _ff_we3.dat = b.dat_buch AND
	  _ff_we3.dat BETWEEN _ff_we3.dat_von AND _ff_we3.dat_bis
;
                    
UPDATE _ff_we3 
SET we_menge_2 = b.menge_lagerbew_bme+_ff_we3.we_menge_2

FROM (SELECT *
                     FROM _display_update) b
					  WHERE _ff_we3.mandant_id = b.mandant_id AND
      _ff_we3.wup_id = b.wup_id AND
	  _ff_we3.art_id = b.art_id AND
	  _ff_we3.werbetyp_id = b.werbetyp_id AND
	  _ff_we3.dat = b.dat_buch AND
	  _ff_we3.dat NOT BETWEEN _ff_we3.dat_von AND _ff_we3.dat_bis
;
                    
UPDATE _ff_we3 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
                            a.werbetyp_id,
                            a.wup_id,
                            a.art_id,
                            a.dat_von-3 AS min_dat
                     FROM _ff_we3 a
                     JOIN dbp_data.art_wg_zu_per x
                       ON a.mandant_id = x.mandant_id AND
                          a.art_id = x.art_id AND
	                      x.arthiertyp_id = 2 AND
	                      x.dat_bis = '9999-12-31'
                     WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 27 AND mandant_id = 1)
                     GROUP BY 1,2,3,4,5) b
 WHERE _ff_we3.mandant_id = b.mandant_id AND
      _ff_we3.wup_id = b.wup_id AND
	  _ff_we3.werbetyp_id = b.werbetyp_id AND
	  _ff_we3.art_id = b.art_id AND
	  _ff_we3.dat < b.min_dat
;
                    
UPDATE _ff_we3 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
                            a.werbetyp_id,
                            a.wup_id,
                            a.art_id,
							CASE
							  WHEN a.werbetyp_id = 3
							  THEN a.dat_von-3
							  ELSE a.dat_von-1 
							END AS min_dat
                     FROM _ff_we3 a
                     JOIN dbp_data.art_wg_zu_per x
                       ON a.mandant_id = x.mandant_id AND
                          a.art_id = x.art_id AND
	                      x.arthiertyp_id = 2 AND
	                      x.dat_bis = '9999-12-31'
                     WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 28 AND mandant_id = 1)
                     GROUP BY 1,2,3,4,5) b
 WHERE _ff_we3.mandant_id = b.mandant_id AND
      _ff_we3.wup_id = b.wup_id AND
	  _ff_we3.werbetyp_id = b.werbetyp_id AND
	  _ff_we3.art_id = b.art_id AND
	  _ff_we3.dat < b.min_dat
;
                    
UPDATE _ff_we3 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von AS min_dat
      FROM _ff_we3 a
      JOIN dbp_data.art_wg_zu_per x
        ON a.mandant_id = x.mandant_id AND
           a.art_id = x.art_id AND
	   x.arthiertyp_id = 2 AND
	   x.dat_bis = '9999-12-31'
      WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 50 AND mandant_id = 1)
      GROUP BY 1,2,3,4,5) b
WHERE _ff_we3.mandant_id = b.mandant_id AND
      _ff_we3.wup_id = b.wup_id AND
      _ff_we3.werbetyp_id = b.werbetyp_id AND
      _ff_we3.art_id = b.art_id AND
      _ff_we3.dat < b.min_dat
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we4 AS (
SELECT a.kjwo,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       a.nb_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_2,
       SUM(CAST(0 AS DECIMAL(18,3))) AS menge_aktionsstart
FROM _ff_we3 a
GROUP BY 1,2,3,4,5,6,7,8
);
                    
CREATE OR REPLACE VOLATILE TABLE _mbst_we1 AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_aktionsstart
FROM _ff_we4 v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             CASE
               WHEN werbetyp_id = 1
               THEN dat_von
               ELSE dat_von-1
             END AS dat_von,
             kjwo
      FROM _werbeartikel_1
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_von 
GROUP BY 1,2,3,4,5,6,7,8
);

UPDATE _ff_we4

SET menge_aktionsstart = b.menge_aktionsstart

FROM (SELECT *
      FROM _mbst_we1
      WHERE menge_aktionsstart <> 0) b

WHERE _ff_we4.mandant_id = b.mandant_id AND
      _ff_we4.wup_id = b.wup_id AND
      _ff_we4.nb_id = b.nb_id AND
      _ff_we4.art_id = b.art_id AND
      _ff_we4.kjwo = b.kjwo AND
      _ff_we4.werbetyp_id = b.werbetyp_id
;
                    
CREATE OR REPLACE VOLATILE TABLE _wup_kalender AS (
SELECT a.kjwo,
       a.werbetyp_id,
       a.mandant_id,
       a.wup_id,
       SUM(COALESCE(b.offen,1)) AS anz_offen
FROM (SELECT mandant_id,
             werbetyp_id,
             wup_id,
	         dat_von,
             dat_bis,
	         kjwo
      FROM _werbeartikel_1
      GROUP BY 1,2,3,4,5,6) a
LEFT JOIN (SELECT *
           FROM dbp_data.wupcal
	       WHERE (mandant_id,dat) IN (SELECT mandant_id,dat FROM _die_tage)) b
  ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     b.dat BETWEEN CASE
	                 WHEN a.werbetyp_id = 1
					 THEN a.dat_von+1
					 ELSE a.dat_von
				   END AND a.dat_bis
GROUP BY 1,2,3,4
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew AS (
SELECT w.kjwo,
       w.werbetyp_id,
       w.dat_von,
       w.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       MAX(v.posten_id) AS posten_id,
       SUM(CASE
	     WHEN x.wtag_id = 1
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_mo,
       SUM(CASE
	     WHEN x.wtag_id = 2
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_di,
       SUM(CASE
	     WHEN x.wtag_id = 3
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_mi,
       SUM(CASE
	     WHEN x.wtag_id = 4
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_do,
       SUM(CASE
	     WHEN x.wtag_id = 5
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_fr,
       SUM(CASE
	     WHEN x.wtag_id = 6
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_sa,
       SUM(CASE
	     WHEN x.wtag_id = 7
	     THEN v.umsatz_netto
	     ELSE 0
	   END) AS umsatz_netto_so,
       SUM(v.umsatz_netto) AS umsatz_netto_wo,
       SUM(CASE
	     WHEN x.wtag_id = 1
	     THEN v.menge
	     ELSE 0
           END) AS menge_mo,
       SUM(CASE
	     WHEN x.wtag_id = 2
	     THEN v.menge
	     ELSE 0
           END) AS menge_di,
       SUM(CASE
	     WHEN x.wtag_id = 3
	     THEN v.menge
	     ELSE 0
	   END) AS menge_mi,
       SUM(CASE
	     WHEN x.wtag_id = 4
	     THEN v.menge
	     ELSE 0
	   END) AS menge_do,
       SUM(CASE
	     WHEN x.wtag_id = 5
	     THEN v.menge
	     ELSE 0
	   END) AS menge_fr,
       SUM(CASE
	     WHEN x.wtag_id = 6
	     THEN v.menge
	     ELSE 0
	   END) AS menge_sa,
       SUM(CASE
	     WHEN x.wtag_id = 7
	     THEN v.menge
	     ELSE 0
	   END) AS menge_so,
       SUM(v.menge) AS menge_wo,
       sum(case when v.bewart_id = 1002 then v.menge else 0 end) as menge_sa2,
       MAX(z.anz_offen)-COUNT(DISTINCT v.dat) AS tage_menge_0,
       SUM(CAST(0 AS DECIMAL(18,3))) AS we_menge,
       SUM(CAST(0 AS DECIMAL(18,3))) AS menge_aktionsstart,
       SUM(CAST(0 AS DECIMAL(18,3))) AS we_menge_ab_vorwoche
FROM (SELECT a.*
      FROM dbp_data.artbew a
      WHERE (a.mandant_id,a.dat) IN (SELECT mandant_id,dat FROM _die_tage) AND
	         a.umsatz_netto > 0) v
JOIN _werbeartikel_1 w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.dat BETWEEN CASE 
	             WHEN w.werbetyp_id = 1 
                     THEN w.dat_von+1
                     ELSE w.dat_von
                   END AND w.dat_bis
JOIN dbp_data.tag x
  ON v.dat = x.dat
JOIN _wup_kalender z
  ON w.kjwo = z.kjwo AND
     v.wup_id = z.wup_id AND
     v.mandant_id = z.mandant_id AND
	 w.werbetyp_id = z.werbetyp_id
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst1 AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_endbestand
FROM _ff_we4 v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             dat_bis,
             kjwo
      FROM _werbeartikel_1
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_bis AND
     u.menge_lgbest_erp_frei_bme >= 0
GROUP BY 1,2,3,4,5,6,7,8
);
                    
CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2 AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_tage_null,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_tage_minus
FROM _ff_we4 v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1 a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7,8
);

create or replace volatile table _test_we_mbst2a as (
select v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       max(case
             when xx.gewart_id = 'ST' and x.menge_lgbest_erp_frei_bme = 0 then 1
             when xx.gewart_id = 'KG' and x.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
             when xx.gewart_id = 'G'  and x.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
             else 0
           end) as anz_null_tag1,
       0 as anz_null_tag2,
       0 as anz_null_tag3,
       0 as anz_null_tag4,
       0 as anz_null_tag5,
       0 as anz_null_tag6,
       0 as anz_null_tag7,
       max(case
             when xx.gewart_id = 'ST' and x.menge_lgbest_erp_frei_bme < 0 then 1
             when xx.gewart_id = 'KG' and x.menge_lgbest_erp_frei_bme < 0.000 then 1
             when xx.gewart_id = 'G'  and x.menge_lgbest_erp_frei_bme < 0.000 then 1
             else 0
           end) as anz_minus_tag1
from _ff_we4 v
join (select a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      from _werbeartikel_1 a
      join dbp_data.tag b
        on b.dat = a.dat_von
      group by 1,2,3,4,5,6,7,8) w
  on v.mandant_id = w.mandant_id and
     v.wup_id = w.wup_id and
     v.art_id = w.art_id and
     v.werbetyp_id = w.werbetyp_id and
    (v.kjwo = w.kjwo or
     v.kjwo = w.kjwo-1)
join dbp_data.art xx
  on v.mandant_id = xx.mandant_id and
     v.art_id = xx.art_id
left join dbp_data.marktbestand_erp x
  on w.mandant_id = x.mandant_id and
     w.wup_id = x.wup_id and
     w.art_id = x.art_id and
     w.dat = x.dat and
     x.dat < current_date
group by 1,2,3,4,5,6,7,8
);

-- Anzahl Nullbestand Tag 2

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag2
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+1 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag2 = b.anz_null_tag2

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 3

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag3
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+2 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag3 = b.anz_null_tag3

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 4

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag4
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+3 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag4 = b.anz_null_tag4

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 5

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag5
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+4 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag5 = b.anz_null_tag5

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 6

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag6
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+5 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag6 = b.anz_null_tag6

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 7

update _test_we_mbst2a from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag7
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+6 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag7 = b.anz_null_tag7

where _test_we_mbst2a.mandant_id = b.mandant_id and
      _test_we_mbst2a.wup_id = b.wup_id and
      _test_we_mbst2a.art_id = b.art_id and
      _test_we_mbst2a.dat_von = b.dat_von and
      _test_we_mbst2a.dat_bis = b.dat_bis and
      _test_we_mbst2a.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2b AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1_bis_tag3,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1_bis_tag3
FROM _ff_we4 v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1 a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis AND
           b.dat BETWEEN a.dat_von AND a.dat_von+2
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _ff_we5 AS (
SELECT a.kjwo,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
       SUM(a.menge_aktionsstart) AS menge_aktionsstart,
       SUM(b.menge_endbestand) AS menge_endbestand
FROM _ff_we4 a
JOIN _test_we_mbst1 b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
	 a.werbetyp_id = b.werbetyp_id
GROUP BY 1,2,3,4,5,6,7,8
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew1 AS (
SELECT a.*,
       CAST(0 AS DECIMAL(18,3)) AS menge_endbestand,
       CAST(0 AS DECIMAL(18,3)) AS min_sicherh_bestand,
       CAST(1 AS DECIMAL(9,3)) AS faktor_flaki,
       CAST(0 AS INTEGER) AS anzahl_nullbestand,
       CAST(0 AS INTEGER) AS anzahl_tage_aktion,
       CAST(0 AS DECIMAL(18,3)) AS menge_historie_af,
       CAST(0 AS DECIMAL(18,3)) AS sollbestand,
       CAST(0 AS SMALLINT) AS lager_prozent,
       CAST(0 AS SMALLINT) AS mhd_zeitraum,
       CAST(0 AS DECIMAL(18,3)) AS menge_bestand_soll_max,
       CAST(0 AS DECIMAL(9,3)) AS menge_tag1_7bis13h,
       CAST(0 AS DECIMAL(9,3)) AS menge_nur_tag1,
       CAST(-1 AS BYTEINT) AS bezugsweg_id,
       CAST(0 AS DECIMAL(18,3)) AS we_menge_vor_aktion,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag1,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag2,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag3,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag4,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag5,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag6,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag7,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag1bis3,
       CAST(0 AS INTEGER) AS anzahl_minusbestand,
       CAST(0 AS INTEGER) AS anzahl_minusbestand_tag1,
       CAST(0 AS INTEGER) AS anzahl_minusbestand_tag1bis3
FROM _ff_we_artbew a
);

UPDATE _ff_we_artbew1 
SET we_menge = b.we_menge,
    we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
-- 08.01.2019, -dbay-
--
-- Auf Wunsch der Laender wird nun die Menge der Vorwoche auch fuer DE
-- separat ausgewiesen, obwohl wir Vorwoche und laufende Woche der Aktion
-- zusammen im Feld "we_menge_zentral" fuer DE (!) ausweisen.
    we_menge_vor_aktion = b.we_menge_ab_vorwoche,
    menge_aktionsstart = b.menge_aktionsstart,
    menge_endbestand = b.menge_endbestand,
    min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand,
-- 08.01.2019, -dbay-
--
-- Zuspielen des Bezugsweg, um JOIN im FED zu vermeiden!
    bezugsweg_id = b.bezugsweg_id

FROM (SELECT a.*,
             f.min_sicherh_bestand,
             f.sollbestand,
             f.bezugsweg_id
      FROM _ff_we5 a
      LEFT JOIN dbp_data.art_wup_status_per f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.nb_id = f.nb_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1 
SET mhd_zeitraum = b.mhd_zeitraum,
    lager_prozent = b.lager_prozent

FROM (SELECT a.*,
             f.mhd_zeitraum,
             f.lager_prozent
      FROM _ff_we5 a
      LEFT JOIN dbp_data.art f
        ON a.mandant_id = f.mandant_id AND
           a.art_id = f.art_id) b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1 
SET menge_bestand_soll_max = b.menge_bestand_soll_max

FROM (SELECT a.*,
             f.menge_bestand_soll_max
      FROM _ff_we5 a
      LEFT JOIN dbp_data.art_wup_nachschub_per f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.nb_id = f.nb_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
CREATE OR REPLACE VOLATILE TABLE _fix_it_de AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_tag1_7bis13h 
FROM dbp_ods.ods_bon_verkauf a
JOIN _werbeartikel_1 b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) = b.dat_von AND
     b.wup_id = a.wup_id AND
     CAST(b.art_id/100 as INTEGER) = a.kl_art_id AND
     CAST(a.start_bon_zeile AS TIME) BETWEEN '07:00:00' AND '13:00:00'
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id
      FROM _werbeartikel_1 a
      JOIN dbp_data.wupcal b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.dat_von = b.dat
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5
HAVING menge_tag1_7bis13h > 0
);
                    
INSERT INTO _fix_it_de
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_tag1_7bis13h 
FROM dbp_ods.ods_bon_verkauf a
JOIN _werbeartikel_1 b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) BETWEEN b.dat_von AND b.dat_bis AND
     b.wup_id = a.wup_id AND
     CAST(b.art_id/100 as INTEGER) = a.kl_art_id AND
     CAST(a.start_bon_zeile AS TIME) BETWEEN '07:00:00' AND '13:00:00'
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id,
             MIN(b.dat) AS min_dat
      FROM (SELECT a.mandant_id,
                   a.wup_id,
                   a.werbetyp_id,
                   a.dat_von,
                   a.dat_bis
            FROM _werbeartikel_1 a
            JOIN dbp_data.wupcal b
              ON a.mandant_id = b.mandant_id AND
                 a.wup_id = b.wup_id AND
                 a.dat_von = b.dat
            WHERE b.offen = 0
            GROUP BY 1,2,3,4,5) a
      JOIN dbp_data.wupcal b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           b.dat BETWEEN a.dat_von AND a.dat_bis
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id AND
     CAST(a.start_bon_zeile AS DATE) = x.min_dat
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5
HAVING menge_tag1_7bis13h > 0
;
                    
--
-- Comment by: David Bandeira 03.01.2024
-- Quickfix EVT3544309 / Removing all duplicates from _fix_it_de using a distinct in subselect. 
-- Add distinct in codeline 1881
-- This Quickfix need a review by Dennis Bayraktar
--

UPDATE _ff_we_artbew1 
SET menge_tag1_7bis13h = b.menge_tag1_7bis13h
FROM (SELECT  distinct *
      FROM _fix_it_de) b
WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;

--

CREATE OR REPLACE VOLATILE TABLE _fix_it_de2 AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_nur_tag1
FROM dbp_ods.ods_bon_verkauf a
JOIN _werbeartikel_1 b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) = b.dat_von AND
     b.wup_id = a.wup_id AND
     CAST(b.art_id/100 as INTEGER) = a.kl_art_id
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id
      FROM _werbeartikel_1 a
      JOIN dbp_data.wupcal b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.dat_von = b.dat
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5
HAVING menge_nur_tag1 > 0
);
                    
INSERT INTO _fix_it_de2
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_nur_tag1
FROM dbp_ods.ods_bon_verkauf a
JOIN _werbeartikel_1 b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) BETWEEN b.dat_von AND b.dat_bis AND
     b.wup_id = a.wup_id AND
     CAST(b.art_id/100 as INTEGER) = a.kl_art_id
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id,
             MIN(b.dat) AS min_dat
      FROM (SELECT a.mandant_id,
                   a.wup_id,
                   a.werbetyp_id,
                   a.dat_von,
                   a.dat_bis
            FROM _werbeartikel_1 a
            JOIN dbp_data.wupcal b
              ON a.mandant_id = b.mandant_id AND
                 a.wup_id = b.wup_id AND
                 a.dat_von = b.dat
            WHERE b.offen = 0
            GROUP BY 1,2,3,4,5) a
      JOIN dbp_data.wupcal b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           b.dat BETWEEN a.dat_von AND a.dat_bis
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id AND
     CAST(a.start_bon_zeile AS DATE) = x.min_dat
WHERE a.mandant_id = 1
GROUP BY 1,2,3,4,5
HAVING menge_nur_tag1 > 0
;

UPDATE _ff_we_artbew1 
SET menge_nur_tag1 = b.menge_nur_tag1
FROM (SELECT distinct *
      FROM _fix_it_de2) b
WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                
UPDATE _ff_we_artbew1

SET anzahl_nullbestand = b.anz_tage_null,
    anzahl_minusbestand = b.anz_tage_minus

FROM (SELECT *
      FROM _test_we_mbst2) b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1

SET anzahl_nullbestand_tag1 = b.anz_null_tag1,
    anzahl_nullbestand_tag2 = b.anz_null_tag2,
    anzahl_nullbestand_tag3 = b.anz_null_tag3,
    anzahl_nullbestand_tag4 = b.anz_null_tag4,
    anzahl_nullbestand_tag5 = b.anz_null_tag5,
    anzahl_nullbestand_tag6 = b.anz_null_tag6,
    anzahl_nullbestand_tag7 = b.anz_null_tag7,
    anzahl_minusbestand_tag1 = b.anz_minus_tag1

FROM (SELECT *
      FROM _test_we_mbst2a) b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1
 
SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
    anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3

FROM (SELECT *
      FROM _test_we_mbst2b) b

WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.nb_id = b.nb_id AND
      _ff_we_artbew1.art_id = b.art_id AND
      _ff_we_artbew1.kjwo = b.kjwo AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1 
SET menge_historie_af = b.menge_historie_af

FROM (SELECT a.mandant_id,
                                   a.wup_id,
                                   a.art_id,
                                   SUM(d.menge)/36.000 AS menge_historie_af
                            FROM _ff_we_artbew1 a
                            JOIN dbp_data.woche b
                              ON a.kjwo = b.kjwo
                            JOIN dbp_data.woche_kj_kl c
                              ON c.akt_wo BETWEEN b.akt_wo-6 AND b.akt_wo-1
                            JOIN dbp_data.artbew_wo_sum d
                              ON a.mandant_id = d.mandant_id AND
                                 a.wup_id = d.wup_id AND
	                             a.art_id = d.art_id AND
	                             c.kjwo_kl = d.kjwo_kl
                            WHERE d.bewart_id = 1001 AND
							      d.menge >= 0
                            GROUP BY 1,2,3) b
							 WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.wup_id = b.wup_id AND
      _ff_we_artbew1.art_id = b.art_id
;
                    
UPDATE _ff_we_artbew1 
SET anzahl_tage_aktion = b.anz_tage_aktion

FROM (SELECT mandant_id,
                                   werbetyp_id,
                                   MAX(anz_tage_aktion) AS anz_tage_aktion
                            FROM _werbetyp_tage
                            GROUP BY 1,2) b
							 WHERE _ff_we_artbew1.mandant_id = b.mandant_id AND
      _ff_we_artbew1.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1 SET we_menge_ab_vorwoche = we_menge+we_menge_ab_vorwoche
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew2 AS (
SELECT a.*,
       b.wtag_id AS wtag_id_start,
       c.wtag_id AS wtag_id_ende,
       -- 14.09.2016, -dbay-
       -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
       w.mutter_wb_id,
       w.avq_relevant_fg,
       w.vk_vor_aktion_brutto,
       w.vk_aktion_brutto,
       w.vk_kcard_brutto
FROM _ff_we_artbew1 a
JOIN dbp_data.tag b
  ON CASE
       WHEN a.werbetyp_id = 1
       THEN a.dat_von+1
       ELSE a.dat_von
     END = b.dat
JOIN dbp_data.tag c
  ON a.dat_bis = c.dat
JOIN _werbeartikel_1 w
  ON a.mandant_id = w.mandant_id AND
     a.wup_id = w.wup_id AND
     a.art_id = w.art_id AND
     a.dat_von BETWEEN w.dat_von AND w.dat_bis AND
     a.werbetyp_id = w.werbetyp_id
);

DELETE FROM dbp_data.werbung_kennzahlen_woche
WHERE (mandant_id,wup_id,nb_id,art_id,kjwo,werbe_typ_id) IN (SELECT mandant_id,wup_id,nb_id,art_id,kjwo,werbetyp_id FROM _ff_we_artbew2)
;
                    
INSERT INTO dbp_data.werbung_kennzahlen_woche (kjwo
                                              ,wup_id
                                              ,nb_id
                                              ,mandant_id
                                              ,art_id
                                              ,werbe_typ_id
                                              ,menge_tag1
                                              ,menge_tag2
                                              ,menge_tag3
                                              ,menge_tag4
                                              ,menge_tag5
                                              ,menge_tag6
                                              ,menge_tag7
                                              ,tage_menge_0       
                                              ,menge_endbestand   
                                              ,menge_aktionsstart 
                                              ,umsatz_netto_tag1    
                                              ,umsatz_netto_tag2  
                                              ,umsatz_netto_tag3  
                                              ,umsatz_netto_tag4  
                                              ,umsatz_netto_tag5
                                              ,umsatz_netto_tag6
                                              ,umsatz_netto_tag7  
                                              ,we_menge           
                                              ,min_sicherh_bestand
                                              ,posten_id
                                              ,we_menge_zentral
                                              ,faktor_flaki
                                              ,mutter_wb_id
                                              ,wtag_id_start
                                              ,wtag_id_ende
                                              ,menge_historie_af
                                              ,anzahl_nullbestand
                                              ,anzahl_tage_aktion
                                              ,menge_tag1_7bis13h
                                              ,menge_nur_tag1
                                              ,lager_prozent
                                              ,mhd_zeitraum
                                              ,sollbestand
                                              ,menge_bestand_soll_max
                                              ,werbenachvermarktung_fg
                                              ,art_mutter_bezugsweg_id
                                              ,we_menge_vor_aktion
                                              ,anzahl_nullbestand_tag1
                                              ,anzahl_nullbestand_tag1bis3
                                              ,anzahl_minusbestand
                                              ,anzahl_minusbestand_tag1
                                              ,anzahl_minusbestand_tag1bis3
                                              ,avq_relevant_fg
                                              ,wrg_id
                                              ,anzahl_nullbestand_tag2
                                              ,anzahl_nullbestand_tag3
                                              ,anzahl_nullbestand_tag4
                                              ,anzahl_nullbestand_tag5
                                              ,anzahl_nullbestand_tag6
                                              ,anzahl_nullbestand_tag7
                                              ,vk_vor_aktion_brutto
                                              ,vk_aktion_brutto
                                              ,vk_kcard_brutto
                                              ,menge_sa
                                              ,td_insert
                                              ,td_update)
SELECT kjwo               
      ,wup_id             
      ,nb_id              
      ,mandant_id         
      ,art_id
      ,werbetyp_id AS werbe_typ_id
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_mo
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_do
		 WHEN werbetyp_id IN (16)
		 THEN menge_sa
         WHEN werbetyp_id IN (18)
		 THEN menge_fr
		 ELSE 0
	   END AS menge_tag1
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_di
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_fr
		 WHEN werbetyp_id IN (16)
		 THEN menge_so
         WHEN werbetyp_id IN (18)
		 THEN menge_sa
		 ELSE 0
	   END AS menge_tag2
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_mi
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_sa
		 WHEN werbetyp_id IN (16)
		 THEN menge_mo
         WHEN werbetyp_id IN (18)
		 THEN menge_so
		 ELSE 0
	   END AS menge_tag3
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_do
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_so
		 WHEN werbetyp_id IN (16)
		 THEN menge_di
         WHEN werbetyp_id IN (18)
		 THEN menge_mo
		 ELSE 0
	   END AS menge_tag4
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_fr
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_mo
		 WHEN werbetyp_id IN (16)
		 THEN menge_mi
         WHEN werbetyp_id IN (18)
		 THEN menge_di
		 ELSE 0
	   END AS menge_tag5
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_sa
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_di
		 WHEN werbetyp_id IN (16)
		 THEN menge_do
         WHEN werbetyp_id IN (18)
		 THEN menge_mi
		 ELSE 0
	   END AS menge_tag6
	  ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_so
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_mi
		 WHEN werbetyp_id IN (16)
		 THEN menge_fr
         WHEN werbetyp_id IN (18)
		 THEN menge_do
		 ELSE 0
	   END AS menge_tag7
      ,tage_menge_0       
      ,menge_endbestand   
      ,menge_aktionsstart 
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_mo
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_do
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_sa
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_fr
		 ELSE 0
	   END AS umsatz_netto_tag1    
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_di
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_fr
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_so
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_sa
		 ELSE 0
	   END AS umsatz_netto_tag2
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_mi
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_sa
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_mo
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_so
		 ELSE 0
	   END AS umsatz_netto_tag3   
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_do
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_so
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_di
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_mo
		 ELSE 0
	   END AS umsatz_netto_tag4
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_fr
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_mo
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_mi
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_di
		 ELSE 0
	   END AS umsatz_netto_tag5
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_sa
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_di
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_do
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_mi
		 ELSE 0
	   END AS umsatz_netto_tag6
	  ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_so
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_mi
		 WHEN werbetyp_id IN (16)
		 THEN umsatz_netto_fr
         WHEN werbetyp_id IN (18)
		 THEN umsatz_netto_do
		 ELSE 0
	   END AS umsatz_netto_tag7
      ,we_menge
      ,COALESCE(min_sicherh_bestand,0) AS min_sicherh_bestand
      ,posten_id
      ,we_menge_ab_vorwoche AS we_menge_zentral
	  ,faktor_flaki
	  ,COALESCE(mutter_wb_id,art_id) AS mutter_wb_id
	  ,wtag_id_start
	  ,wtag_id_ende
	  ,menge_historie_af
      ,case when anzahl_tage_aktion < anzahl_nullbestand then anzahl_tage_aktion else anzahl_nullbestand end as anzahl_nullbestand
      ,anzahl_tage_aktion
      ,COALESCE(menge_tag1_7bis13h,0)
      ,COALESCE(menge_nur_tag1,0)
      ,COALESCE(lager_prozent,0)
      ,COALESCE(mhd_zeitraum,0)
      ,COALESCE(sollbestand,0)
      ,COALESCE(menge_bestand_soll_max,0)
      ,0 AS werbenachvermarktung_fg
      ,COALESCE(bezugsweg_id,-1)
      ,COALESCE(we_menge_vor_aktion,0)
      ,anzahl_nullbestand_tag1
      ,anzahl_nullbestand_tag1bis3
      ,anzahl_minusbestand
      ,anzahl_minusbestand_tag1
      ,anzahl_minusbestand_tag1bis3
      ,avq_relevant_fg
      ,'EUR' as wrg_id
      ,anzahl_nullbestand_tag2
      ,anzahl_nullbestand_tag3
      ,anzahl_nullbestand_tag4
      ,anzahl_nullbestand_tag5
      ,anzahl_nullbestand_tag6
      ,anzahl_nullbestand_tag7
      ,vk_vor_aktion_brutto
      ,vk_aktion_brutto
      ,vk_kcard_brutto
      ,menge_sa2
      ,current_timestamp
      ,current_timestamp
FROM _ff_we_artbew2
;

CREATE OR REPLACE VOLATILE TABLE _not_in1 AS (
SELECT *
FROM _werbeartikel_1
WHERE (kjwo,wup_id,mandant_id,art_id,werbetyp_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _ff_we_artbew2)
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we1_not_in AS (
SELECT a.mandant_id,
       a.kjwo,
	   a.dat_von,
	   a.dat_bis,
	   a.werbetyp_id,
       a.wup_id,
       a.art_id
FROM _not_in1 a
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we2_not_in AS (
SELECT a.*,
       b.dat,
       b.dat_2
FROM _ff_we1_not_in a
JOIN (SELECT a.kjwo,
             a.werbetyp_id,
             CASE
	           WHEN b.dat BETWEEN a.dat_von AND a.dat_bis
		       THEN b.dat
		       ELSE NULL
	         END AS dat,
	         CASE
	           WHEN b.dat NOT BETWEEN a.dat_von AND a.dat_bis
		       THEN b.dat
		       ELSE NULL
	         END AS dat_2
      FROM _ff_we1_not_in a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von-7 AND a.dat_bis
      GROUP BY 1,2,3,4) b
  ON a.kjwo = b.kjwo AND
     a.werbetyp_id = b.werbetyp_id
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we3_not_in AS (
SELECT a.mandant_id,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.kjwo,
       COALESCE(a.dat,a.dat_2) AS dat,
       a.wup_id,
       a.art_id,
       COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
       COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
FROM _ff_we2_not_in a
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2_not_in
				 WHERE dat IS NOT NULL)  c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2_not_in
				 WHERE dat IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
		   WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
           UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              c.dat_2 AS dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2_not_in
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2-7
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
                 b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 30 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat_buch  AND
	 a.werbetyp_id = b.werbetyp_id
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2_not_in
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             CASE
           	       WHEN b.dat_buch < '2020-02-01' AND
           	            c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
           	       THEN 1
           	       WHEN b.dat_buch >= '2020-02-01' AND
           	            c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew a
           JOIN dbp_data.lagerbew_det b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN (SELECT *
		         FROM _ff_we2_not_in
				 WHERE dat_2 IS NOT NULL) c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
		   WHERE a.vorgangsart_id = 'WE' AND
		         b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                                   FROM dbp_data.lager_bewart_spr_zu
                                       WHERE mandant_id = 1 AND
                                             spr_id = 22 AND
	                                         lager_bewart_bez LIKE '%Retoure%') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
				 a.mandant_id = 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_2 = c.dat_buch AND
	 a.werbetyp_id = c.werbetyp_id
);
                    
CREATE OR REPLACE VOLATILE TABLE _x_ray_not_in AS (
SELECT a.mandant_id,
       a.wup_id,
	   a.werbetyp_id,
	   b.kopf_art AS art_id,
	   a.dat,
	   a.dat_2
FROM (SELECT mandant_id,
             wup_id,
			 werbetyp_id,
             dat,
             dat_2
	  FROM _ff_we2_not_in
	  GROUP BY 1,2,3,4,5) a
JOIN (SELECT kopf_art
	  FROM _stpo
	  GROUP BY 1) b
  ON 1 = 1
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _help_me11 AS (
SELECT mandant_id,
       dat
FROM _x_ray_not_in
WHERE dat IS NOT NULL
GROUP BY 1,2
);
                    
CREATE OR REPLACE VOLATILE TABLE _help_me22 AS (
SELECT mandant_id,
       dat_2
FROM _x_ray_not_in
WHERE dat_2 IS NOT NULL
GROUP BY 1,2
);

create or replace volatile table _mseg_package_ekpo_not_in as (
select b.*
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
     a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
     a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
     c1.dat_best_beleg = c2.dat_best_beleg  AND
	   b.best_beleg_id = c2.best_beleg_id AND
	   b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	   b.art_id = c2.art_id
WHERE a.vorgangsart_id = 'WE' AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                        FROM dbp_data.lager_bewart_spr_zu
                            WHERE mandant_id = 1 AND
                                  spr_id = 22 AND
	                              lager_bewart_bez LIKE '%Retoure%') AND
	    CASE
        WHEN b.dat_buch < '2020-02-01' AND
             c1.bestellart_id IN ('ZLNS','ZLN','UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
        THEN 1
        WHEN b.dat_buch >= '2020-02-01' AND
             c1.bestellart_id IN ('UBE','ZDZA','ZLLA','ZLA','ZLAS','ZAME','ZWRP','UBGK','UBG1','UBG2','ZWWL' )
        THEN 1
        ELSE 0
      END = 1 and
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me11 union SELECT min(dat_2) as dat FROM _help_me22)) and
      a.mandant_id = 1
);

create or replace volatile table _mseg_package_not_ekpo_not_in as (
select b.*
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
	 c1.dat_best_beleg = c2.dat_best_beleg  AND
	 b.best_beleg_id = c2.best_beleg_id AND
	 b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	 b.art_id = c2.art_id
WHERE a.vorgangsart_id = 'WE' AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                        FROM dbp_data.lager_bewart_spr_zu
                            WHERE mandant_id = 1 AND
                                  spr_id = 22 AND
	                              lager_bewart_bez LIKE '%Retoure%') AND
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me11 union SELECT min(dat_2) as dat FROM _help_me22)) and
      a.mandant_id = 1
);
                    
CREATE OR REPLACE VOLATILE TABLE _x_track1_not_in AS (
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo_not_in a
JOIN (SELECT *
      FROM _x_ray_not_in
      WHERE dat IS NOT NULL) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	   (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me11)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo_not_in a
JOIN (SELECT *
      FROM _x_ray_not_in
      WHERE dat IS NOT NULL) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	   (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me11)
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _x_track2_not_in AS (
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo_not_in a
JOIN (SELECT *
      FROM _x_ray_not_in
      WHERE dat_2 IS NOT NULL) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
	   (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me22)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo_not_in a
JOIN (SELECT *
      FROM _x_ray_not_in
      WHERE dat_2 IS NOT NULL) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 25 AND mandant_id = 1) AND
     (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me22)
GROUP BY 1,2,3,4,5,6
);
                    
CREATE OR REPLACE VOLATILE TABLE _display_update_not_in AS (
SELECT b.mandant_id,
       c.werbetyp_id,
       b.wup_id,
	   b.art_id,
	   b.dat_buch,
	   SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM dbp_data.lagerbew a
JOIN dbp_data.lagerbew_det b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN (SELECT c.mandant_id,
             c.werbetyp_id,
			 c.lagerbew_beleg_id,
	         c.wup_id,
	         b.art_id,
	         c.dat_buch
      FROM dbp_data.stueckliste a
      JOIN dbp_data.stueckliste_det b
        ON a.mandant_id = b.mandant_id AND
           a.stueckliste_id = b.stueckliste_id
      JOIN (SELECT mandant_id,
                   werbetyp_id,
				   lagerbew_beleg_id,
			       wup_id,
			       art_id,
			       dat_buch
            FROM _x_track1_not_in
	        GROUP BY 1,2,3,4,5,6
	        UNION ALL
            SELECT mandant_id,
                   werbetyp_id,
				   lagerbew_beleg_id,
			       wup_id,
			       art_id,
			       dat_buch
            FROM _x_track2_not_in
	        GROUP BY 1,2,3,4,5,6) c
        ON a.mandant_id = c.mandant_id AND
           a.art_id = c.art_id
        WHERE a.dat_bis = '9999-12-31'
        GROUP BY 1,2,3,4,5,6) c
  ON b.mandant_id = c.mandant_id AND
     b.wup_id = c.wup_id AND
	 b.art_id = c.art_id AND
	 b.dat_buch = c.dat_buch AND
	 b.lagerbew_beleg_id = c.lagerbew_beleg_id
WHERE a.vorgangsart_id = 'WE' AND
      b.lager_bewart_id NOT IN (SELECT lager_bewart_id
	                            FROM dbp_data.lager_bewart_spr_zu
                                WHERE mandant_id = 1 AND
                                      spr_id = 22 AND
	                                  lager_bewart_bez LIKE '%Retoure%')
GROUP BY 1,2,3,4,5
);
                    
UPDATE _ff_we3_not_in 
SET we_menge = b.menge_lagerbew_bme+_ff_we3_not_in.we_menge

FROM (SELECT *
                            FROM _display_update_not_in) b
					  WHERE _ff_we3_not_in.mandant_id = b.mandant_id AND
      _ff_we3_not_in.wup_id = b.wup_id AND
	  _ff_we3_not_in.art_id = b.art_id AND
	  _ff_we3_not_in.werbetyp_id = b.werbetyp_id AND
	  _ff_we3_not_in.dat = b.dat_buch AND
	  _ff_we3_not_in.dat BETWEEN _ff_we3_not_in.dat_von AND _ff_we3_not_in.dat_bis
;
                    
UPDATE _ff_we3_not_in 
SET we_menge_2 = b.menge_lagerbew_bme+_ff_we3_not_in.we_menge_2

FROM (SELECT *
                            FROM _display_update_not_in) b
					  WHERE _ff_we3_not_in.mandant_id = b.mandant_id AND
      _ff_we3_not_in.wup_id = b.wup_id AND
	  _ff_we3_not_in.art_id = b.art_id AND
	  _ff_we3_not_in.werbetyp_id = b.werbetyp_id AND
	  _ff_we3_not_in.dat = b.dat_buch AND
	  _ff_we3_not_in.dat NOT BETWEEN _ff_we3_not_in.dat_von AND _ff_we3_not_in.dat_bis
;
                    
UPDATE _ff_we3_not_in 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
                                   a.werbetyp_id,
                                   a.wup_id,
                                   a.art_id,
                                   a.dat_von-3 AS min_dat
                            FROM _ff_we3_not_in a
                            JOIN dbp_data.art_wg_zu_per x
                              ON a.mandant_id = x.mandant_id AND
                                 a.art_id = x.art_id AND
	                             x.arthiertyp_id = 2 AND
	                             x.dat_bis = '9999-12-31'
                            WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 27 AND mandant_id = 1)
                            GROUP BY 1,2,3,4,5) b
 WHERE _ff_we3_not_in.mandant_id = b.mandant_id AND
      _ff_we3_not_in.wup_id = b.wup_id AND
	  _ff_we3_not_in.werbetyp_id = b.werbetyp_id AND
	  _ff_we3_not_in.art_id = b.art_id AND
	  _ff_we3_not_in.dat < b.min_dat
;
                    
UPDATE _ff_we3_not_in 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
                                   a.werbetyp_id,
                                   a.wup_id,
                                   a.art_id,
                                   CASE
								     WHEN a.werbetyp_id = 3
									 THEN a.dat_von-3
									 ELSE a.dat_von-1 
								   END AS min_dat
                            FROM _ff_we3_not_in a
                            JOIN dbp_data.art_wg_zu_per x
                              ON a.mandant_id = x.mandant_id AND
                                 a.art_id = x.art_id AND
	                             x.arthiertyp_id = 2 AND
	                             x.dat_bis = '9999-12-31'
                            WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 28 AND mandant_id = 1)
                            GROUP BY 1,2,3,4,5) b
 WHERE _ff_we3_not_in.mandant_id = b.mandant_id AND
      _ff_we3_not_in.wup_id = b.wup_id AND
	  _ff_we3_not_in.werbetyp_id = b.werbetyp_id AND
	  _ff_we3_not_in.art_id = b.art_id AND
	  _ff_we3_not_in.dat < b.min_dat
;
                    
UPDATE _ff_we3_not_in 
SET we_menge_2 = 0

FROM (SELECT a.mandant_id,
                                   a.werbetyp_id,
                                   a.wup_id,
                                   a.art_id,
                                   a.dat_von AS min_dat
                            FROM _ff_we3_not_in a
                            JOIN dbp_data.art_wg_zu_per x
                              ON a.mandant_id = x.mandant_id AND
                                 a.art_id = x.art_id AND
	                             x.arthiertyp_id = 2 AND
	                             x.dat_bis = '9999-12-31'
                            WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 12 AND mandant_id = 1)
					        GROUP BY 1,2,3,4,5) b
 WHERE _ff_we3_not_in.mandant_id = b.mandant_id AND
      _ff_we3_not_in.wup_id = b.wup_id AND
	  _ff_we3_not_in.werbetyp_id = b.werbetyp_id AND
	  _ff_we3_not_in.art_id = b.art_id AND
	  _ff_we3_not_in.dat < b.min_dat
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we4_not_in AS (
SELECT a.kjwo,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_2,
       SUM(CAST(0 AS DECIMAL(18,3))) AS menge_aktionsstart
FROM _ff_we3_not_in a
GROUP BY 1,2,3,4,5,6,7
);
                    
CREATE OR REPLACE VOLATILE TABLE _mbst_we1_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_aktionsstart
FROM _ff_we4_not_in v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             CASE
               WHEN werbetyp_id = 1
               THEN dat_von
               ELSE dat_von-1
             END AS dat_von,
             kjwo
      FROM _werbeartikel_1
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_von 
GROUP BY 1,2,3,4,5,6,7
);
                    
UPDATE _ff_we4_not_in

SET menge_aktionsstart = b.menge_aktionsstart

FROM (SELECT *
      FROM _mbst_we1_not_in
      WHERE menge_aktionsstart <> 0) b

WHERE _ff_we4_not_in.mandant_id = b.mandant_id AND
      _ff_we4_not_in.wup_id = b.wup_id AND
      _ff_we4_not_in.art_id = b.art_id AND
      _ff_we4_not_in.kjwo = b.kjwo AND
      _ff_we4_not_in.werbetyp_id = b.werbetyp_id
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_not_in AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
	                                art_id
	                         FROM _ff_we4_not_in
				 GROUP BY 1,2)
GROUP BY 1,2,3
);
                    
CREATE OR REPLACE VOLATILE TABLE _test_we_mbst1_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_endbestand
FROM _ff_we4_not_in v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             dat_bis,
             kjwo
      FROM _werbeartikel_1
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_bis AND
     u.menge_lgbest_erp_frei_bme >= 0
GROUP BY 1,2,3,4,5,6,7
);
                    
CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_tage_null,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_tage_minus
FROM _ff_we4_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1 a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);
                    
CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2a_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1,
       0 as anz_null_tag2,
       0 as anz_null_tag3,
       0 as anz_null_tag4,
       0 as anz_null_tag5,
       0 as anz_null_tag6,
       0 as anz_null_tag7,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1
FROM _ff_we4_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1 a
      JOIN dbp_data.tag b
        ON b.dat = a.dat_von
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);

-- Anzahl Nullbestand Tag 2

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag2
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+1 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag2 = b.anz_null_tag2

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 3

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag3
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+2 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag3 = b.anz_null_tag3

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 4

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag4
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+3 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag4 = b.anz_null_tag4

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 5

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag5
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+4 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag5 = b.anz_null_tag5

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 6

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag6
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+5 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag6 = b.anz_null_tag6

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag 7

update _test_we_mbst2a_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag7
                             from dbp_data.marktbestand_erp a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1 a
                                   join dbp_data.tag b
                                     on b.dat = a.dat_von+6 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag7 = b.anz_null_tag7

where _test_we_mbst2a_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_not_in.art_id = b.art_id and
      _test_we_mbst2a_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_not_in.werbetyp_id = b.werbetyp_id
;
                    
CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2b_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1_bis_tag3,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1_bis_tag3
FROM _ff_we4_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1 a
      JOIN dbp_data.tag b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis AND
           b.dat BETWEEN a.dat_von AND a.dat_von+2
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we5_not_in AS (
SELECT a.kjwo,
       a.werbetyp_id,
       a.dat_von,
       a.dat_bis,
       a.mandant_id,
       a.wup_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
       SUM(a.menge_aktionsstart) AS menge_aktionsstart,
       SUM(b.menge_endbestand) AS menge_endbestand
FROM _ff_we4_not_in a
JOIN _test_we_mbst1_not_in b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.werbetyp_id = b.werbetyp_id
GROUP BY 1,2,3,4,5,6,7
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew1_not_in LIKE _ff_we_artbew1;
                    
INSERT INTO _ff_we_artbew1_not_in (kjwo
                                  ,werbetyp_id
                                  ,dat_von
                                  ,dat_bis
                                  ,wup_id
                                  ,mandant_id
                                  ,art_id
                                  ,nb_id
                                  ,posten_id
                                  ,umsatz_netto_mo
                                  ,umsatz_netto_di
                                  ,umsatz_netto_mi
                                  ,umsatz_netto_do
                                  ,umsatz_netto_fr
                                  ,umsatz_netto_sa
                                  ,umsatz_netto_so
                                  ,umsatz_netto_wo
                                  ,menge_mo
                                  ,menge_di
                                  ,menge_mi
                                  ,menge_do
                                  ,menge_fr
                                  ,menge_sa
                                  ,menge_so
                                  ,menge_wo
                                  ,tage_menge_0
                                  ,we_menge
                                  ,menge_aktionsstart
                                  ,we_menge_ab_vorwoche
                                  ,menge_endbestand
                                  ,min_sicherh_bestand
                                  ,faktor_flaki
                                  ,anzahl_nullbestand
                                  ,anzahl_tage_aktion
	                          ,menge_historie_af
                                  ,sollbestand
                                  ,lager_prozent
                                  ,mhd_zeitraum
                                  ,menge_bestand_soll_max
                                  ,menge_tag1_7bis13h
                                  ,menge_nur_tag1
                                  ,bezugsweg_id
                                  ,we_menge_vor_aktion
                                  ,anzahl_nullbestand_tag1
                                  ,anzahl_nullbestand_tag1bis3
                                  ,anzahl_minusbestand
                                  ,anzahl_minusbestand_tag1
                                  ,anzahl_minusbestand_tag1bis3
                                  ,anzahl_nullbestand_tag2
                                  ,anzahl_nullbestand_tag3
                                  ,anzahl_nullbestand_tag4
                                  ,anzahl_nullbestand_tag5
                                  ,anzahl_nullbestand_tag6
                                  ,anzahl_nullbestand_tag7)
SELECT kjwo
      ,werbetyp_id
      ,dat_von
      ,dat_bis
      ,wup_id
      ,mandant_id
      ,art_id
      ,0 AS nb_id
      ,'' AS posten_id
      ,0 AS umsatz_netto_mo
      ,0 AS umsatz_netto_di
      ,0 AS umsatz_netto_mi
      ,0 AS umsatz_netto_do
      ,0 AS umsatz_netto_fr
      ,0 AS umsatz_netto_sa
      ,0 AS umsatz_netto_so
      ,0 AS umsatz_netto_wo
      ,0 AS menge_mo
      ,0 AS menge_di
      ,0 AS menge_mi
      ,0 AS menge_do
      ,0 AS menge_fr
      ,0 AS menge_sa
      ,0 AS menge_so
      ,0 AS menge_wo
      ,CASE
         WHEN werbetyp_id IN (1,2)
         THEN 6
         WHEN werbetyp_id IN (18)
         THEN 2
         ELSE 3
       END AS tage_menge_0
      ,0 AS we_menge
      ,0 AS menge_aktionsstart
      ,0 AS we_menge_ab_vorwoche
      ,0 AS menge_endbestand
      ,0 AS min_sicherh_bestand
      ,1 AS faktor_flaki
      ,0 AS anzahl_nullbestand
      ,0 AS anzahl_tage_aktion
      ,0 AS menge_historie_af
      ,0 AS sollbestand
      ,0 AS lager_prozent
      ,0 AS mhd_zeitraum
      ,0 AS menge_bestand_soll_max
      ,0 AS menge_tag1_7bis13h
      ,0 AS menge_nur_tag1
      ,-1 AS bezugsweg_id
      ,0 AS we_menge_vor_aktion
      ,0 AS anzahl_nullbestand_tag1
      ,0 AS anzahl_nullbestand_tag1bis3
      ,0 AS anzahl_minusbestand
      ,0 AS anzahl_minusbestand_tag1
      ,0 AS anzahl_minusbestand_tag1bis3
      ,0 AS anzahl_nullbestand_tag2
      ,0 AS anzahl_nullbestand_tag3
      ,0 AS anzahl_nullbestand_tag4
      ,0 AS anzahl_nullbestand_tag5
      ,0 AS anzahl_nullbestand_tag6
      ,0 AS anzahl_nullbestand_tag7
FROM _not_in1
;

UPDATE _ff_we_artbew1_not_in 
SET we_menge = b.we_menge,
    we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
    we_menge_vor_aktion = b.we_menge_ab_vorwoche,
    menge_aktionsstart = b.menge_aktionsstart,
    menge_endbestand = b.menge_endbestand,
    min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand,
    bezugsweg_id = b.bezugsweg_id

FROM (SELECT a.*,
             f.min_sicherh_bestand,
             f.sollbestand,
             f.bezugsweg_id
      FROM _ff_we5_not_in a
      LEFT JOIN dbp_data.art_wup_status_per f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b

WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET mhd_zeitraum = b.mhd_zeitraum,
    lager_prozent = b.lager_prozent

FROM (SELECT a.*,
             f.mhd_zeitraum,
             f.lager_prozent
      FROM _ff_we5_not_in a
      LEFT JOIN dbp_data.art f
        ON a.mandant_id = f.mandant_id AND
           a.art_id = f.art_id) b

WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET menge_bestand_soll_max = b.menge_bestand_soll_max

FROM (SELECT a.*,
             f.menge_bestand_soll_max
      FROM _ff_we5_not_in a
      LEFT JOIN dbp_data.art_wup_nachschub_per f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b

WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET anzahl_nullbestand = b.anz_tage_null,
    anzahl_minusbestand = b.anz_tage_minus

FROM (SELECT *
      FROM _test_we_mbst2_not_in) b

WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET anzahl_nullbestand_tag1 = b.anz_null_tag1,
    anzahl_minusbestand_tag1 = b.anz_minus_tag1,
    anzahl_nullbestand_tag2 = b.anz_null_tag2,
    anzahl_nullbestand_tag3 = b.anz_null_tag3,
    anzahl_nullbestand_tag4 = b.anz_null_tag4,
    anzahl_nullbestand_tag5 = b.anz_null_tag5,
    anzahl_nullbestand_tag6 = b.anz_null_tag6,
    anzahl_nullbestand_tag7 = b.anz_null_tag7
FROM (SELECT *
      FROM _test_we_mbst2a_not_in) b
WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
	  _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
    anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
FROM (SELECT *
      FROM _test_we_mbst2b_not_in) b
WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id AND
      _ff_we_artbew1_not_in.kjwo = b.kjwo AND
	  _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET menge_historie_af = b.menge_historie_af

FROM (SELECT a.mandant_id,
                                          a.wup_id,
                                          a.art_id,
                                          SUM(d.menge)/36.000 AS menge_historie_af
                                   FROM _ff_we_artbew1_not_in a
                                   JOIN dbp_data.woche b
                                     ON a.kjwo = b.kjwo
                                   JOIN dbp_data.woche_kj_kl c
                                     ON c.akt_wo BETWEEN b.akt_wo-6 AND b.akt_wo-1
                                   JOIN dbp_data.artbew_wo_sum d
                                     ON a.mandant_id = d.mandant_id AND
                                        a.wup_id = d.wup_id AND
	                                    a.art_id = d.art_id AND
	                                    c.kjwo_kl = d.kjwo_kl
                                   WHERE d.bewart_id = 1001 AND
								         d.menge >= 0
                                   GROUP BY 1,2,3) b
							 WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_not_in.art_id = b.art_id
;
                    
UPDATE _ff_we_artbew1_not_in 
SET anzahl_tage_aktion = b.anz_tage_aktion

FROM (SELECT mandant_id,
                                          werbetyp_id,
                                          MAX(anz_tage_aktion) AS anz_tage_aktion
                                   FROM _werbetyp_tage
                                   GROUP BY 1,2) b
							 WHERE _ff_we_artbew1_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_not_in.werbetyp_id = b.werbetyp_id
;
                    
UPDATE _ff_we_artbew1_not_in SET we_menge_ab_vorwoche = we_menge+we_menge_ab_vorwoche
;
                    
CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew2_not_in AS(
SELECT a.*,
       b.wtag_id AS wtag_id_start,
       c.wtag_id AS wtag_id_ende,
       -- 14.09.2016, -dbay-
       -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
       COALESCE(w.mutter_wb_id,d.mutter_wb_id) AS mutter_wb_id,
       w.avq_relevant_fg,
       w.vk_vor_aktion_brutto,
       w.vk_aktion_brutto,
       w.vk_kcard_brutto
FROM _ff_we_artbew1_not_in a
JOIN dbp_data.tag b
  ON CASE
       WHEN a.werbetyp_id = 1
       THEN a.dat_von+1
       ELSE a.dat_von
     END = b.dat
JOIN dbp_data.tag c
  ON a.dat_bis = c.dat
JOIN _werbeartikel_1 w
  ON a.mandant_id = w.mandant_id AND
     a.wup_id = w.wup_id AND
     a.art_id = w.art_id AND
     a.dat_von BETWEEN w.dat_von AND w.dat_bis AND
	 a.werbetyp_id = w.werbetyp_id
LEFT JOIN _ff_mutter_art d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
);
                    
DELETE FROM dbp_data.werbung_kennzahlen_woche
WHERE (kjwo,werbe_typ_id,wup_id,art_id) IN (SELECT kjwo,werbetyp_id,wup_id,art_id FROM _ff_we_artbew2_not_in)
;
                    
INSERT INTO dbp_data.werbung_kennzahlen_woche (kjwo               
                                              ,wup_id             
                                              ,nb_id              
                                              ,mandant_id         
                                              ,art_id
                                              ,werbe_typ_id
                                              ,menge_tag1       
                                              ,menge_tag2         
                                              ,menge_tag3         
                                              ,menge_tag4         
                                              ,menge_tag5         
                                              ,menge_tag6
                                              ,menge_tag7
                                              ,tage_menge_0       
                                              ,menge_endbestand   
                                              ,menge_aktionsstart 
                                              ,umsatz_netto_tag1    
                                              ,umsatz_netto_tag2  
                                              ,umsatz_netto_tag3  
                                              ,umsatz_netto_tag4  
                                              ,umsatz_netto_tag5
                                              ,umsatz_netto_tag6
                                              ,umsatz_netto_tag7  
                                              ,we_menge           
                                              ,min_sicherh_bestand
                                              ,posten_id
                                              ,we_menge_zentral
                                              ,faktor_flaki
                                              ,mutter_wb_id
                                              ,wtag_id_start
                                              ,wtag_id_ende
                                              ,menge_historie_af
                                              ,anzahl_nullbestand
                                              ,anzahl_tage_aktion
                                              ,menge_tag1_7bis13h
                                              ,menge_nur_tag1
                                              ,lager_prozent
                                              ,mhd_zeitraum
                                              ,sollbestand
                                              ,menge_bestand_soll_max
                                              ,werbenachvermarktung_fg
                                              ,art_mutter_bezugsweg_id
                                              ,we_menge_vor_aktion
                                              ,anzahl_nullbestand_tag1
                                              ,anzahl_nullbestand_tag1bis3
                                              ,anzahl_minusbestand
                                              ,anzahl_minusbestand_tag1
                                              ,anzahl_minusbestand_tag1bis3
                                              ,avq_relevant_fg
                                              ,wrg_id
                                              ,anzahl_nullbestand_tag2
                                              ,anzahl_nullbestand_tag3
                                              ,anzahl_nullbestand_tag4
                                              ,anzahl_nullbestand_tag5
                                              ,anzahl_nullbestand_tag6
                                              ,anzahl_nullbestand_tag7
                                              ,vk_vor_aktion_brutto
                                              ,vk_aktion_brutto
                                              ,vk_kcard_brutto
                                              ,menge_sa
                                              ,td_insert
                                              ,td_update)
SELECT kjwo               
      ,wup_id             
      ,nb_id              
      ,mandant_id         
      ,art_id
	  ,werbetyp_id AS werbe_typ_id
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_mo
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_do
		 ELSE 0
	   END AS menge_tag1
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_di
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_fr
		 ELSE 0
	   END AS menge_tag2
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_mi
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_sa
		 ELSE 0
	   END AS menge_tag3
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_do
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_so
		 ELSE 0
	   END AS menge_tag4
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_fr
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_mo
		 ELSE 0
	   END AS menge_tag5
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_sa
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_di
		 ELSE 0
	   END AS menge_tag6
	  ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN menge_so
		 WHEN werbetyp_id IN (2,4,15)
		 THEN menge_mi
		 ELSE 0
	   END AS menge_tag7
      ,tage_menge_0       
      ,menge_endbestand   
      ,menge_aktionsstart 
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_mo
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_do
		 ELSE 0
	   END AS umsatz_netto_tag1    
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_di
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_fr
		 ELSE 0
	   END AS umsatz_netto_tag2
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_mi
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_sa
		 ELSE 0
	   END AS umsatz_netto_tag3   
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_do
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_so
		 ELSE 0
	   END AS umsatz_netto_tag4
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_fr
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_mo
		 ELSE 0
	   END AS umsatz_netto_tag5
      ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_sa
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_di
		 ELSE 0
	   END AS umsatz_netto_tag6
	  ,CASE
	     WHEN werbetyp_id IN (1,3)
		 THEN umsatz_netto_so
		 WHEN werbetyp_id IN (2,4,15)
		 THEN umsatz_netto_mi
		 ELSE 0
	   END AS umsatz_netto_tag7
      ,we_menge
      ,COALESCE(min_sicherh_bestand,0) AS min_sicherh_bestand
      ,posten_id
      ,we_menge_ab_vorwoche AS we_menge_zentral
	  ,faktor_flaki
	  ,COALESCE(mutter_wb_id,art_id) AS mutter_wb_id
	  ,wtag_id_start
	  ,wtag_id_ende
	  ,menge_historie_af
      ,case when anzahl_tage_aktion < anzahl_nullbestand then anzahl_tage_aktion else anzahl_nullbestand end as anzahl_nullbestand
      ,anzahl_tage_aktion
      ,COALESCE(menge_tag1_7bis13h,0)
      ,COALESCE(menge_nur_tag1,0)
      ,COALESCE(lager_prozent,0)
      ,COALESCE(mhd_zeitraum,0)
      ,COALESCE(sollbestand,0)
      ,COALESCE(menge_bestand_soll_max,0)
      ,0 AS werbenachvermarktung_fg
      ,COALESCE(bezugsweg_id,-1)
      ,COALESCE(we_menge_vor_aktion,0)
      ,anzahl_nullbestand_tag1
      ,anzahl_nullbestand_tag1bis3
      ,COALESCE(anzahl_minusbestand,0)
      ,COALESCE(anzahl_minusbestand_tag1,0)
      ,COALESCE(anzahl_minusbestand_tag1bis3,0)
      ,avq_relevant_fg
      ,'EUR' as wrg_id
      ,COALESCE(anzahl_nullbestand_tag2,0)
      ,COALESCE(anzahl_nullbestand_tag3,0)
      ,COALESCE(anzahl_nullbestand_tag4,0)
      ,COALESCE(anzahl_nullbestand_tag5,0)
      ,COALESCE(anzahl_nullbestand_tag6,0)
      ,COALESCE(anzahl_nullbestand_tag7,0)
      ,vk_vor_aktion_brutto
      ,vk_aktion_brutto
      ,vk_kcard_brutto
      ,COALESCE(menge_sa,0)
      ,current_timestamp
      ,current_timestamp
FROM _ff_we_artbew2_not_in
;
                    
CREATE OR REPLACE VOLATILE TABLE _preis_mutter AS (
SELECT a.mandant_id,
       a.kjwo,
       a.wup_id,
	   a.werbe_typ_id,
       a.mutter_wb_id,
	   x.vk_brutto AS preis
FROM dbp_data.werbung_kennzahlen_woche a
JOIN _werbeartikel_1 x
  ON a.kjwo = x.kjwo AND
     a.werbe_typ_id = x.werbetyp_id AND
	 a.mandant_id = x.mandant_id AND
	 a.wup_id = x.wup_id AND
	 a.mutter_wb_id = x.art_id
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.mutter_wb_id = b.art_id AND
	 b.dat_bis = '9999-12-31' AND
	 b.arthiertyp_id = 2
WHERE a.mutter_wb_id = a.art_id AND
	  b.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 31 AND mandant_id = 1) AND
	  a.kjwo IN (SELECT kjwo FROM dbp_data.tag WHERE akt_wo = $wkw) AND
	  preis <> 0
);
                    
CREATE OR REPLACE VOLATILE TABLE _preis_kind AS (
SELECT a.mandant_id,
       a.kjwo,
	   a.werbe_typ_id,
       a.wup_id,
	   a.art_id,
       a.mutter_wb_id,
	   x.vk_brutto AS preis_kind,
	   b.preis AS preis_mutter,
	   CAST(COALESCE(CAST(preis_mutter AS DECIMAL(18,6))/NULLIFZERO(CAST(preis_kind AS DECIMAL(18,6))),1) AS DECIMAL(18,6)) AS faktor
FROM dbp_data.werbung_kennzahlen_woche a
JOIN _werbeartikel_1 x
  ON a.kjwo = x.kjwo AND
     a.werbe_typ_id = x.werbetyp_id AND
	 a.mandant_id = x.mandant_id AND
	 a.wup_id = x.wup_id AND
	 a.art_id = x.art_id
JOIN _preis_mutter b
  ON a.mandant_id = b.mandant_id AND
     a.mutter_wb_id = b.mutter_wb_id AND
	 a.wup_id = b.wup_id AND
	 a.kjwo = b.kjwo AND
	 a.werbe_typ_id = b.werbe_typ_id
WHERE faktor IS NOT NULL
);
                    
UPDATE dbp_data.werbung_kennzahlen_woche 
SET faktor_flaki = b.faktor

FROM (SELECT *
      FROM _preis_kind
      GROUP BY 1,2,3,4,5,6,7,8,9) b

WHERE dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id AND
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id AND
      dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo AND
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id AND
      dbp_data.werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id AND
      dbp_data.werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id
;
                    
DELETE FROM dbp_data.werbung_kennzahlen_woche
WHERE (mandant_id,art_id) IN (SELECT mandant_id,kopf_art FROM _stpo) AND
       menge_tag1+menge_tag2+menge_tag3+menge_tag4+menge_tag5+menge_tag6+menge_tag7 = 0 AND
	   kjwo IN (SELECT kjwo FROM dbp_data.tag WHERE akt_wo = $wkw)
;
                    
CREATE OR REPLACE VOLATILE TABLE _raus_xxx AS (
SELECT a.*
FROM dbp_data.werbung_kennzahlen_woche a
WHERE a.mandant_id = 1 AND
      a.kjwo IN (SELECT kjwo FROM dbp_data.tag WHERE akt_wo = $wkw) AND
	  a.menge_tag1+a.menge_tag2+a.menge_tag3+a.menge_tag4+a.menge_tag5+a.menge_tag6+a.menge_tag7 = 0 AND
	  a.we_menge_zentral <> 0 AND
	 (a.mandant_id,a.art_id) IN (SELECT mandant_id,
                                        art_id 
                                 FROM dbp_etl_process.art_gtin 
                                 GROUP BY 1,2
                                 HAVING COUNT(DISTINCT gtin_typ_id) = 1 AND
                                        MAX(gtin_typ_id) = 'IE')
);
                    
DELETE FROM dbp_data.werbung_kennzahlen_woche
WHERE (kjwo,mandant_id,wup_id,art_id,werbe_typ_id) IN (SELECT kjwo,mandant_id,wup_id,art_id,werbe_typ_id FROM _raus_xxx)
;

CREATE OR REPLACE VOLATILE TABLE _we_upd_candidates AS (
SELECT a.kjwo,
       a.werbe_typ_id,
       a.mandant_id,
	   a.wup_id,
	   a.art_id,
       a.mutter_wb_id,
       SUM(a.we_menge_zentral) AS we_menge_zentral,
       SUM(a.menge_tag1+a.menge_tag2+a.menge_tag3+a.menge_tag4+
           a.menge_tag5+a.menge_tag6+a.menge_tag7) AS menge_
FROM dbp_data.werbung_kennzahlen_woche a
JOIN dbp_data.art_wg_zu_per b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
WHERE b.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu WHERE wg_filter_id = 44 AND mandant_id = 1) AND
	  a.mandant_id = 1 AND
	  a.kjwo IN (SELECT kjwo FROM dbp_data.tag WHERE akt_wo = $wkw)
GROUP BY 1,2,3,4,5,6
HAVING SUM(we_menge_zentral) = 0 AND
       menge_ <> 0
);
                    
CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_we_upd AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art a
WHERE a.dat_bis = '9999-12-31' AND
      a.mandant_id = 1
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _singles AS (
SELECT mutter_wb_id
FROM _ff_mutter_art_we_upd
GROUP BY 1
HAVING COUNT(*) = 1
);
                    
DELETE FROM _we_upd_candidates
WHERE (mutter_wb_id) IN (SELECT mutter_wb_id FROM _singles)
;
                    
CREATE OR REPLACE VOLATILE TABLE _multiples AS (
SELECT mutter_wb_id,
       COUNT(*) AS anzahl
FROM _ff_mutter_art_we_upd
GROUP BY 1
HAVING COUNT(*) > 1
);
                    
DELETE FROM _we_upd_candidates
WHERE (mandant_id,kjwo,werbe_typ_id,mutter_wb_id) IN (SELECT a.mandant_id,
                                                             a.kjwo,
                                                             a.werbe_typ_id,
                                                             a.mutter_wb_id
                                                      FROM dbp_data.werbung_kennzahlen_woche a
                                                      JOIN _multiples b
                                                        ON a.mutter_wb_id = b.mutter_wb_id
                                                      WHERE a.mandant_id = 1 AND
                                                            a.kjwo IN (SELECT kjwo FROM dbp_data.tag WHERE akt_wo = $wkw)
                                                      GROUP BY 1,2,3,4
                                                      HAVING SUM(a.we_menge_zentral) = 0)
;
                    
UPDATE dbp_data.werbung_kennzahlen_woche 
SET we_menge_zentral = 0.001

FROM (SELECT *
                                                FROM _we_upd_candidates) b
                                                       WHERE dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo AND
      dbp_data.werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id AND
      dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id AND
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id AND
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id AND
      dbp_data.werbung_kennzahlen_woche.we_menge_zentral = 0
;
                    
CREATE OR REPLACE VOLATILE TABLE _murks AS (
SELECT kjwo,
       wup_id,
	   mandant_id,
	   art_id,
	   werbe_typ_id,
	   MAX(posten_id) AS posten_id,
	   COUNT(*) AS anz
FROM dbp_data.werbung_kennzahlen_woche
WHERE we_menge_zentral <> 0.001 AND
      we_menge_zentral <> 0
GROUP BY 1,2,3,4,5
HAVING COUNT(*) > 1
);
                    
CREATE OR REPLACE VOLATILE TABLE _track01 AS (
SELECT DISTINCT a.*
FROM dbp_data.werbung_kennzahlen_woche a
JOIN _murks b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
	 a.werbe_typ_id = b.werbe_typ_id AND
	 a.kjwo = b.kjwo AND
	 a.posten_id = b.posten_id AND
	 a.art_id = b.art_id
);
                    
DELETE FROM dbp_data.werbung_kennzahlen_woche
WHERE (kjwo,wup_id,mandant_id,art_id,werbe_typ_id) IN (SELECT kjwo,wup_id,mandant_id,art_id,werbe_typ_id FROM _track01)
;
                    
INSERT INTO dbp_data.werbung_kennzahlen_woche
SELECT *
FROM _track01
;

delete from dbp_data.werbung_kennzahlen_woche
where (mandant_id,art_id) in (select mandant_id,art_id from dbp_etl_process.avq_obsolete_artikel)
;

DELETE FROM dbp_data.avq_aktualisierung
WHERE (mandant_id,kjwo) IN (SELECT mandant_id,kjwo FROM _werbeartikel_1)
;

INSERT INTO dbp_data.avq_aktualisierung (mandant_id,
                                         kjwo,
                                         dat_letzte_aktualisierung)
SELECT mandant_id,
       kjwo,
       CURRENT_TIMESTAMP(0)
FROM _werbeartikel_1
GROUP BY 1,2,3
;
