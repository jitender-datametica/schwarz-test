
/*
#----------------------------------------------------------------------------
# 1) Ladetabelle anlegen
#----------------------------------------------------------------------------
*/

DROP TABLE IF EXISTS DBP_ETL.dat_vj_vergleich_tmp_2;


/*
Die Tabelle DBP_ETL.dat_vj_vergleich_tmp_2 ist als Join- und Berechnungstabelle
für die spätere Beladung der DBP_DATA.artbew_tag_wg_wup_sum benötigt
Erklärung im create

*/

CREATE TABLE DBP_ETL.dat_vj_vergleich_tmp_2 
(
	join_dat DATE  NOT NULL   -- a) Diese Datum wird mit der DBP_DATA.artbew_tag_wg_wup_sum gejoint
	,dat DATE  NOT NULL       -- b) Auf dieses Datum werden die Daten aggregiert
	,gj SMALLINT not null
	,kjwo INTEGER NOT NULL
	,kjmo INTEGER NOT NULL
	,mo_kj BYTEINT NOT NULL
	,akt_gj SMALLINT NOT NULL
	,akt_mo SMALLINT NOT NULL
	,akt_wo SMALLINT NOT NULL
	,akt_tag SMALLINT NOT NULL
	,wtag_id BYTEINT NOT NULL
	,akt_gj_fg byteint not NULL                  -- c) 1 wenn join_dat=dat, dann ist dies der aktuelle Tageswert
	
	,vj_1_fg byteint not null                    -- d) 1 wenn join_dat=dat-1 Jahr (z.B. dat=1.3.2007 --> join_dat=1.3.2006)
												 --   wird für die Kummulierung der Vorjahre gebraucht
	,vj_2_fg byteint not null                    -- e) siehe d) nur für das Vorvorjahr
	,vj_wt_1_fg byteint not null     -- f) 1 wenn join_dat=dat-364 (Wochentagsvergleich (Mi=Mi Vorjahr)
	,vj_wt_2_fg byteint not null     -- g) 1 wenn join_dat=dat-728 (Wochentagsvergleich (Mi=Mi Vorjahr)
)
;


DROP TABLE IF EXISTS DBP_ETL.dat_vj_vergleich_2;



CREATE  TABLE DBP_ETL.dat_vj_vergleich_2 
(
	mandant_id BYTEINT
	,wup_id INTEGER NOT NULL
	,nb_id SMALLINT
	,join_dat DATE  NOT NULL
	,dat DATE  NOT NULL
	,gj SMALLINT NOT NULL
	,kjwo INTEGER NOT NULL
	,kjmo INTEGER NOT NULL
	,mo_kj BYTEINT NOT NULL
	,akt_gj SMALLINT NOT NULL
	,akt_mo SMALLINT NOT NULL
	,akt_wo SMALLINT NOT NULL
	,akt_tag SMALLINT NOT NULL
	,wtag_id BYTEINT NOT NULL
	,akt_gj_fg byteint not null
	,vj_1_fg byteint not null
	
	,vj_2_fg byteint not null
	,vj_wt_1_fg byteint not null
	,vj_wt_2_fg byteint not null
)
;


/*
#----------------------------------------------------------------------------
# 2) tmp Tabelle mit Join-Logik beladen
#----------------------------------------------------------------------------
*/

-- Einfügen der Kalendertagsvergleichswerte des aktuellen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird
-- für gj, gj-1 und gj-2
INSERT INTO DBP_ETL.dat_vj_vergleich_tmp_2 (join_dat
                                           ,dat
                                           ,gj
                                           ,kjwo
                                           ,kjmo
                                           ,mo_kj
                                           ,akt_gj
                                           ,akt_mo
                                           ,akt_wo
                                           ,akt_tag
                                           ,wtag_id
                                           ,akt_gj_fg
                                           ,vj_1_fg
                                           ,vj_2_fg
                                           ,vj_wt_1_fg
                                           ,vj_wt_2_fg)
