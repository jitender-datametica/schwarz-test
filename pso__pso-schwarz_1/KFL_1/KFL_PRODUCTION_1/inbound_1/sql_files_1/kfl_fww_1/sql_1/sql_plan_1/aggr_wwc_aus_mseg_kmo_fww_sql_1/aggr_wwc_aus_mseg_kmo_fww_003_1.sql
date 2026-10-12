DROP TABLE IF EXISTS DBP_ETL.kmo_mseg_dat_wwc_woche_1;

CREATE TABLE DBP_ETL.kmo_mseg_dat_wwc_woche_1  (
      dat_buch   DATE NOT NULL
     ,mandant_id BYTEINT NOT NULL
     ,kjwo_kl    INTEGER NOT NULL
) ;

INSERT INTO DBP_ETL.kmo_mseg_dat_wwc_woche_1
(	dat_buch,
	mandant_id,
	kjwo_kl
)
SELECT 	 wo.dat
	,wwc.mandant_id
	,wo.kjwo_kl
FROM 	DBP_ETL.kmo_mseg_dat_wwc_1 wwc

JOIN 	DBP_DATA.tag_1 tag_1
ON 	wwc.dat_buch = tag.dat

JOIN 	DBP_DATA.tag_1 wo
ON 	tag.kjwo_kl = wo.kjwo_kl

GROUP BY 1,2,3
;

DROP TABLE IF EXISTS DBP_ETL.lagerbew_wwc_tmp_woche_1;

CREATE TABLE DBP_ETL.lagerbew_wwc_tmp_woche_1  (
      mandant_id                BYTEINT NOT NULL,
      lagerbew_beleg_id         DECIMAL(18,0) NOT NULL, 
      lagerbew_beleg_pos_id     INTEGER NOT NULL ,
      wup_id                    SMALLINT NOT NULL,
      nb_id                     SMALLINT NOT NULL ,
      lager_bewart_id           CHAR(3) COLLATE 'en-ci' NOT NULL ,
      art_id                    INTEGER NOT NULL,
      gp_id                     INTEGER NOT NULL ,
      dat_buch                  DATE NOT NULL,
      betrag_lagerbew           DECIMAL(18,4),
      betrag_verkauf            DECIMAL(18,2)  ,
      menge_lagerbew_bme        DECIMAL(18,3) NOT NULL ,
      wrg_id                    CHAR(3) COLLATE 'en-ci' NOT NULL,
      betrag_vk_netto           DECIMAL(18,4),
      betrag_verkauf_ist        DECIMAL(18,4),
      betrag_verkauf_ist_netto  DECIMAL(18,4),
      betrag_exbwr              DECIMAL(18,4),
      kjwo_kl                   INTEGER,
      exvkw_gleich_vkwrt_fg     BYTEINT NOT NULL
      
       )
;

INSERT INTO DBP_ETL.lagerbew_wwc_tmp_woche_1 
(	mandant_id           
	,lagerbew_beleg_id    
	,lagerbew_beleg_pos_id
	,wup_id               
	,nb_id                
	,lager_bewart_id    
	,art_id  
	,gp_id
	,dat_buch             
	,betrag_lagerbew      
	,betrag_verkauf       
	,menge_lagerbew_bme   
	,wrg_id               
	,betrag_vk_netto      
	,betrag_verkauf_ist  
	,betrag_verkauf_ist_netto 
	,betrag_exbwr    
	,kjwo_kl
	,exvkw_gleich_vkwrt_fg
)
SELECT t1.mandant_id           
      ,t1.lagerbew_beleg_id    
      ,t1.lagerbew_beleg_pos_id
      ,t1.wup_id               
      ,t1.nb_id                
      ,t1.lager_bewart_id    
      ,t1.art_id  
      ,t1.gp_id
      ,t1.dat_buch             
      ,t1.betrag_lagerbew      
      ,t1.betrag_verkauf       
      ,t1.menge_lagerbew_bme   
      ,t1.wrg_id               
      ,t1.betrag_vk_netto      
      ,t1.betrag_verkauf_ist  
      ,t1.betrag_verkauf_ist_netto 
      ,wwc.betrag_exbwr    
      ,t1.kjwo_kl
      ,t1.exvkw_gleich_vkwrt_fg
