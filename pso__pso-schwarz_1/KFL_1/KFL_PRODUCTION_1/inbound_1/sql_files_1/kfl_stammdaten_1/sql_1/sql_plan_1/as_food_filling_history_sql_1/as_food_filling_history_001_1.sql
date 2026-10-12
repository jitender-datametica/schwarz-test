DROP TABLE IF EXISTS dbp_etl.as_food_final_1;
CREATE TABLE dbp_etl.as_food_final_1
     (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      nb_id SMALLINT NOT NULL  ,
      wup_id INTEGER NOT NULL,
      dat_auslistung DATE NOT NULL,
      gp_id INTEGER NOT NULL DEFAULT -1 ,
      phase_status BYTEINT NOT NULL DEFAULT -1  ,
      erl_fg BYTEINT NOT NULL DEFAULT 0 ,
      dat_final DATE ,
      menge_startbestand DECIMAL(18,3) NOT NULL DEFAULT 0.000 ,
      vk_netto DECIMAL(18,4) NOT NULL DEFAULT 0.0000 ,
      menge_endbestand DECIMAL(18,3) NOT NULL DEFAULT 0.000,
      erl_kz CHAR(1) NOT NULL DEFAULT '',
      dat_aend DATE
);


DROP TABLE IF EXISTS dbp_etl.as_food_det_final_tmp_1;
CREATE TABLE dbp_etl.as_food_det_final_tmp_1 
     (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      nb_id SMALLINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      dat_auslistung DATE NOT NULL,
      phase_id BYTEINT NOT NULL,
      kjwo INTEGER NOT NULL,
      phase_wo INTEGER NOT NULL,
      phase_vk_brutto DECIMAL(9,2) NOT NULL DEFAULT 0.00 ,
      phase_vk_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00 ,
      menge_abschrift_22 INTEGER NOT NULL DEFAULT 0  ,
      abschriftbetrag_netto_22 DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      menge_abschrift_122 INTEGER NOT NULL DEFAULT 0  ,
      abschriftbetrag_netto_122 DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      diff_wert_bestand_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00 ,
      menge_berechnet DECIMAL(18,3) NOT NULL DEFAULT 0.000 ,
      menge_endbestand_phase DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      menge DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.000,
      mwst_id BYTEINT NOT NULL,
      wtag_phasenbeginn BYTEINT
) ;


DROP TABLE IF EXISTS dbp_etl.as_food_det_final_1;
CREATE TABLE dbp_etl.as_food_det_final_1 
     (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      nb_id SMALLINT NOT NULL  ,
      wup_id INTEGER NOT NULL,
      dat_auslistung DATE NOT NULL,
      phase_id BYTEINT NOT NULL,
      kjwo INTEGER NOT NULL,
      phase_wo INTEGER NOT NULL,
      phase_vk_brutto DECIMAL(9,2) NOT NULL DEFAULT 0.00 ,
      phase_vk_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00 ,
      menge_abschrift_22 INTEGER NOT NULL DEFAULT 0 ,
      abschriftbetrag_netto_22 DECIMAL(18,4) NOT NULL DEFAULT 0.00  ,
      menge_abschrift_122 INTEGER NOT NULL DEFAULT 0   ,
      abschriftbetrag_netto_122 DECIMAL(18,4) NOT NULL DEFAULT 0.00  ,
      diff_wert_bestand_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      menge_berechnet DECIMAL(18,3) NOT NULL DEFAULT 0.000 ,
      menge_endbestand_phase DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      menge DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.000,
      mwst_id BYTEINT NOT NULL,
      wtag_phasenbeginn BYTEINT,
      dat_von DATE ,
      dat_bis DATE ,
      ranking BYTEINT
) ;


DROP TABLE IF EXISTS dbp_etl.as_food_det_tmp_1;
CREATE TABLE dbp_etl.as_food_det_tmp_1 
     (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kjwo INTEGER NOT NULL,
      wtag_phasenbeginn BYTEINT,
      dat_von DATE ,
      dat_bis DATE ,
      ranking BYTEINT
) 
;


DROP TABLE IF EXISTS dbp_etl.distinkte_kombis_1;
CREATE TABLE dbp_etl.distinkte_kombis_1 AS (
SELECT mandant_id,
       wup_id,
       art_id,
       dat_auslistung,
       dat_final,
       erl_kz,
       dat_aend
FROM dbp_data.as_food_1
--WHERE dat_auslistung >= to_date('2022-03-07', 'YYYY-MM_1-DD')
GROUP BY 1,2,3,4,5,6,7
) 
;


INSERT INTO dbp_etl.as_food_final_1
SELECT a.art_id,
       a.mandant_id,
       a.nb_id,
       a.wup_id,
       a.dat_auslistung,
       a.gp_id,
       a.phase_status,
       a.erl_fg,
       a.dat_final,
       a.menge_startbestand,
       a.vk_netto,
       a.menge_endbestand,
       a.erl_kz,
       a.dat_aend
