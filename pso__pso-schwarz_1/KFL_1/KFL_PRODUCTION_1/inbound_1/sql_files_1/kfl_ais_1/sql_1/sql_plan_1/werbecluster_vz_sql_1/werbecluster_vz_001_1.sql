
DROP TABLE IF EXISTS DBP_ETL.ais_wc_vz_werbeart_1;


CREATE TABLE DBP_ETL.ais_wc_vz_werbeart_1  (
mandant_id BYTEINT NOT NULL
,nb_id SMALLINT NOT NULL
,wup_id INTEGER NOT NULL
,kjwo INTEGER NOT NULL
,akt_wo SMALLINT NOT NULL
,aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL
,art_id INTEGER NOT NULL
,af_1fw_fg BYTEINT NOT NULL
,af_2fw_fg BYTEINT NOT NULL
,af_3fw_fg BYTEINT NOT NULL
,af_1vw_fg BYTEINT NOT NULL
,af_2vw_fg BYTEINT NOT NULL
,af_3vw_fg BYTEINT NOT NULL
,af_4vw_fg BYTEINT NOT NULL
,af_5vw_fg BYTEINT NOT NULL
,af_6vw_fg BYTEINT NOT NULL
,sa_1vw_fg BYTEINT NOT NULL
,sa_ww_fg BYTEINT NOT NULL

)
;


DROP TABLE IF EXISTS DBP_ETL.ais_wc_werb_dat_1;



CREATE TABLE DBP_ETL.ais_wc_werb_dat_1  (
min_wo INTEGER NOT NULL
,max_wo INTEGER NOT NULL
, UNIQUE ( min_wo )
);


DROP TABLE IF EXISTS DBP_ETL.ais_wc_vz_dat_1;



CREATE TABLE DBP_ETL.ais_wc_vz_dat_1  (
dat DATE NOT NULL
,akt_wo SMALLINT NOT NULL
, UNIQUE ( dat )
);


DROP TABLE IF EXISTS DBP_ETL.ais_werbecluster_vz_tmp_1;


CREATE TABLE DBP_ETL.ais_werbecluster_vz_tmp_1  (
mandant_id BYTEINT NOT NULL
,nb_id SMALLINT NOT NULL
,wup_id INTEGER NOT NULL
,auftraggeber_id INTEGER NOT NULL
,akt_wo SMALLINT NOT NULL
,art_id INTEGER NOT NULL
,aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL
,menge_faktura_bme DECIMAL (18,3) NOT NULL
)
;


DROP TABLE IF EXISTS DBP_ETL.besch_fak_werbecluster_tmp_1;


CREATE TABLE DBP_ETL.besch_fak_werbecluster_tmp_1  (
mandant_id BYTEINT NOT NULL
,wup_id INTEGER NOT NULL
,nb_id SMALLINT NOT NULL
,kjwo INTEGER NOT NULL
,wg_id SMALLINT NOT NULL
,art_id INTEGER NOT NULL
,faktura_menge_af_1fw DECIMAL (18,3) NOT NULL
,faktura_menge_af_2fw DECIMAL (18,3) NOT NULL
,faktura_menge_af_3fw DECIMAL (18,3) NOT NULL
,faktura_menge_af_6vw DECIMAL (18,3) NOT NULL
,faktura_menge_sa_1vw DECIMAL (18,3) NOT NULL
,faktura_menge_sa_ww DECIMAL (18,3) NOT NULL
)
;


INSERT INTO DBP_ETL.ais_wc_vz_werbeart_1
(
mandant_id
,nb_id
,wup_id
,kjwo
,akt_wo
,aktion_id
,art_id
,af_1fw_fg
,af_2fw_fg
,af_3fw_fg
,af_1vw_fg
,af_2vw_fg
,af_3vw_fg
,af_4vw_fg
,af_5vw_fg
,af_6vw_fg
,sa_1vw_fg
,sa_ww_fg 
) SELECT DISTINCT
 
a1.mandant_id
,a2.nb_id
,a2.wup_id
,t2.kjwo
,t2.akt_wo
,MAX(a1.aktion_id) AS aktion_id
,a2.art_id
,0
,0
,0
,0
,0
,0
,0
,0
,0
,0
,1

FROM DBP_DATA.aktion_1 a1

INNER JOIN DBP_DATA.aktion_art_wup_zu_1 a2
ON a2.mandant_id = a1.mandant_id
AND a2.aktion_id = a1.aktion_id
AND a2.bewart_id = a1.bewart_id
AND a2.grund_sperrung IS NULL

INNER JOIN DBP_DATA.tag_1 t1_1
ON a1.dat_von=t1.dat
AND t1.akt_wo>=(${ANZWOCHEN} * (-1)) AND t1.akt_wo<=-4
AND t1.wtag_id = 7
AND t1.akt_kj >= -2
 
INNER JOIN DBP_DATA.tag_1 t2
ON t2.dat= a1.dat_bis
AND t2.wtag_id IN (6)
AND t2.akt_wo = t1.akt_wo+1
AND t1.akt_kj >= -2