FROM (SELECT dt.mandant_id
            ,dt.lagerbew_beleg_id
            ,dt.lagerbew_beleg_pos_id
            ,dt.wup_id
            ,dt.nb_id
            ,dt.lager_bewart_id
            ,dt.art_id
            ,dt.gp_id
            ,dt.dat_buch
            ,dt.betrag_lagerbew
            ,dt.betrag_verkauf 
            ,dt.menge_lagerbew_bme
            ,dt.wrg_id
            ,dt.betrag_vk_netto
            ,dt.betrag_verkauf_ist
            ,dt.betrag_verkauf_ist_netto
            ,wo.kjwo_kl
            ,CASE	WHEN dt.betrag_verkauf_ist  = dt.betrag_verkauf THEN 1
			ELSE 0             END AS exvkw_gleich_vkwrt_fg
      FROM DBP_DATA.lagerbew_det_1 dt
      JOIN DBP_ETL.kmo_mseg_dat_wwc_woche_1 wo
        ON dt.mandant_id = wo.mandant_id AND 
           dt.dat_buch   = wo.dat_buch
      ) t1_1
JOIN DBP_DATA.lagerbew_det_wwc_1 wwc
  ON t1.mandant_id            = wwc.mandant_id            AND
     t1.lagerbew_beleg_id     = wwc.lagerbew_beleg_id     AND
     t1.lagerbew_beleg_pos_id = wwc.lagerbew_beleg_pos_id AND
     t1.dat_buch              = wwc.dat_buch
;

DELETE FROM DBP_DATA.lagerbew_det_wwc_woche_1
WHERE (mandant_id, kjwo_kl) 
IN (SELECT mandant_id, kjwo_kl
    FROM DBP_ETL.kmo_mseg_dat_wwc_woche_1)
;