FROM dbp_data.as_food_1 a
--WHERE dat_auslistung >= to_date('2022-03-07', 'YYYY-MM_1-DD')
;


-- abgebrochene und abgeschlossene
INSERT INTO dbp_etl.as_food_det_final_tmp_1
SELECT a.art_id,
       a.mandant_id,
       a.nb_id,
       a.wup_id,
       a.dat_auslistung,
       a.phase_id,
       a.kjwo,
       a.phase_wo,
       a.phase_vk_brutto,
       0 AS phase_vk_netto,
       0 AS menge_abschrift_22,
       0 AS abschriftbetrag_netto_22,
       0 AS menge_abschrift_122,
       0 AS abschriftbetrag_netto_122,
       0 AS diff_wert_bestand_netto,
       0 AS menge_berechnet,
       0 AS menge_endbestand_phase,
       0 AS menge,
       0 AS umsatz_netto,
       e.mwst_id,
       null as wtag_phasenbeginn
FROM dbp_data.as_food_det_1 a
JOIN dbp_data.art_1 e
  ON a.mandant_id = e.mandant_id AND
     a.art_id = e.art_id
--WHERE dat_auslistung >= to_date('2022-03-07', 'YYYY-MM_1-DD')
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
;

DROP TABLE IF EXISTS dbp_etl._tag_01;
-- Add wtag_phasenbeginn
CREATE TRANSIENT TABLE dbp_etl._tag_01 AS (
SELECT
tt.kjwo,
tt.wtag_id,
tt.dat AS dat_von,
(tt.dat+6) AS dat_bis,
t.rnk AS ranking
FROM (SELECT kjwo, DENSE_RANK() OVER (PARTITION BY kjwo ORDER BY kjwo DESC) AS rnk
			FROM dbp_data.tag_1
			GROUP BY kjwo) t -- take only weeks and ranking

INNER JOIN dbp_data.tag_1 tt
ON t.kjwo = tt.kjwo
)
;


INSERT INTO dbp_etl.as_food_det_tmp_1
SELECT  
af.art_id,
af.mandant_id,
af.kjwo,
COALESCE(p.wtag_phasenbeginn,1) AS wtag_phasenbeginn,
CASE WHEN wtag_phasenbeginn=7 THEN t.dat_von-7 ELSE t.dat_von END,
CASE WHEN wtag_phasenbeginn=7 THEN t.dat_bis-7 ELSE t.dat_bis END,
t.ranking
FROM
(SELECT DISTINCT 
mandant_id, art_id, kjwo
FROM (SELECT mandant_id, 
	art_id, kjwo
FROM dbp_data.as_food_det_1
--WHERE dat_auslistung >= to_date('2022-03-07', 'YYYY-MM_1-DD')
GROUP BY 1,2,3) g) af
JOIN dbp_data.art_1 a
ON a.mandant_id = af.mandant_id 
AND a.art_id = af.art_id 

LEFT JOIN dbp_data.art_wg_zu_per_1 awz  -- there were less rows in test_1 due to not found correspondence on art_wg_zu_per_1, hence LEFT JOIN here !!!
ON a.mandant_id = awz.mandant_id 
AND a.art_id = awz.art_id 
AND awz.arthiertyp_id = 2 
AND awz.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')

LEFT JOIN dbp_data.as_phasen_1 p
ON p.mandant_id = a.mandant_id 
AND p.posten_kz_sap = a.posten_kz_sap
AND p.wg_id = awz.wg_id

INNER JOIN dbp_etl._tag_01 t
ON af.kjwo = t.kjwo
AND COALESCE(p.wtag_phasenbeginn,1) = t.wtag_id

GROUP BY 1,2,3,4,5,6,7
;


INSERT INTO dbp_etl.as_food_det_final_1
SELECT
      m.art_id,
      m.mandant_id,
      nb_id,
      wup_id,
      dat_auslistung,
      phase_id,
      m.kjwo,
      phase_wo,
      phase_vk_brutto,
      phase_vk_netto,
      menge_abschrift_22,
      abschriftbetrag_netto_22,
      menge_abschrift_122 ,
      abschriftbetrag_netto_122,
      diff_wert_bestand_netto,
      menge_berechnet,
      menge_endbestand_phase, 
      menge, 
      umsatz_netto,
      mwst_id,
      t.wtag_phasenbeginn,
      t.dat_von,
      t.dat_bis,
      t.ranking
FROM dbp_etl.as_food_det_final_tmp_1 m
INNER JOIN dbp_etl.as_food_det_tmp_1 t
ON  m.mandant_id = t.mandant_id AND
    m.art_id = t.art_id AND
    m.kjwo = t.kjwo;