WHERE a1.preisaktiviert_fg = 1
AND a1.mandant_id = 1
GROUP BY 1,2,3,4,5,7
;


INSERT INTO DBP_ETL.ais_wc_vz_werbeart_1
(
mandant_id
,nb_id
,wup_id
,kjwo
,akt_wo
,aktion_id
,art_id
,af_1fw_fg
,af_2fw_fg
,af_3fw_fg
,af_1vw_fg
,af_2vw_fg
,af_3vw_fg
,af_4vw_fg
,af_5vw_fg
,af_6vw_fg
,sa_1vw_fg
,sa_ww_fg 
) SELECT 
w.mandant_id
,w.nb_id
,w.wup_id
,w.kjwo
,w.akt_wo+((x.af_1fw_fg*(1))+(x.af_2fw_fg*(2))+(x.af_3fw_fg*(3))+(x.af_1vw_fg*(-1))+(x.af_2vw_fg*(-2))+(x.af_3vw_fg*(-3))+(x.af_4vw_fg*(-4))+(x.af_5vw_fg*(-5))+(x.af_6vw_fg*(-6))+(x.sa_1vw_fg*(-1))) AS akt_wo
,w.aktion_id
,w.art_id
,x.af_1fw_fg
,x.af_2fw_fg
,x.af_3fw_fg
,x.af_1vw_fg
,x.af_2vw_fg
,x.af_3vw_fg
,x.af_4vw_fg
,x.af_5vw_fg
,x.af_6vw_fg
,x.sa_1vw_fg
,0 AS sa_ww_fg 

FROM DBP_ETL.ais_wc_vz_werbeart_1 w

CROSS JOIN
(
SELECT
CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/1 = 1 THEN  1 ELSE 0 END af_1fw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/2 = 1 THEN  1 ELSE 0 END af_2fw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/3 = 1 THEN  1 ELSE 0 END af_3fw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/4 = 1 THEN  1 ELSE 0 END af_1vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/5 = 1 THEN  1 ELSE 0 END af_2vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/6 = 1 THEN  1 ELSE 0 END af_3vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/7 = 1 THEN  1 ELSE 0 END af_4vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/8 = 1 THEN  1 ELSE 0 END af_5vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/9 = 1 THEN  1 ELSE 0 END af_6vw_fg
,CASE WHEN (CAST(s.akt_tag AS DECIMAL (4,2)))/10 = 1 THEN  1 ELSE 0 END sa_1vw_fg
FROM ( SELECT t.akt_tag 
FROM DBP_DATA.tag_1 t
WHERE  t.akt_tag BETWEEN 1 AND 10
)s
)x
;


INSERT INTO DBP_ETL.ais_wc_werb_dat_1
(
min_wo
,max_wo
)
SELECT 
min_wo
,max_wo
FROM 
(
 SELECT 
 MIN (kjwo) min_wo
 ,MAX (kjwo) max_wo
 FROM DBP_ETL.ais_wc_vz_werbeart_1) s
 
WHERE s.min_wo IS NOT NULL AND s.max_wo IS NOT NULL;


INSERT INTO DBP_ETL.ais_wc_vz_dat_1
(
dat
,akt_wo
)
 SELECT 
dat-1
,akt_wo
FROM DBP_DATA.tag_1 t1_1

INNER JOIN
(
 SELECT 
 MIN(t2.akt_wo)-6 akt_wo_min
 ,MAX(t3.akt_wo)+1 akt_wo_max

 FROM 
 (SELECT DISTINCT t1.akt_wo
  FROM DBP_ETL.ais_wc_vz_werbeart_1 t1_1
 ) t1_1

 INNER JOIN DBP_DATA.tag_1 t2
 ON t1.akt_wo = t2.akt_wo

 INNER JOIN DBP_DATA.tag_1 t3
 ON t1.akt_wo = t3.akt_wo

) x1

ON t1.akt_wo BETWEEN x1.akt_wo_min AND x1.akt_wo_max
;


INSERT INTO DBP_ETL.ais_werbecluster_vz_tmp_1
(
mandant_id
,nb_id
,wup_id
,auftraggeber_id
,akt_wo
,art_id
,aktion_id
,menge_faktura_bme
)
SELECT
f1.mandant_id
,f2.nb_id
,f2.wup_id
,CAST(CASE WHEN f1.auftraggeber_id='' THEN -1 ELSE f1.auftraggeber_id END AS INTEGER) auftraggeber_id
,d1.akt_wo
,f2.art_id
,MAX(aktion_id) AS aktion_id
,SUM(f2.menge_faktura_bme) AS menge_faktura_bme

FROM DBP_ETL.ais_wc_vz_dat_1 d1

INNER JOIN DBP_DATA.besch_faktura_det_1 f2
ON d1.dat = f2.dat_faktura
AND f2.aktion_id <> ''