SELECT t1.dat AS join_dat
      ,COALESCE(t2.dat,dt1.dat) AS dat
      ,COALESCE(t2.gj,dt1.gj) AS gj
      ,COALESCE(t2.kjwo,dt1.kjwo) AS kjwo
      ,COALESCE(t2.kjmo,dt1.kjmo) AS kjmo
      ,COALESCE(t2.mo_kj,dt1.mo_kj) AS mo_kj
      ,COALESCE(t2.akt_gj,dt1.akt_gj) AS akt_gj
      ,COALESCE(t2.akt_mo,dt1.akt_mo) AS akt_mo
      ,COALESCE(t2.akt_wo,dt1.akt_wo) AS akt_wo
      ,COALESCE(t2.akt_tag,dt1.akt_tag) AS akt_tag
      ,COALESCE(t2.wtag_id,dt1.wtag_id) AS wtag_id
      ,CASE WHEN (t1.gj=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS akt_gj_fg
      ,CASE WHEN (t1.gj+1=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_1_fg
      ,CASE WHEN (t1.gj+2=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_2_fg
      ,0 AS vj_wt_1_fg
      ,0 AS vj_wt_2_fg
FROM (SELECT dat
            ,gj
      FROM DBP_DATA.tag_2
      WHERE akt_gj IN (0,-1,-2,1)) t1_2
FULL JOIN (SELECT dat
                 ,gj
                 ,kjwo
                 ,kjmo
                 ,mo_kj
                 ,akt_gj
                 ,akt_mo
                 ,akt_wo
                 ,akt_tag
                 ,wtag_id
           FROM DBP_DATA.tag_2
           WHERE akt_gj in (0,1)) t2
ON EXTRACT(DAY FROM t1.dat)=EXTRACT(DAY FROM t2.dat) AND
   EXTRACT(MONTH FROM t1.dat)=EXTRACT(MONTH FROM t2.dat)

CROSS JOIN (SELECT t3.dat
                  ,t3.gj
                  ,t3.kjwo
                  ,t3.kjmo
                  ,t3.mo_kj
                  ,t3.akt_gj
                  ,t3.akt_mo
                  ,t3.akt_wo
                  ,t3.akt_tag
                  ,t3.wtag_id
            FROM DBP_DATA.tag_2 t3
            WHERE t3.akt_gj IN (0) AND
                EXTRACT(DAY FROM t3.dat) = 28 AND
                EXTRACT(MONTH FROM t3.dat) = 2) dt1
;

-- Einfügen der Kalendertagsvergleichswerte des vorherigen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird
-- für gj-1, gj-2 und gj-3

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp_2 (join_dat
	                       ,dat
	                       ,gj
	                       ,kjwo
	                       ,kjmo
	                       ,mo_kj
	                       ,akt_gj
	                       ,akt_mo
	                       ,akt_wo
	                       ,akt_tag
	                       ,wtag_id
	                       ,akt_gj_fg
	                       ,vj_1_fg
	                       ,vj_2_fg
	                       ,vj_wt_1_fg
	                       ,vj_wt_2_fg)
SELECT t1.dat AS join_dat
      ,COALESCE(t2.dat,dt1.dat) AS dat
      ,COALESCE(t2.gj,dt1.gj) AS gj
      ,COALESCE(t2.kjwo,dt1.kjwo) AS kjwo
      ,COALESCE(t2.kjmo,dt1.kjmo) AS kjmo
      ,COALESCE(t2.mo_kj,dt1.mo_kj) AS mo_kj
      ,COALESCE(t2.akt_gj,dt1.akt_gj) AS akt_gj
      ,COALESCE(t2.akt_mo,dt1.akt_mo) AS akt_mo
      ,COALESCE(t2.akt_wo,dt1.akt_wo) AS akt_wo
      ,COALESCE(t2.akt_tag,dt1.akt_tag) AS akt_tag
      ,COALESCE(t2.wtag_id,dt1.wtag_id) AS wtag_id
      ,CASE WHEN (t1.gj=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS akt_gj_fg
      ,CASE WHEN (t1.gj+1=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_1_fg
      ,CASE WHEN (t1.gj+2=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_2_fg
      ,0 AS vj_wt_1_fg
      ,0 AS vj_wt_2_fg
FROM (SELECT dat
            ,gj
      FROM DBP_DATA.tag_2
      WHERE akt_gj IN (-1,-2,-3)) t1_2
      
FULL JOIN (SELECT dat
                 ,gj
                 ,kjwo
                 ,kjmo
                 ,mo_kj
                 ,akt_gj
                 ,akt_mo
                 ,akt_wo
                 ,akt_tag
                 ,wtag_id
           FROM DBP_DATA.tag_2
           WHERE akt_gj IN (-1)) t2
  ON EXTRACT(DAY FROM t1.dat) = EXTRACT(DAY FROM t2.dat) AND
     EXTRACT(MONTH FROM t1.dat) = EXTRACT(MONTH FROM t2.dat)

CROSS JOIN (SELECT t3.dat
                  ,t3.gj
                  ,t3.kjwo
                  ,t3.kjmo
                  ,t3.mo_kj
                  ,t3.akt_gj
                  ,t3.akt_mo
                  ,t3.akt_wo
                  ,t3.akt_tag
                  ,t3.wtag_id
            FROM DBP_DATA.tag_2 t3
            WHERE t3.akt_gj IN (-1) AND
                --CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1
                EXTRACT(DAY FROM t3.dat) = 28 AND
                EXTRACT(MONTH FROM t3.dat) = 2) dt1
;

-- Einfügen der Kalendertagsvergleichswerte des vorherigen GJ, wobei der 29.02. eines Vorjahres auf den 28.02. des GJ gebucht wird
-- für gj-2, gj-3 und gj-4

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp_2 (join_dat
	                       ,dat
	                       ,gj
	                       ,kjwo
	                       ,kjmo
	                       ,mo_kj
	                       ,akt_gj
	                       ,akt_mo
	                       ,akt_wo
	                       ,akt_tag
	                       ,wtag_id
	                       ,akt_gj_fg
	                       ,vj_1_fg
	                       ,vj_2_fg
	                       ,vj_wt_1_fg
	                       ,vj_wt_2_fg)
SELECT t1.dat AS join_dat
      ,COALESCE(t2.dat,dt1.dat) AS dat
      ,COALESCE(t2.gj,dt1.gj) AS gj
      ,COALESCE(t2.kjwo,dt1.kjwo) AS kjwo
      ,COALESCE(t2.kjmo,dt1.kjmo) AS kjmo
      ,COALESCE(t2.mo_kj,dt1.mo_kj) AS mo_kj
      ,COALESCE(t2.akt_gj,dt1.akt_gj) AS akt_gj
      ,COALESCE(t2.akt_mo,dt1.akt_mo) AS akt_mo
      ,COALESCE(t2.akt_wo,dt1.akt_wo) AS akt_wo
      ,COALESCE(t2.akt_tag,dt1.akt_tag) AS akt_tag
      ,COALESCE(t2.wtag_id,dt1.wtag_id) AS wtag_id
      ,CASE WHEN (t1.gj=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS akt_gj_fg
      ,CASE WHEN (t1.gj+1=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_1_fg
      ,CASE WHEN (t1.gj+2=COALESCE(t2.gj,dt1.gj)) THEN 1 ELSE 0 end AS vj_2_fg
      ,0 AS vj_wt_1_fg
      ,0 AS vj_wt_2_fg
FROM (SELECT dat
            ,gj
      FROM DBP_DATA.tag_2
      WHERE akt_gj IN (-2,-3,-4)) t1_2
      
FULL JOIN (SELECT dat
                 ,gj
                 ,kjwo
                 ,kjmo
                 ,mo_kj
                 ,akt_gj
                 ,akt_mo
                 ,akt_wo
                 ,akt_tag
                 ,wtag_id
           FROM DBP_DATA.tag_2
           WHERE akt_gj IN (-2)) t2
  ON EXTRACT(DAY FROM t1.dat) = EXTRACT(DAY FROM t2.dat) AND
     EXTRACT(MONTH FROM t1.dat) = EXTRACT(MONTH FROM t2.dat)

CROSS JOIN (SELECT t3.dat
                  ,t3.gj
                  ,t3.kjwo
                  ,t3.kjmo
                  ,t3.mo_kj
                  ,t3.akt_gj
                  ,t3.akt_mo
                  ,t3.akt_wo
                  ,t3.akt_tag
                  ,t3.wtag_id
            FROM DBP_DATA.tag_2 t3
            WHERE t3.akt_gj IN (-2) AND
                --CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1
                EXTRACT(DAY FROM t3.dat) = 28 AND
                EXTRACT(MONTH FROM t3.dat) = 2) dt1
;

-- Einfügen der Wochentagsvergleichswerte des aktuellen GJs mit Vorjahr

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp_2 (join_dat
                                           ,dat
                                           ,gj
                                           ,kjwo
                                           ,kjmo
                                           ,mo_kj
                                           ,akt_gj
                                           ,akt_mo
                                           ,akt_wo
                                           ,akt_tag
                                           ,wtag_id
                                           ,akt_gj_fg
                                           ,vj_1_fg
                                           ,vj_2_fg
                                           ,vj_wt_1_fg
                                           ,vj_wt_2_fg)
SELECT dat-364
      ,dat
      ,gj
      ,kjwo
      ,kjmo
      ,mo_kj
      ,akt_gj
      ,akt_mo
      ,akt_wo
      ,akt_tag
      ,wtag_id
      ,0 as akt_gj_fg
      ,0 as vj_1_fg
      ,0 as vj_2_fg
      ,1 as vj_wt_1_fg
      ,0 as vj_wt_2_fg
FROM DBP_DATA.tag_2
WHERE akt_gj in (0,-1,-2,1)
;

-- Einfügen der Wochentagsvergleichswerte des vorherigen GJs mit Vorvorjahr

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp_2 (join_dat
                                           ,dat
                                           ,gj
                                           ,kjwo
                                           ,kjmo
                                           ,mo_kj
                                           ,akt_gj
                                           ,akt_mo
                                           ,akt_wo
                                           ,akt_tag
                                           ,wtag_id
                                           ,akt_gj_fg
                                           ,vj_1_fg
                                           ,vj_2_fg
                                           ,vj_wt_1_fg
                                           ,vj_wt_2_fg)
SELECT dat-728
      ,dat
      ,gj
      ,kjwo
      ,kjmo
      ,mo_kj
      ,akt_gj
      ,akt_mo
      ,akt_wo
      ,akt_tag
      ,wtag_id
      ,0 as akt_gj_fg
      ,0 as vj_1_fg
      ,0 as vj_2_fg
      ,0 as vj_wt_1_fg
      ,1 as vj_wt_2_fg
FROM DBP_DATA.tag_2
WHERE akt_gj in (0,-1,-2,1)
;

DELETE FROM DBP_ETL.dat_vj_vergleich_tmp_2
WHERE akt_gj_fg = 0 AND
      vj_1_fg = 0 AND
      vj_2_fg = 0 AND
      vj_wt_1_fg = 0 AND
      vj_wt_2_fg = 0
;

/*
#----------------------------------------------------------------------------
# 2) Erweiterung der Join-Tabelle mit 2.1) Deltalogik 2.2) Kompletter Aggregation
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
# 2.1) Kompletter Aggregation 
# Damit werden alle Tage des GJ und GJ-1 eingefügt (komplett-Aggregation)
#----------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.dat_vj_vergleich_2 (mandant_id
                                       ,wup_id
                                       ,nb_id
                                       ,join_dat
                                       ,dat
                                       ,gj
                                       ,kjwo
                                       ,kjmo
                                       ,mo_kj
                                       ,akt_gj
                                       ,akt_mo
                                       ,akt_wo
                                       ,akt_tag
                                       ,wtag_id
                                       ,akt_gj_fg
                                       ,vj_1_fg
                                       ,vj_2_fg
                                       ,vj_wt_1_fg
                                       ,vj_wt_2_fg)
SELECT dt1.mandant_id
      ,dt1.wup_id
      ,dt1.nb_id
      ,t1.join_dat
      ,t1.dat
      ,t1.gj
      ,t1.kjwo
      ,t1.kjmo
      ,t1.mo_kj
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.akt_wo
      ,t1.akt_tag
      ,t1.wtag_id
      ,t1.akt_gj_fg
      ,t1.vj_1_fg
      ,t1.vj_2_fg
      ,t1.vj_wt_1_fg
      ,t1.vj_wt_2_fg
FROM DBP_ETL.dat_vj_vergleich_tmp_2 t1_2
CROSS JOIN (SELECT t2.wup_id
                  ,t2.mandant_id
                  ,t2.nb_id
            FROM DBP_DATA.wup_2 t2
            JOIN DBP_ETL.vis_mandant_2 t3
              ON t2.mandant_id = t3.mandant_id
            WHERE t2.nb_id in (-2,-1,0,2,7) AND 
                  --t2.dat_eroeffnung > 101) dt1
                    t2.dat_eroeffnung > '1900-01-01') dt1
;




-- 02.09.2021, -dbay-
--
-- Raus auf Wunsch des FABs!

--DELETE FROM DBP_ETL.dat_vj_vergleich_tmp_2
--WHERE akt_gj = -2
--;



INSERT INTO DBP_ETL.dat_vj_vergl_abschrift_2 (mandant_id
                                             ,wup_id
                                             ,nb_id
                                             ,join_dat
                                             ,dat
                                             ,gj
                                             ,kjwo
                                             ,kjmo
                                             ,mo_kj
                                             ,akt_gj
                                             ,akt_mo
                                             ,akt_wo
                                             ,akt_tag
                                             ,wtag_id
                                             ,akt_gj_fg
                                             ,vj_1_fg
                                             ,vj_2_fg
                                             ,vj_wt_1_fg
                                             ,vj_wt_2_fg)
SELECT dt1.mandant_id
      ,dt1.wup_id
      ,dt1.nb_id
      ,t1.join_dat
      ,t1.dat
      ,t1.gj
      ,t1.kjwo
      ,t1.kjmo
      ,t1.mo_kj
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.akt_wo
      ,t1.akt_tag
      ,t1.wtag_id
      ,t1.akt_gj_fg
      ,t1.vj_1_fg
      ,t1.vj_2_fg
      ,t1.vj_wt_1_fg
      ,t1.vj_wt_2_fg
FROM DBP_ETL.dat_vj_vergleich_tmp_2 t1_2
CROSS JOIN (SELECT t2.wup_id
                  ,t2.mandant_id
                  ,t2.nb_id
            FROM DBP_DATA.wup_2 t2
            WHERE t2.nb_id in (-2,-1,0,2,7) AND 
                  -- t2.dat_eroeffnung > 101) dt1
                  t2.dat_eroeffnung > '1900-01-01') dt1
;