-- Brutto auf Netto rechnen!
UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT mandant_id AS mandant_id_
                                                            ,mwst_id AS mwst_id_
                                                            ,dat_von AS dat_von_
                                                            ,mwst AS mwst_
                                                            ,dat_bis AS dat_bis_
                                                      FROM dbp_data.mwst_per_1) dt1

SET phase_vk_netto = phase_vk_brutto/(mwst_ / 100+1)  --> phase_vk_netto is coming from ZRS_RVDATA
 
WHERE dat_auslistung BETWEEN dat_von_ AND dat_bis_
  AND mwst_id = mwst_id_
  AND mandant_id = mandant_id_
;

COMMIT;

--Menge Endbestand Phase!
UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT DISTINCT a.mandant_id,
                                                             a.art_id,
	                                                     a.wup_id,
	                                                     a.dat_auslistung,
	                                                     a.phase_id,
	                                                     a.max_kjwo,
	                                                     COALESCE(d.menge_lgbest_erp_frei_bme,0) AS menge_endbestand
                                                      FROM (SELECT mandant_id,
                                                                   art_id,
	                                                           wup_id,
	                                                           dat_auslistung,
	                                                           phase_id,
                                                                   wtag_phasenbeginn,
	                                                           MAX(kjwo) AS max_kjwo
                                                            FROM dbp_etl.as_food_det_final_1
                                                            GROUP BY 1,2,3,4,5,6) a  --- take kjwo for each phase	
                                                               INNER JOIN dbp_etl.as_food_det_final_1 b
                                                                 ON a.mandant_id = b.mandant_id
                                                                 AND a.art_id = b.art_id
                                                                 AND a.wup_id = b.wup_id
                                                                 AND a.dat_auslistung = b.dat_auslistung
                                                                 AND a.phase_id = b.phase_id
                                                                 AND a.max_kjwo = b.kjwo
                                                                 AND a.wtag_phasenbeginn = b.wtag_phasenbeginn													
							LEFT JOIN dbp_data.marktbestand_erp_1 d
                                                        ON a.mandant_id = d.mandant_id AND
                                                           a.wup_id = d.wup_id AND
	                                                   a.art_id = d.art_id AND
	                                                   b.dat_bis = d.dat) b -- take 'menge' from last day

SET menge_endbestand_phase = b.menge_endbestand

WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.kjwo = b.max_kjwo AND
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.phase_id = b.phase_id AND
      dbp_etl.as_food_det_final.ranking = 1
;

--Absatz reinholen!
UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT DISTINCT 
                                                        aa.mandant_id,
                                                        aa.kjwo,
							aa.art_id,
							aa.wup_id,
							aa.nb_id,
                                                        aa.phase_id,
							aa.menge,     
							aa.umsatz_netto
                                                FROM
                                                (SELECT a.mandant_id,
                                                        a.kjwo,
							a.art_id,
							a.wup_id,
							a.nb_id,
                                                        a.phase_id,
							SUM(d.menge) AS menge,     
							SUM(d.umsatz_netto) AS umsatz_netto
						      FROM dbp_etl.as_food_det_final_1 a
							  JOIN dbp_data.artbew_1 d						   
							 ON a.mandant_id = d.mandant_id AND 
							   a.art_id = d.art_id AND 
							   a.wup_id = d.wup_id AND 
							   a.nb_id = d.nb_id AND 
							   d.dat between a.dat_von and a.dat_bis
						      GROUP BY 1,2,3,4,5,6) aa) b

SET menge = b.menge,
    umsatz_netto = b.umsatz_netto
	
WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.kjwo = b.kjwo AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.nb_id = b.nb_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.phase_id = b.phase_id AND
      dbp_etl.as_food_det_final.ranking = 1 
;

--Zuspielen von Marktabschriften_1 und Artikelumbewertungen.
DROP TABLE IF EXISTS dbp_etl.markets_1;
CREATE TABLE dbp_etl.markets_1 
(
ranking integer
,wtag_phasenbeginn integer
,dat_von DATE 
,dat_bis DATE 
,kjwo INTEGER
,mandant_id BYTEINT NOT NULL    
,wup_id INTEGER NOT NULL
,nb_id SMALLINT NOT NULL 
,art_id INTEGER NOT NULL
)
;


INSERT INTO dbp_etl.markets_1 
(
        ranking,
        wtag_phasenbeginn,
        dat_von,
	    dat_bis,
	    kjwo,
        mandant_id,
        wup_id,
        nb_id,
        art_id
)
SELECT ranking,
       wtag_phasenbeginn,
       dat_von,
       dat_bis,
       kjwo,
       mandant_id,
       wup_id,
       nb_id,
       art_id
FROM dbp_etl.as_food_det_final_1
GROUP BY 1,2,3,4,5,6,7,8,9
;