INNER JOIN DBP_DATA.besch_faktura_1 f1
ON f1.dat_faktura_sap = f2.dat_faktura_sap
AND f1.faktura_beleg_id = f2.faktura_beleg_id
AND f1.mandant_id = 1

GROUP BY 1,2,3,4,5,6

UNION ALL

SELECT
f1.mandant_id
,f2.nb_id
,f2.wup_id
,CAST(CASE WHEN f1.auftraggeber_id='' THEN -1 ELSE f1.auftraggeber_id END AS INTEGER) auftraggeber_id
,d1.akt_wo
,f2.art_id
,'' AS aktion_id
,SUM(f2.menge_faktura_bme) AS menge_faktura_bme

FROM DBP_ETL.ais_wc_vz_dat_1 d1

INNER JOIN DBP_DATA.besch_faktura_det_1 f2
ON d1.dat = f2.dat_faktura
AND f2.aktion_id = ''

INNER JOIN DBP_DATA.besch_faktura_1 f1
ON f1.dat_faktura_sap = f2.dat_faktura_sap
AND f1.faktura_beleg_id = f2.faktura_beleg_id
AND f1.mandant_id = 1

GROUP BY 1,2,3,4,5,6

;


INSERT INTO DBP_ETL.besch_fak_werbecluster_tmp_1
(
mandant_id
,wup_id
,nb_id
,kjwo
,wg_id
,art_id
,faktura_menge_af_1fw
,faktura_menge_af_2fw
,faktura_menge_af_3fw
,faktura_menge_af_6vw
,faktura_menge_sa_1vw
,faktura_menge_sa_ww
)
SELECT
mandant_id
,wup_id
,nb_id
,kjwo
,wg_id
,art_id
,SUM(faktura_menge_af_1fw) faktura_menge_af_1fw
,SUM(faktura_menge_af_2fw) faktura_menge_af_2fw
,SUM(faktura_menge_af_3fw) faktura_menge_af_3fw
,SUM(faktura_menge_af_1vw+faktura_menge_af_2vw+faktura_menge_af_3vw+faktura_menge_af_4vw+faktura_menge_af_5vw+faktura_menge_af_6vw)/6 faktura_menge_af_6vw
,SUM(faktura_menge_sa_1vw) faktura_menge_sa_1vw
,SUM(faktura_menge_sa_ww) faktura_menge_sa_ww
FROM (
SELECT
w2.mandant_id
,w2.wup_id
,w2.nb_id
,w2.art_id
,w3.wg_id
,w1.kjwo
,(w1.af_1fw_fg*w2.menge_faktura_bme) faktura_menge_af_1fw
,(w1.af_2fw_fg*w2.menge_faktura_bme) faktura_menge_af_2fw
,(w1.af_3fw_fg*w2.menge_faktura_bme) faktura_menge_af_3fw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_1vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_1vw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_2vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_2vw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_3vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_3vw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_4vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_4vw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_5vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_5vw
,CASE WHEN (w2.aktion_id = '') THEN (w1.af_6vw_fg*w2.menge_faktura_bme) ELSE 0 END faktura_menge_af_6vw
,(w1.sa_1vw_fg*w2.menge_faktura_bme) _faktura_menge_sa_1vw
,CASE WHEN (w1.aktion_id = w2.aktion_id) THEN  _faktura_menge_sa_1vw ELSE 0 END faktura_menge_sa_1vw
,(w1.sa_ww_fg*w2.menge_faktura_bme) _faktura_menge_sa_ww
,CASE WHEN (w1.aktion_id = w2.aktion_id) THEN  _faktura_menge_sa_ww ELSE 0 END faktura_menge_sa_ww

FROM DBP_ETL.ais_wc_vz_werbeart_1 w1

INNER JOIN DBP_DATA.art_wg_zu_per_1 w3
ON w3.mandant_id = w1.mandant_id
AND w3.art_id = w1.art_id
AND w3.arthiertyp_id = 2
AND w3.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

INNER JOIN DBP_ETL.ais_werbecluster_vz_tmp_1 w2
ON w1.mandant_id = w2.mandant_id
AND w1.wup_id = w2.auftraggeber_id
AND w1.akt_wo = w2.akt_wo
AND w1.art_id = w2.art_id

) S
GROUP BY 1,2,3,4,5,6;


DELETE FROM DBP_DATA.besch_faktura_werbecluster_1 
WHERE kjwo BETWEEN (SELECT min_wo FROM DBP_ETL.ais_wc_werb_dat_1) 
AND (SELECT max_wo FROM DBP_ETL.ais_wc_werb_dat_1)
;


INSERT INTO DBP_DATA.besch_faktura_werbecluster_1
SELECT 
mandant_id
,wup_id
,nb_id
,kjwo
,wg_id
,art_id
,faktura_menge_af_1fw
,faktura_menge_af_2fw
,faktura_menge_af_3fw
,faktura_menge_af_6vw
,faktura_menge_sa_1vw
,faktura_menge_sa_ww
,localtimestamp
,localtimestamp
FROM DBP_ETL.besch_fak_werbecluster_tmp_1
;