INSERT INTO DBP_DATA.lagerbew_det_wwc_woche_1 
(	art_id
	,mandant_id
	,wup_id
	,nb_id
        ,lager_bewart_id
        ,gp_id
        ,kjwo_kl
	,wrg_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,menge_lagerbew_bme
        ,betrag_vk_netto
        ,betrag_verkauf_ist
	,betrag_verkauf_ist_netto
        ,betrag_exbwr
        ,exvkw_gleich_vkwrt_fg
)
SELECT d.art_id
      ,d.mandant_id
      ,d.wup_id
      ,d.nb_id
      ,d.lager_bewart_id
      ,d.gp_id
      ,d.kjwo_kl
      ,d.wrg_id
      ,SUM(CAST((d.betrag_lagerbew ) AS DECIMAL(18,2))) AS betrag_lagerbew
      ,SUM(d.betrag_verkauf) AS betrag_verkauf
      ,SUM(d.menge_lagerbew_bme) AS menge_lagerbew_bme
      ,SUM(d.betrag_vk_netto) AS betrag_vk_netto 
      ,SUM(d.betrag_verkauf_ist) AS betrag_verkauf_ist   
      ,SUM(d.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto
      ,SUM(d.betrag_exbwr)  AS betrag_exbwr
      ,d.exvkw_gleich_vkwrt_fg
FROM DBP_ETL.lagerbew_wwc_tmp_woche_1 d
WHERE d.kjwo_kl >= 201001
GROUP BY 1,2,3,4,5,6,7,8,16
;

DROP TABLE IF EXISTS DBP_ETL.lagerbew_wwc_tmp_monat_1;

CREATE TABLE DBP_ETL.lagerbew_wwc_tmp_monat_1  (
      mandant_id                BYTEINT NOT NULL,
      lagerbew_beleg_id         DECIMAL(18,0) NOT NULL, 
      lagerbew_beleg_pos_id     INTEGER NOT NULL ,
      wup_id                    SMALLINT NOT NULL,
      nb_id                     SMALLINT NOT NULL ,
      lager_bewart_id           CHAR(3) COLLATE 'en-ci' NOT NULL ,
      art_id                    INTEGER NOT NULL,
      gp_id                     INTEGER NOT NULL ,
      dat_buch                  DATE NOT NULL,
      betrag_lagerbew           DECIMAL(18,4),
      betrag_verkauf            DECIMAL(18,2)  ,
      menge_lagerbew_bme        DECIMAL(18,3) NOT NULL ,
      wrg_id                    CHAR(3) COLLATE 'en-ci' NOT NULL,
      betrag_vk_netto           DECIMAL(18,4),
      betrag_verkauf_ist        DECIMAL(18,4),
      betrag_verkauf_ist_netto  DECIMAL(18,4),
      betrag_exbwr              DECIMAL(18,4),
      kjmo                      INTEGER,
      exvkw_gleich_vkwrt_fg     BYTEINT NOT NULL
       )
;

INSERT INTO DBP_ETL.lagerbew_wwc_tmp_monat_1 
(	mandant_id           
        ,lagerbew_beleg_id    
        ,lagerbew_beleg_pos_id
        ,wup_id               
        ,nb_id                
        ,lager_bewart_id    
        ,art_id  
        ,gp_id
        ,dat_buch             
        ,betrag_lagerbew      
        ,betrag_verkauf       
        ,menge_lagerbew_bme   
        ,wrg_id               
        ,betrag_vk_netto      
        ,betrag_verkauf_ist  
        ,betrag_verkauf_ist_netto 
        ,betrag_exbwr    
        ,kjmo
        ,exvkw_gleich_vkwrt_fg
)
SELECT t1.mandant_id           
      ,t1.lagerbew_beleg_id    
      ,t1.lagerbew_beleg_pos_id
      ,t1.wup_id               
      ,t1.nb_id                
      ,t1.lager_bewart_id    
      ,t1.art_id  
      ,t1.gp_id
      ,t1.dat_buch             
      ,t1.betrag_lagerbew      
      ,t1.betrag_verkauf       
      ,t1.menge_lagerbew_bme   
      ,t1.wrg_id               
      ,t1.betrag_vk_netto      
      ,t1.betrag_verkauf_ist  
      ,t1.betrag_verkauf_ist_netto 
      ,wwc.betrag_exbwr    
      ,t1.kjmo
      ,t1.exvkw_gleich_vkwrt_fg
FROM 
(	SELECT dt.mandant_id
            ,dt.lagerbew_beleg_id
            ,dt.lagerbew_beleg_pos_id
            ,dt.wup_id
            ,dt.nb_id
            ,dt.lager_bewart_id
            ,dt.art_id
            ,dt.gp_id
            ,dt.dat_buch
            ,dt.betrag_lagerbew
            ,dt.betrag_verkauf 
            ,dt.menge_lagerbew_bme
            ,dt.wrg_id
            ,dt.betrag_vk_netto
            ,dt.betrag_verkauf_ist
            ,dt.betrag_verkauf_ist_netto
            ,mo.kjmo
            ,CASE	WHEN dt.betrag_verkauf_ist  = dt.betrag_verkauf	THEN 1
			ELSE 0             END AS exvkw_gleich_vkwrt_fg
      FROM DBP_DATA.lagerbew_det_1 dt
      JOIN (SELECT x.mandant_id,
                   y.dat AS dat_buch,
                   x.kjmo
            FROM (	SELECT mandant_id, kjmo
			FROM DBP_ETL.kmo_mseg_dat_wwc_1
			GROUP BY 1,2
		  ) x
            JOIN DBP_DATA.tag_1 y
              ON x.kjmo = y.kjmo
	   ) mo
        ON dt.dat_buch = mo.dat_buch AND
           dt.mandant_id = mo.mandant_id
) t1_1
JOIN DBP_DATA.lagerbew_det_wwc_1 wwc
  ON t1.mandant_id            = wwc.mandant_id            AND
     t1.lagerbew_beleg_id     = wwc.lagerbew_beleg_id     AND
     t1.lagerbew_beleg_pos_id = wwc.lagerbew_beleg_pos_id AND
     t1.dat_buch              = wwc.dat_buch
;

DELETE FROM DBP_DATA.lagerbew_det_wwc_monat_1
WHERE (mandant_id, kjmo) 
IN (	SELECT mandant_id,kjmo
	FROM DBP_ETL.kmo_mseg_dat_wwc_1
    )
;

INSERT INTO DBP_DATA.lagerbew_det_wwc_monat_1 
(	art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,lager_bewart_id
        ,gp_id
        ,kjmo
        ,wrg_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,menge_lagerbew_bme
        ,betrag_vk_netto
        ,betrag_verkauf_ist
        ,betrag_verkauf_ist_netto
        ,betrag_exbwr
        ,exvkw_gleich_vkwrt_fg
)
SELECT d.art_id
      ,d.mandant_id
      ,d.wup_id
      ,d.nb_id
      ,d.lager_bewart_id
      ,d.gp_id
      ,d.kjmo
      ,d.wrg_id
      ,SUM(CAST((d.betrag_lagerbew ) AS DECIMAL(18,2))) AS betrag_lagerbew
      ,SUM(d.betrag_verkauf) AS betrag_verkauf
      ,SUM(d.menge_lagerbew_bme) AS menge_lagerbew_bme
      ,SUM(d.betrag_vk_netto) AS betrag_vk_netto 
      ,SUM(d.betrag_verkauf_ist) AS betrag_verkauf_ist   
      ,SUM(d.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto 
      ,SUM(d.betrag_exbwr)  AS betrag_exbwr
      ,d.exvkw_gleich_vkwrt_fg
FROM 	DBP_ETL.lagerbew_wwc_tmp_monat_1 d
WHERE 	d.kjmo >= 201001
GROUP BY 1,2,3,4,5,6,7,8,16
;

DROP TABLE IF EXISTS DBP_ETL.kmo_mseg_dat_wwc_1;