-- Update Abschriften_1 fuer DE
DROP TABLE IF EXISTS dbp_etl.abschriften_1;
CREATE  TABLE dbp_etl.abschriften_1 
(
kjwo INTEGER
,mandant_id BYTEINT NOT NULL    
,wup_id INTEGER NOT NULL
,nb_id SMALLINT NOT NULL 
,art_id INTEGER NOT NULL
,menge_abschrift_22 DECIMAL(18,4)
,abschriftbetrag_netto_22 DECIMAL(18,4)
,menge_abschrift_122 DECIMAL(18,4)
,abschriftbetrag_netto_122 DECIMAL(18,4)
)
;


INSERT INTO dbp_etl.abschriften_1
SELECT 
       a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       SUM(CASE WHEN d.abschriftart_id = 22 THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_22,
       SUM(CASE WHEN d.abschriftart_id = 22 THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_22,
       SUM(CASE WHEN d.abschriftart_id IN (23,122) THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_122,
       SUM(CASE WHEN d.abschriftart_id IN (23,122) THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_122
FROM dbp_etl.markets_1 a
JOIN dbp_data.marktabschriften_1 d
  ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     --d.dat  between a.dat_von and a.dat_bis -- take whole week         
     a.kjwo = d.woche_id     
WHERE d.mandant_id = 1 AND  
      d.abschriftart_id IN (22,23,122)
GROUP BY 1,2,3,4,5
;


UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT * FROM dbp_etl.abschriften_1) b
										   
SET menge_abschrift_22 = b.menge_abschrift_22,
    abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
    menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122
	
WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.nb_id = b.nb_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.kjwo = b.kjwo AND 
      dbp_etl.as_food_det_final.ranking = 1 	
;

----NEW Abschriften_1 fuer KMO ----
DROP TABLE IF EXISTS dbp_etl.markets_kmo_1;

CREATE TABLE dbp_etl.markets_kmo_1 AS (
SELECT ranking,
       wtag_phasenbeginn,
       dat_von,
       dat_bis,
       kjwo,
       mandant_id,
       wup_id,
       nb_id,
       art_id,
       dat_auslistung 
FROM dbp_etl.as_food_det_final_1
WHERE mandant_id <> 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
)
;


DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_hist_new_1;

CREATE TABLE dbp_etl._abschriften_KMO_hist_new_1 AS (
SELECT a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_122,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_122
FROM dbp_etl.markets_kmo_1 a
JOIN DBP_DATA.marktabschriften_1 d
  ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     --d.dat  between a.dat_von and a.dat_bis            
     a.kjwo = d.woche_id
WHERE d.mandant_id <> 1 AND  
      d.abschriftart_id = 953 
GROUP BY 1,2,3,4,5,6
);
                        
DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_max_kjwo_1;

CREATE TABLE dbp_etl._abschriften_KMO_max_kjwo_1 AS (
SELECT MAX(a.kjwo) AS kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung
FROM (SELECT a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung
FROM dbp_etl.markets_kmo_1 a
WHERE a.mandant_id <> 1 --AND  
      --d.abschriftart_id = 953 
GROUP BY 1,2,3,4,5,6) a
--AND abschriftbetrag_netto_122 <> 0
GROUP BY 2,3,4,5,6
);

DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_max_pjwo1_1;

CREATE TABLE dbp_etl._abschriften_KMO_max_pjwo1_1 AS 
(
SELECT 
		  
			  
		 
		  
				  
			
		
			
						  
				  
					  
							
					   
							 
						   
				   
						  
		 
			   
	  
	   
       a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       MAX(b.pjwo) as pjwo
FROM dbp_etl._abschriften_KMO_max_kjwo_1 a
JOIN dbp_data.tag_1 b
  ON a.kjwo = b.kjwo
GROUP BY 1,2,3,4,5,6
)
;

DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_max_pjwo2_1;

CREATE TABLE dbp_etl._abschriften_KMO_max_pjwo2_1 AS 
		 
				
																								   
												  
	 
(
SELECT 
       a.kjwo,
       a.mandant_id,
       a.wup_id,
			 
					 
			   
		   
			   
					  
					 
						 
							   
								 
							 
							  
					  
							 
			
				  
								   
		   
 
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       MAX(b.pjwo) as pjwo
FROM dbp_etl._abschriften_KMO_max_pjwo1_1 a
JOIN dbp_data.tag_1 b
  ON a.pjwo = b.kjwo
GROUP BY 1,2,3,4,5,6)
;

--SELECT * FROM dbp_etl._abschriften_KMO_max_pjwo2_1;
DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_kjwo1_1;

CREATE TABLE dbp_etl._abschriften_KMO_kjwo1_1 AS (
SELECT a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_122,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_122
FROM DBP_DATA.marktabschriften_1 d
JOIN dbp_etl._abschriften_KMO_max_pjwo1_1 a
ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     d.woche_id = a.pjwo
WHERE d.abschriftart_id = 953
GROUP BY 1,2,3,4,5,6
);

DROP TABLE IF EXISTS dbp_etl._abschriften_KMO_kjwo2_1;

CREATE TABLE dbp_etl._abschriften_KMO_kjwo2_1 AS (
SELECT a.kjwo,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.dat_auslistung,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_122,
       SUM(CASE WHEN d.abschriftart_id = 953 THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_122
FROM DBP_DATA.marktabschriften_1 d
JOIN dbp_etl._abschriften_KMO_max_pjwo2_1 a
ON a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     d.woche_id = a.pjwo
WHERE d.abschriftart_id = 953
GROUP BY 1,2,3,4,5,6
);


UPDATE dbp_etl.as_food_det_final_1 a SET a.abschriftbetrag_netto_122 = b.abschrift_netto_kjwo,
                                             a.menge_abschrift_122 = CASE WHEN b.abschrift_netto_kjwo <> 0 THEN b.menge_abschrift ELSE 0 END
FROM 
(           
SELECT a.*, d.ABSCHRIFTBETRAG_NETTO_122 AS abschrift_netto_kjwo, d.menge_abschrift_122 AS menge_abschrift FROM dbp_etl.as_food_det_final_1 a
JOIN (SELECT mandant_id,wup_id,nb_id,art_id,kjwo,dat_auslistung,max(phase_id) AS phase_id
      FROM dbp_etl.as_food_det_final_1
															  
      GROUP BY 1,2,3,4,5,6
     ) b
ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.kjwo=b.kjwo AND
     a.phase_id=b.phase_id AND
     a.dat_auslistung=b.dat_auslistung
JOIN dbp_etl._abschriften_KMO_hist_new_1 d
ON   a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     a.kjwo=d.kjwo AND
     a.dat_auslistung=d.dat_auslistung
     
) b
WHERE a.mandant_id = b.mandant_id AND
      a.wup_id = b.wup_id AND
      a.nb_id = b.nb_id AND
      a.art_id = b.art_id AND
      a.kjwo = b.kjwo AND
      a.dat_auslistung = b.dat_auslistung AND
      a.phase_id = b.phase_id;



UPDATE dbp_etl.as_food_det_final_1 a SET a.abschriftbetrag_netto_122 = a.abschriftbetrag_netto_122 + b.abschrift_netto_kjwo,
                                             a.menge_abschrift_122 = CASE WHEN (a.abschriftbetrag_netto_122 <> 0 OR b.abschrift_netto_kjwo <> 0) THEN a.menge_abschrift_122+b.menge_abschrift ELSE a.menge_abschrift_122 END
FROM 
(           
SELECT a.*, d.ABSCHRIFTBETRAG_NETTO_122 AS abschrift_netto_kjwo, d.menge_abschrift_122 AS menge_abschrift FROM dbp_etl.as_food_det_final_1 a
JOIN (SELECT mandant_id,wup_id,nb_id,art_id,kjwo,dat_auslistung,max(phase_id) AS phase_id
      FROM dbp_etl.as_food_det_final_1
      GROUP BY 1,2,3,4,5,6
     ) b
ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.kjwo=b.kjwo AND
     a.phase_id=b.phase_id AND
     a.dat_auslistung=b.dat_auslistung
JOIN dbp_etl._abschriften_KMO_kjwo1_1 d
ON   a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     a.kjwo=d.kjwo AND
     a.dat_auslistung=b.dat_auslistung  
) b
WHERE a.mandant_id = b.mandant_id AND
      a.wup_id = b.wup_id AND
      a.nb_id = b.nb_id AND
      a.art_id = b.art_id AND
      a.kjwo = b.kjwo AND
      a.dat_auslistung = b.dat_auslistung AND
      a.phase_id = b.phase_id;


UPDATE dbp_etl.as_food_det_final_1 a SET a.abschriftbetrag_netto_122 = a.abschriftbetrag_netto_122 + b.abschrift_netto_kjwo,
                                             a.menge_abschrift_122 = CASE WHEN (a.abschriftbetrag_netto_122 <> 0 OR b.abschrift_netto_kjwo <> 0) THEN a.menge_abschrift_122+b.menge_abschrift ELSE a.menge_abschrift_122 END
FROM 
(           
SELECT a.*, d.ABSCHRIFTBETRAG_NETTO_122 AS abschrift_netto_kjwo, d.menge_abschrift_122 AS menge_abschrift FROM dbp_etl.as_food_det_final_1 a
JOIN (SELECT mandant_id,wup_id,nb_id,art_id,kjwo,dat_auslistung,max(phase_id) AS phase_id
      FROM dbp_etl.as_food_det_final_1
      GROUP BY 1,2,3,4,5,6
     ) b
ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
     a.kjwo=b.kjwo AND
     a.phase_id=b.phase_id AND
     a.dat_auslistung=b.dat_auslistung
JOIN dbp_etl._abschriften_KMO_kjwo2_1 d
ON   a.wup_id = d.wup_id AND
     a.mandant_id = d.mandant_id AND
     a.nb_id = d.nb_id AND
     a.art_id = d.art_id AND
     a.kjwo=d.kjwo AND
     a.dat_auslistung=b.dat_auslistung
) b
WHERE a.mandant_id = b.mandant_id AND
      a.wup_id = b.wup_id AND
      a.nb_id = b.nb_id AND
      a.art_id = b.art_id AND
      a.kjwo = b.kjwo AND
      a.dat_auslistung = b.dat_auslistung AND
      a.phase_id = b.phase_id;
									
						

-- Update Preisaenderung fuer KMO
UPDATE dbp_etl.as_food_det_final_1 FROM 
(SELECT DISTINCT
                                                             a.mandant_id,
                                                             a.art_id,
							     a.wup_id,
							     a.nb_id,
							     a.kjwo,
							     a.dat_auslistung,
                                                             a.phase_id,
                                                             a.phase_vk_netto,
							    (a.phase_vk_netto-b.phase_vk_netto)*a.menge AS diff_wert_bestand_netto
						      FROM dbp_etl.as_food_det_final_1 a
						      JOIN (SELECT DISTINCT mandant_id,
											art_id,
											wup_id,
											nb_id,
											dat_auslistung,
											phase_vk_netto,
                                                                                        dense_rank() over 
(partition by mandant_id, art_id, wup_id, dat_auslistung, phase_id order by kjwo desc) as rn
							    FROM dbp_etl.as_food_det_final_1
							    WHERE phase_id = 0 AND
								  mandant_id > 1 ) b
						        ON a.mandant_id = b.mandant_id AND
									a.art_id = b.art_id AND
									a.wup_id = b.wup_id AND
									a.nb_id = b.nb_id AND
									a.dat_auslistung = b.dat_auslistung 
                                                        WHERE rn = 1
) b 
										 
SET menge_abschrift_22 = CASE WHEN b.diff_wert_bestand_netto <> 0 THEN 1 ELSE 0 END,
    abschriftbetrag_netto_22 = b.diff_wert_bestand_netto,
    menge_berechnet = CASE WHEN b.diff_wert_bestand_netto <> 0 THEN 1 ELSE 0 END,
    diff_wert_bestand_netto = b.diff_wert_bestand_netto
	
WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.nb_id = b.nb_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.kjwo = b.kjwo AND
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung AND
      dbp_etl.as_food_det_final.phase_id = b.phase_id AND
      dbp_etl.as_food_det_final.phase_vk_netto = b.phase_vk_netto AND
      dbp_etl.as_food_det_final.ranking = 1 
;


COMMIT;


DROP TABLE IF EXISTS dbp_etl.snapshot_1;
CREATE TABLE dbp_etl.snapshot_1 
     (
        kjwo_kill INTEGER ,
        dat_final DATE ,
        dat_aend DATE ,
        art_id INTEGER ,
      mandant_id BYTEINT ,
      nb_id SMALLINT ,
      wup_id INTEGER ,
      dat_auslistung DATE ,
      phase_id BYTEINT ,
      kjwo INTEGER ,
      phase_wo INTEGER ,
      phase_vk_brutto DECIMAL(9,2) NOT NULL DEFAULT 0.00 ,
      phase_vk_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00 ,
      menge_abschrift_22 INTEGER NOT NULL DEFAULT 0   ,
      abschriftbetrag_netto_22 DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      menge_abschrift_122 INTEGER NOT NULL DEFAULT 0   ,
      abschriftbetrag_netto_122 DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      diff_wert_bestand_netto DECIMAL(18,4) NOT NULL DEFAULT 0.00   ,
      menge_berechnet DECIMAL(18,3) NOT NULL DEFAULT 0.000  ,
      menge_endbestand_phase DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      menge DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.000,
      mwst_id BYTEINT,
	  wtag_phasenbeginn BYTEINT,
	  dat_von DATE ,
	  dat_bis DATE ,
	  ranking BYTEINT
) ;



INSERT INTO dbp_etl.snapshot_1
SELECT distinct c.kjwo AS kjwo_kill,  --- determine last week until today from dat_final or aedat
       a.dat_final,
       a.dat_aend,
       b.*
FROM dbp_etl.as_food_final_1 a
JOIN dbp_data.tag_1 c
  ON COALESCE(a.dat_final,a.dat_aend) = c.dat -- join on dat_final or aedat
JOIN dbp_etl.as_food_det_final_1 b
  ON a.art_id = b.art_id AND
     a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat_auslistung = b.dat_auslistung AND
     b.kjwo >= c.kjwo  --- take all weeks >= week from dat_final or aedat
WHERE (a.erl_fg = 1 OR   --- with stock or dat_final <=DATE
      (a.dat_final IS NOT NULL AND
       a.dat_final <= current_date))
;


DROP TABLE IF EXISTS dbp_etl.absatz_konsolidiert_1;
CREATE TABLE dbp_etl.absatz_konsolidiert_1 
(
      mandant_id BYTEINT NOT NULL,
      kjwo INTEGER NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      menge DECIMAL(18,3) NOT NULL DEFAULT 0.000, 
      umsatz_netto DECIMAL(18,4) NOT NULL DEFAULT 0.000
) 
;


INSERT INTO dbp_etl.absatz_konsolidiert_1
SELECT d.mandant_id,
       a.kjwo_kill AS kjwo,
       d.art_id,
       d.wup_id,
       SUM(d.menge) AS menge,
       SUM(d.umsatz_netto) AS umsatz_netto
FROM
 (SELECT kjwo_kill,
             mandant_id,
             wup_id,
             art_id,
             dat_auslistung,
             dat_final,
             dat_aend,
			 wtag_phasenbeginn,
			 dat_von,
			 dat_bis
      FROM dbp_etl.snapshot_1
where kjwo_kill = kjwo -- take only the week with correct dat_von, dat_bis
      GROUP BY 1,2,3,4,5,6,7,8,9,10) a
		JOIN dbp_data.artbew_1 d						   
		ON a.mandant_id = d.mandant_id AND 
		a.art_id = d.art_id AND 
		a.wup_id = d.wup_id AND 
		d.dat  between a.dat_von and a.dat_bis -- take whole week  
		AND d.dat <= COALESCE(a.dat_final,a.dat_aend)
GROUP BY 1,2,3,4
;

DROP TABLE IF EXISTS dbp_etl.abschrift_konsolidiert_1;
CREATE  TABLE dbp_etl.abschrift_konsolidiert_1
(
      mandant_id BYTEINT NOT NULL,
      kjwo INTEGER NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      menge_abschrift_22 DECIMAL(18,4) NOT NULL DEFAULT 0.000, 
      abschriftbetrag_netto_22 DECIMAL(18,4) NOT NULL DEFAULT 0.000, 
      menge_abschrift_122 DECIMAL(18,4) NOT NULL DEFAULT 0.000, 
      abschriftbetrag_netto_122 DECIMAL(18,4) NOT NULL DEFAULT 0.000
)
;


INSERT INTO dbp_etl.abschrift_konsolidiert_1
SELECT d.mandant_id,
       a.kjwo_kill AS kjwo,
       d.art_id,
       d.wup_id,
       SUM(CASE WHEN d.abschriftart_id = 22 THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_22,
       SUM(CASE WHEN d.abschriftart_id = 22 THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_22,
       SUM(CASE WHEN d.abschriftart_id IN (23,122) THEN d.menge_abschrift ELSE 0 END) AS menge_abschrift_122,
       SUM(CASE WHEN d.abschriftart_id IN (23,122) THEN d.abschriftbetrag_netto ELSE 0 END) AS abschriftbetrag_netto_122
FROM
(SELECT      kjwo_kill,
             mandant_id,
             wup_id,
             art_id,
             dat_auslistung,
             dat_final,
             dat_aend,
             wtag_phasenbeginn,
             dat_von,
             dat_bis
      FROM dbp_etl.snapshot_1
where kjwo_kill = kjwo -- take only the week with correct dat_von, dat_bis
      GROUP BY 1,2,3,4,5,6,7,8,9,10) a
JOIN dbp_data.marktabschriften_1 d	
	 ON d.mandant_id = a.mandant_id AND
     d.art_id = a.art_id AND
     d.wup_id = a.wup_id AND
     d.dat <= COALESCE(a.dat_final,a.dat_aend) AND
     --d.dat  between a.dat_von and a.dat_bis 
     d.woche_id = a.kjwo_kill
WHERE d.mandant_id = 1 AND
      d.abschriftart_id IN (22,23,122)  
GROUP BY 1,2,3,4
;


UPDATE dbp_etl.snapshot_1 SET menge = 0 ,
                     umsatz_netto = 0,
                     menge_abschrift_22 = 0,
                     abschriftbetrag_netto_22 = 0,
                     menge_abschrift_122 = 0, 
                     abschriftbetrag_netto_122 = 0
WHERE mandant_id = 1
;


UPDATE dbp_etl.snapshot_1 SET menge = 0 ,
                     umsatz_netto = 0
WHERE mandant_id > 1
;


UPDATE dbp_etl.snapshot_1 FROM (SELECT *
                       FROM dbp_etl.absatz_konsolidiert_1) b
						
SET menge = b.menge,
    umsatz_netto = b.umsatz_netto

WHERE dbp_etl.snapshot.mandant_id = b.mandant_id AND
      dbp_etl.snapshot.kjwo = b.kjwo AND
      dbp_etl.snapshot.wup_id = b.wup_id AND
      dbp_etl.snapshot.art_id = b.art_id
;



UPDATE dbp_etl.snapshot_1 FROM (SELECT *
                       FROM dbp_etl.abschrift_konsolidiert_1) b
						
SET menge_abschrift_22 = b.menge_abschrift_22,
    abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
    menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122

WHERE dbp_etl.snapshot.mandant_id = b.mandant_id AND
      dbp_etl.snapshot.kjwo = b.kjwo AND
      dbp_etl.snapshot.wup_id = b.wup_id AND
      dbp_etl.snapshot.art_id = b.art_id
;



UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT * FROM dbp_etl.snapshot_1) b
										 
SET menge = b.menge,
    umsatz_netto = b.umsatz_netto,
    menge_abschrift_22 = b.menge_abschrift_22,
    abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
    menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122
	
WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.kjwo = b.kjwo AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung AND
      dbp_etl.as_food_det_final.phase_id = b.phase_id AND
      dbp_etl.as_food_det_final.phase_vk_netto = b.phase_vk_netto AND
      dbp_etl.as_food_det_final.ranking = 1
;


-- KMO (Preisaenderung fuer abgeschlossene)
UPDATE dbp_etl.as_food_det_final_1 FROM (SELECT DISTINCT a.mandant_id,
                                                             a.art_id,
                                                             a.wup_id,
                                                             a.nb_id,
                                                             a.kjwo,
                                                             a.dat_auslistung,
                                                             a.phase_id,
                                                             a.phase_vk_netto,
                                                            (a.phase_vk_netto-b.phase_vk_netto)*a.menge AS diff_wert_bestand_netto
                                                      FROM dbp_etl.snapshot_1 a
                                                      JOIN (SELECT DISTINCT mandant_id,
                                                                   art_id,
                                                                   wup_id,
                                                                   nb_id,
                                                                   dat_auslistung,
                                                                   phase_vk_netto,
                                                                 dense_rank() over 
(partition by mandant_id, art_id, wup_id, dat_auslistung, phase_id order by kjwo desc) as rn
                                                            FROM dbp_etl.as_food_det_final_1
                                                            WHERE phase_id = 0 AND
                                                                  mandant_id > 1) b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.art_id = b.art_id AND
                                                           a.wup_id = b.wup_id AND
                                                           a.nb_id = b.nb_id AND
                                                           a.dat_auslistung = b.dat_auslistung
                                                           WHERE rn = 1) b

SET menge_abschrift_22 = CASE WHEN b.diff_wert_bestand_netto <> 0 THEN 1 ELSE 0 END,
    abschriftbetrag_netto_22 = b.diff_wert_bestand_netto,
    menge_berechnet = CASE WHEN b.diff_wert_bestand_netto <> 0 THEN 1 ELSE 0 END,
    diff_wert_bestand_netto = b.diff_wert_bestand_netto

WHERE dbp_etl.as_food_det_final.mandant_id = b.mandant_id AND
      dbp_etl.as_food_det_final.wup_id = b.wup_id AND
      dbp_etl.as_food_det_final.nb_id = b.nb_id AND
      dbp_etl.as_food_det_final.art_id = b.art_id AND
      dbp_etl.as_food_det_final.kjwo = b.kjwo AND
      dbp_etl.as_food_det_final.dat_auslistung = b.dat_auslistung AND
      dbp_etl.as_food_det_final.phase_id = b.phase_id AND
      dbp_etl.as_food_det_final.phase_vk_netto = b.phase_vk_netto AND
      dbp_etl.as_food_det_final.ranking = 1
;

DELETE FROM DBP_DATA.as_food_det_1
WHERE (mandant_id,wup_id,nb_id,art_id,dat_auslistung,phase_id,kjwo) IN (SELECT mandant_id,wup_id,nb_id,art_id,dat_auslistung,phase_id,kjwo
                                                                           FROM DBP_ETL.as_food_det_final_1)
;

INSERT INTO dbp_data.as_food_det_1
SELECT art_id
      ,mandant_id
      ,nb_id
      ,wup_id
      ,dat_auslistung
      ,phase_id
      ,phase_wo
      ,phase_vk_brutto
      ,phase_vk_netto
      ,menge_abschrift_122 AS menge_totalabschrift
      ,abschriftbetrag_netto_122 AS betrag_totalabschrift_netto
      ,menge_abschrift_22 AS menge_preisabschrift
      ,abschriftbetrag_netto_22 AS betrag_preisabschrift_netto
      ,menge_endbestand_phase
      ,menge AS menge_absatz
      ,umsatz_netto
      ,current_timestamp
      ,current_timestamp
      ,kjwo
FROM dbp_etl.as_food_det_final_1;

COMMIT;
