--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.vis_kunde_wup_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.vis_kunde_wup_tmp_2  (
  mandant_id BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL,
  wup_id INTEGER NOT NULL,
  wrg_id CHAR(3) NOT NULL,
  gj SMALLINT NOT NULL,
  kjmo INTEGER NOT NULL,
  kjwo INTEGER NOT NULL,
  mo_kj BYTEINT NOT NULL,
  akt_gj SMALLINT NOT NULL,
  akt_mo SMALLINT NOT NULL,
  akt_wo SMALLINT NOT NULL,
  akt_tag SMALLINT NOT NULL,
  wtag_id BYTEINT NOT NULL,
  dat DATE NOT NULL,
  anz_kunde INTEGER,
  anz_kunde_wvj INTEGER,
  anz_kunde_wvvj INTEGER,
  anz_kunde_kvj INTEGER,
  anz_kunde_kvvj INTEGER,
  anz_offen INTEGER,
  anz_offen_wvj INTEGER,
  anz_offen_wvvj INTEGER,
  anz_offen_kvj INTEGER,
  anz_offen_kvvj INTEGER                   
                                              
  )                     
  ;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_kunde_wup_tmp_2
-- (
-- mandant_id,
-- nb_id,
-- wup_id,
-- wrg_id,
-- gj,
-- kjmo,
-- kjwo,
-- mo_kj,
-- akt_gj,
-- akt_mo,
-- akt_wo,
-- akt_tag,
-- wtag_id,
-- dat,
-- anz_kunde,         
-- anz_kunde_wvj,    
-- anz_kunde_wvvj,   
-- anz_kunde_kvj,    
-- anz_kunde_kvvj,   
-- anz_offen,        
-- anz_offen_wvj,    
-- anz_offen_wvvj,   
-- anz_offen_kvj,    
-- anz_offen_kvvj  
-- )
--  SELECT
--   mandant_id,
--   nb_id,
--   wup_id,
--   wrg_id,
--   gj,
--   kjmo,
--   kjwo,
--   mo_kj,
--   akt_gj,
--   akt_mo,
--   akt_wo,
--   akt_tag,
--   wtag_id,
--   dat,
--   anz_kunde,
--   anz_kunde_wvj,
--   anz_kunde_wvvj,
--   anz_kunde_kvj,
--   anz_kunde_kvvj,
--   anz_offen,     
--   anz_offen_wvj, 
--   anz_offen_wvvj,
--   anz_offen_kvj, 
--   anz_offen_kvvj
--  FROM 
--   (
--   	SELECT                                                            
--   		 t1.mandant_id																as		mandant_id    
--   		,t1.nb_id																			as		nb_id         
--   		,t1.wup_id																		AS		wup_id 
--   		,COALESCE(t3.default_wrg,'')                  AS    wrg_id
--   		,t1.gj																		    AS    gj
--   		,t1.kjmo																			as		kjmo          
--   		,t1.kjwo																			as		kjwo
--   		,t1.mo_kj																			AS		mo_kj
--   		,t1.akt_gj
--   		,t1.akt_mo
--   		,t1.akt_wo
--   		,t1.akt_tag
--   		,t1.wtag_id  
--   		,t1.dat																				as		dat         
--   		,CASE WHEN t1.dat >= ${DAT_BONANZAHL_SUG} THEN SUM(COALESCE(bonanzahl_sug,0)*akt_gj_fg) ELSE SUM(COALESCE(bonanzahl,0)*akt_gj_fg) END AS anz_kunde
--   		,CASE WHEN  t1.dat >= ${DAT_BONANZAHL_SUG} + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_1_fg)  END AS anz_kunde_wvj
--   		,CASE WHEN  t1.dat >= ${DAT_BONANZAHL_SUG} + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_2_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_2_fg)  END AS anz_kunde_wvvj
--   		,CASE WHEN  t1.dat >= ${DAT_BONANZAHL_SUG} + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_1_fg)  END AS anz_kunde_kvj
--   		,CASE WHEN  t1.dat >= ${DAT_BONANZAHL_SUG} + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_2_fg)   ELSE SUM(COALESCE(bonanzahl,0)*vj_2_fg)  END AS anz_kunde_kvvj
--   		,SUM(COALESCE(offen,0)*akt_gj_fg)							as		anz_offen     
--   		,SUM(COALESCE(offen,0)*vj_wt_1_fg)						as		anz_offen_wvj  
--   		,SUM(COALESCE(offen,0)*vj_wt_2_fg)						as		anz_offen_wvvj 
--   		,SUM(COALESCE(offen,0)*vj_1_fg)								as		anz_offen_kvj 
--   		,SUM(COALESCE(offen,0)*vj_2_fg)								as		anz_offen_kvvj
--   	FROM                                                              
--   		${DWH_COMMON_DBX_LOAD}.dat_vj_vergleich_2 t1_2                                   
--   	LEFT OUTER JOIN                                                   
--   		${DWH_COMMON_DBX_DATA}.wupcal_2 t2                                             
--   	ON                                                                
--   		t1.join_dat=t2.dat                                              
--   	AND                                                               
--   		t1.mandant_id=t2.mandant_id                                     
--   	AND                                                               
--   		t1.wup_id=t2.wup_id       
--   	LEFT JOIN ${DWH_COMMON_DBX_DATA}.mandant_2 t3
--   	ON t1.mandant_id = t3.mandant_id                                       
--   	GROUP BY                                                          
--   		1,2,3,4,5,6,7,8,9,10,11,12,13,14                                              
--   ) dt2;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Can not convert parameter '0' of type [NUMBER(1,0)] into expected type [DATE]
--translated statement
INSERT INTO DBP_ETL.vis_kunde_wup_tmp_2
 (
 mandant_id,
 nb_id,
 wup_id,
 wrg_id,
 gj,
 kjmo,
 kjwo,
 mo_kj,
 akt_gj,
 akt_mo,
 akt_wo,
 akt_tag,
 wtag_id,
 dat,
 anz_kunde,         
 anz_kunde_wvj,    
 anz_kunde_wvvj,   
 anz_kunde_kvj,    
 anz_kunde_kvvj,   
 anz_offen,        
 anz_offen_wvj,    
 anz_offen_wvvj,   
 anz_offen_kvj,    
 anz_offen_kvvj  
 )
  SELECT
   mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   gj,
   kjmo,
   kjwo,
   mo_kj,
   akt_gj,
   akt_mo,
   akt_wo,
   akt_tag,
   wtag_id,
   dat,
   anz_kunde,
   anz_kunde_wvj,
   anz_kunde_wvvj,
   anz_kunde_kvj,
   anz_kunde_kvvj,
   anz_offen,     
   anz_offen_wvj, 
   anz_offen_wvvj,
   anz_offen_kvj, 
   anz_offen_kvvj
  FROM 
   (
   	SELECT                                                            
   		 t1.mandant_id	as mandant_id    
   		,t1.nb_id as nb_id         
   		,t1.wup_id AS wup_id 
   		,COALESCE(t3.default_wrg,'') AS    wrg_id
   		,t1.gj AS    gj
   		,t1.kjmo as		kjmo          
   		,t1.kjwo as		kjwo
   		,t1.mo_kj AS		mo_kj
   		,t1.akt_gj
   		,t1.akt_mo
   		,t1.akt_wo
   		,t1.akt_tag
   		,t1.wtag_id  
   		,t1.dat as		dat        
   		,CASE WHEN TO_NUMBER(to_char(t1.dat ,'YYYYMMDD'),'99999999') >= ${DAT_BONANZAHL_SUG} THEN SUM(COALESCE(bonanzahl_sug,0)*akt_gj_fg) ELSE SUM(COALESCE(bonanzahl,0)*akt_gj_fg) END AS anz_kunde
   		,CASE WHEN  TO_NUMBER(to_char(t1.dat ,'YYYYMMDD'),'99999999')  >= ${DAT_BONANZAHL_SUG} + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_1_fg)  END AS anz_kunde_wvj
   		,CASE WHEN  TO_NUMBER(to_char(t1.dat ,'YYYYMMDD'),'99999999')  >= ${DAT_BONANZAHL_SUG} + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_2_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_2_fg)  END AS anz_kunde_wvvj
   		,CASE WHEN  TO_NUMBER(to_char(t1.dat ,'YYYYMMDD'),'99999999')  >= ${DAT_BONANZAHL_SUG} + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_1_fg)  END AS anz_kunde_kvj
   		,CASE WHEN  TO_NUMBER(to_char(t1.dat ,'YYYYMMDD'),'99999999')  >= ${DAT_BONANZAHL_SUG} + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_2_fg)   ELSE SUM(COALESCE(bonanzahl,0)*vj_2_fg)  END AS anz_kunde_kvvj
   		,SUM(COALESCE(offen,0)*akt_gj_fg) as anz_offen     
   		,SUM(COALESCE(offen,0)*vj_wt_1_fg) as anz_offen_wvj  
   		,SUM(COALESCE(offen,0)*vj_wt_2_fg) as anz_offen_wvvj 
   		,SUM(COALESCE(offen,0)*vj_1_fg) as anz_offen_kvj 
   		,SUM(COALESCE(offen,0)*vj_2_fg) as anz_offen_kvvj
   	FROM                                                              
   		DBP_ETL.dat_vj_vergleich_2 t1_2                                   
   	LEFT OUTER JOIN                                                   
   		DBP_DATA.wupcal_2 t2                                             
   	ON                                                                
   		t1.join_dat=t2.dat                                              
   	AND                                                               
   		t1.mandant_id=t2.mandant_id                                     
   	AND                                                               
   		t1.wup_id=t2.wup_id       
   	LEFT JOIN DBP_DATA.mandant_2 t3
   	ON t1.mandant_id = t3.mandant_id                                       
   	GROUP BY                                                          
   		1,2,3,4,5,6,7,8,9,10,11,12,13,14                                              
   ) dt2;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.vis_kunde_wup_tmp_2


SET wup_id = wup_id_

FROM
(
SELECT
  t1.mandant_id as mandant_id_
 ,t1.nb_id AS nb_id_
 ,t2.wup_id AS wup_id_
 ,t1.wup_id AS wup_id_alt_
 FROM DBP_DATA.wup_2 t1_2
 INNER JOIN DBP_DATA.wup_2 t2
 ON t2.wup_id_alt = t1.wup_id
 AND t2.nb_id = t1.nb_id
 AND t2.mandant_id = t1.mandant_id
 AND t2.dat_von <= CURRENT_DATE) x1
 WHERE mandant_id = mandant_id_
AND nb_id = nb_id_
AND wup_id = wup_id_alt_
;

