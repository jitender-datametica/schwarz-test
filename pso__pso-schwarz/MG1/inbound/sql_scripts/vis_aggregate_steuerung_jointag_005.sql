/* AW check 2021-05-10*/
CREATE TABLE DBP_ETL.dat_vj_vergleich  (
	mandant_id BYTEINT
	,wup_id INTEGER NOT NULL
	,nb_id SMALLINT
	,join_dat DATE NOT NULL
	,dat DATE NOT NULL
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

DROP TABLE IF EXISTS DBP_ETL.dat_vj_vergl_abschrift;

CREATE TABLE DBP_ETL.dat_vj_vergl_abschrift  (
	mandant_id BYTEINT
	,wup_id INTEGER NOT NULL
	,nb_id SMALLINT
	,join_dat DATE NOT NULL
	,dat DATE NOT NULL
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

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp (join_dat
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
      FROM DBP_DATA.tag
      WHERE akt_gj IN (0,-1,-2) OR
           (akt_gj = 1 AND
            SUBSTR(CAST(kjmo AS VARCHAR(6)),5,2) IN ('03','04','05','06'))) t1
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
           FROM DBP_DATA.tag
           WHERE akt_gj IN (0) OR
                (akt_gj = 1 AND
                 SUBSTR(CAST(kjmo AS VARCHAR(6)),5,2) IN ('03','04','05','06'))) t2
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
            FROM DBP_DATA.tag t3
            WHERE t3.akt_gj IN (0) AND
                  --CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1
                EXTRACT(DAY FROM t3.dat) = 28 AND
                EXTRACT(MONTH FROM t3.dat) = 2) dt1
;

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp (join_dat
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
      FROM DBP_DATA.tag
      WHERE akt_gj IN (-1,-2,-3)) t1
      
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
           FROM DBP_DATA.tag
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
            FROM DBP_DATA.tag t3
            WHERE t3.akt_gj IN (-1) AND
                  --CAST(t3.dat AS INTEGER) MOD 10000 = 228) dt1
                EXTRACT(DAY FROM t3.dat) = 28 AND
                EXTRACT(MONTH FROM t3.dat) = 2) dt1
;

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp (join_dat
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
FROM DBP_DATA.tag
WHERE akt_gj in (0,-1) OR
     (akt_gj = 1 AND
      SUBSTR(CAST(kjmo AS VARCHAR(6)),5,2) IN ('03','04','05','06'))
;

INSERT INTO DBP_ETL.dat_vj_vergleich_tmp (join_dat
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
FROM DBP_DATA.tag
WHERE akt_gj in (0,-1) OR
     (akt_gj = 1 AND
      SUBSTR(CAST(kjmo AS VARCHAR(6)),5,2) IN ('03','04','05','06'))
;

DELETE FROM DBP_ETL.dat_vj_vergleich_tmp
WHERE akt_gj_fg = 0 AND
      vj_1_fg = 0 AND
      vj_2_fg = 0 AND
      vj_wt_1_fg = 0 AND
      vj_wt_2_fg = 0
;

