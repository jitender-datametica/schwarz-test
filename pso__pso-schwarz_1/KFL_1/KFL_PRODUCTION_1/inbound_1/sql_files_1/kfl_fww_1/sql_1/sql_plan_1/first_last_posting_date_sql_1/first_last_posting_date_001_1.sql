--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbew_art_bewart_zu_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.lagerbew_art_bewart_zu_1  (
      art_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      lager_bewart_id CHAR(3) COLLATE 'en-ci' NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      dat_buch_first DATE NOT NULL,
      dat_buch_last DATE NOT NULL,
      dat_erfasst_first DATE NOT NULL,
      dat_erfasst_last DATE NOT NULL)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.lagerbew_art_bewart_zu_1
(
mandant_id                    
,art_id                        
,wup_id                        
,nb_id                         
,lager_bewart_id               
,dat_buch_first                   
,dat_buch_last                    
,dat_erfasst_first             
,dat_erfasst_last              
) SELECT a.mandant_id AS mandan_id, a.art_id AS art_id, a.wup_id AS wup_id, a.nb_id AS nb_id, a.lager_bewart_id AS lager_bewart_id, MIN(a.dat_buch) AS dat_buch_first, MAX(a.dat_buch) AS dat_buch_last
,MIN(b.dat_erfasst) AS dat_erfasst_first, MAX(b.dat_erfasst) AS dat_erfasst_last

FROM DBP_DATA.lagerbew_det_1 a
JOIN DBP_DATA.lagerbew_1 b
ON a.mandant_id = b.mandant_id
AND a.dat_buch = b.dat_buch
AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
WHERE  a.dat_buch BETWEEN CURRENT_DATE -45  AND CURRENT_DATE

GROUP BY 1,2,3,4,5;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.lagerbew_art_bewart_zu_1
FROM  DBP_ETL.lagerbew_art_bewart_zu_1  dt

SET dat_buch_last         =     dt.dat_buch_last   
   
,dat_erfasst_last           =dt.dat_erfasst_last   
WHERE DBP_DATA.lagerbew_art_bewart_zu.mandant_id = dt.mandant_id
AND DBP_DATA.lagerbew_art_bewart_zu.art_id = dt.art_id
AND DBP_DATA.lagerbew_art_bewart_zu.wup_id = dt.wup_id
AND DBP_DATA.lagerbew_art_bewart_zu.lager_bewart_id = dt.lager_bewart_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbew_art_bewart_zu_1
(
mandant_id                    
,art_id                        
,wup_id                        
,nb_id                         
,lager_bewart_id               
,dat_buch_first                   
,dat_buch_last                    
,dat_erfasst_first             
,dat_erfasst_last              
) SELECT  mandant_id                    
,art_id                        
,wup_id                        
,nb_id                         
,lager_bewart_id               
,dat_buch_first                   
,dat_buch_last                    
,dat_erfasst_first             
,dat_erfasst_last      
FROM
DBP_ETL.lagerbew_art_bewart_zu_1
WHERE (mandant_id,art_id, wup_id, lager_bewart_id)
NOT IN 
(SELECT mandant_id, art_id,wup_id,lager_bewart_id
FROM DBP_DATA.lagerbew_art_bewart_zu_1
);

