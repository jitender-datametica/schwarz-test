--[OK] statement is translated correctly (syntax and type checks are fine)



DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.VIS_KUNDE_WUP_TMP_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.VIS_KUNDE_WUP_TMP_2 (
MANDANT_ID BIGNUMERIC NOT NULL,
NB_ID SMALLINT NOT NULL,
WUP_ID INTEGER NOT NULL,
WRG_ID STRING NOT NULL,
GJ SMALLINT NOT NULL,
KJMO INTEGER NOT NULL,
KJWO INTEGER NOT NULL,
MO_KJ BIGNUMERIC NOT NULL,
AKT_GJ SMALLINT NOT NULL,
AKT_MO SMALLINT NOT NULL,
AKT_WO SMALLINT NOT NULL,
AKT_TAG SMALLINT NOT NULL,
WTAG_ID BIGNUMERIC NOT NULL,
DAT DATE NOT NULL,
ANZ_KUNDE INTEGER,
ANZ_KUNDE_WVJ INTEGER,
ANZ_KUNDE_WVVJ INTEGER,
ANZ_KUNDE_KVJ INTEGER,
ANZ_KUNDE_KVVJ INTEGER,
ANZ_OFFEN INTEGER,
ANZ_OFFEN_WVJ INTEGER,
ANZ_OFFEN_WVVJ INTEGER,
ANZ_OFFEN_KVJ INTEGER,
ANZ_OFFEN_KVVJ INTEGER
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------


--original statement


--INSERT INTO $DWH_COMMON_DBX_LOAD.vis_kunde_wup_tmp_2


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


--   		,CASE WHEN t1.dat >= dat_bonanzahl_sug__dm THEN SUM(COALESCE(bonanzahl_sug,0)*akt_gj_fg) ELSE SUM(COALESCE(bonanzahl,0)*akt_gj_fg) END AS anz_kunde


--   		,CASE WHEN  t1.dat >= dat_bonanzahl_sug__dm + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_1_fg)  END AS anz_kunde_wvj


--   		,CASE WHEN  t1.dat >= dat_bonanzahl_sug__dm + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_wt_2_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_wt_2_fg)  END AS anz_kunde_wvvj


--   		,CASE WHEN  t1.dat >= dat_bonanzahl_sug__dm + 10000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_1_fg)  ELSE SUM(COALESCE(bonanzahl,0)*vj_1_fg)  END AS anz_kunde_kvj


--   		,CASE WHEN  t1.dat >= dat_bonanzahl_sug__dm + 20000 THEN SUM(COALESCE(bonanzahl_sug,0)*vj_2_fg)   ELSE SUM(COALESCE(bonanzahl,0)*vj_2_fg)  END AS anz_kunde_kvvj


--   		,SUM(COALESCE(offen,0)*akt_gj_fg)							as		anz_offen     


--   		,SUM(COALESCE(offen,0)*vj_wt_1_fg)						as		anz_offen_wvj  


--   		,SUM(COALESCE(offen,0)*vj_wt_2_fg)						as		anz_offen_wvvj 


--   		,SUM(COALESCE(offen,0)*vj_1_fg)								as		anz_offen_kvj 


--   		,SUM(COALESCE(offen,0)*vj_2_fg)								as		anz_offen_kvvj


--   	FROM                                                              


--   		$DWH_COMMON_DBX_LOAD.dat_vj_vergleich_2 t1_2                                   


--   	LEFT OUTER JOIN                                                   


--   		$DWH_COMMON_DBX_DATA.wupcal_2 t2                                             


--   	ON                                                                


--   		t1.join_dat=t2.dat                                              


--   	AND                                                               


--   		t1.mandant_id=t2.mandant_id                                     


--   	AND                                                               


--   		t1.wup_id=t2.wup_id       


--   	LEFT JOIN $DWH_COMMON_DBX_DATA.mandant_2 t3


--   	ON t1.mandant_id = t3.mandant_id                                       


--   	GROUP BY                                                          


--   		1,2,3,4,5,6,7,8,9,10,11,12,13,14                                              


--   ) dt2;


--


--Comment from validation checker


--MESSAGE: SQL compilation error:


--Can not convert parameter '0' of type [NUMBER(1,0)] into expected type [DATE]


--translated statement


INSERT INTO KFL_PRODUCTION_DBP_ETL.VIS_KUNDE_WUP_TMP_2
(
  MANDANT_ID,
  NB_ID,
  WUP_ID,
  WRG_ID,
  GJ,
  KJMO,
  KJWO,
  MO_KJ,
  AKT_GJ,
  AKT_MO,
  AKT_WO,
  AKT_TAG,
  WTAG_ID,
  DAT,
  ANZ_KUNDE,         
  ANZ_KUNDE_WVJ,    
  ANZ_KUNDE_WVVJ,   
  ANZ_KUNDE_KVJ,    
  ANZ_KUNDE_KVVJ,   
  ANZ_OFFEN,        
  ANZ_OFFEN_WVJ,    
  ANZ_OFFEN_WVVJ,   
  ANZ_OFFEN_KVJ,    
  ANZ_OFFEN_KVVJ  
)
SELECT
  MANDANT_ID,
  NB_ID,
  WUP_ID,
  WRG_ID,
  GJ,
  KJMO,
  KJWO,
  MO_KJ,
  AKT_GJ,
  AKT_MO,
  AKT_WO,
  AKT_TAG,
  WTAG_ID,
  DAT,
  ANZ_KUNDE,
  ANZ_KUNDE_WVJ,
  ANZ_KUNDE_WVVJ,
  ANZ_KUNDE_KVJ,
  ANZ_KUNDE_KVVJ,
  ANZ_OFFEN,     
  ANZ_OFFEN_WVJ, 
  ANZ_OFFEN_WVVJ,
  ANZ_OFFEN_KVJ, 
  ANZ_OFFEN_KVVJ
FROM (
  SELECT
    T1.MANDANT_ID AS MANDANT_ID,
    T1.NB_ID AS NB_ID,
    T1.WUP_ID AS WUP_ID,
    COALESCE(T3.DEFAULT_WRG, '') AS WRG_ID,
    T1.GJ AS GJ,
    T1.KJMO AS KJMO,
    T1.KJWO AS KJWO,
    T1.MO_KJ AS MO_KJ,
    T1.AKT_GJ,
    T1.AKT_MO,
    T1.AKT_WO,
    T1.AKT_TAG,
    T1.WTAG_ID,
    T1.DAT AS DAT,
    CASE
      WHEN CAST(FORMAT_DATE('%Y%M%D', T1.DAT) AS INT64) >= ${DAT_BONANZAHL_SUG}
        THEN SUM(COALESCE(BONANZAHL_SUG, 0) * AKT_GJ_FG)
      ELSE SUM(COALESCE(BONANZAHL, 0) * AKT_GJ_FG)
    END AS ANZ_KUNDE,
    CASE
      WHEN CAST(FORMAT_DATE('%Y%M%D', T1.DAT) AS INT64) >= ${DAT_BONANZAHL_SUG} + 10000
        THEN SUM(COALESCE(BONANZAHL_SUG, 0) * VJ_WT_1_FG)
      ELSE SUM(COALESCE(BONANZAHL, 0) * VJ_WT_1_FG)
    END AS ANZ_KUNDE_WVJ,
    CASE
      WHEN CAST(FORMAT_DATE('%Y%M%D', T1.DAT) AS INT64) >= ${DAT_BONANZAHL_SUG} + 20000
        THEN SUM(COALESCE(BONANZAHL_SUG, 0) * VJ_WT_2_FG)
      ELSE SUM(COALESCE(BONANZAHL, 0) * VJ_WT_2_FG)
    END AS ANZ_KUNDE_WVVJ,
    CASE
      WHEN CAST(FORMAT_DATE('%Y%M%D', T1.DAT) AS INT64) >= ${DAT_BONANZAHL_SUG} + 10000
        THEN SUM(COALESCE(BONANZAHL_SUG, 0) * VJ_1_FG)
      ELSE SUM(COALESCE(BONANZAHL, 0) * VJ_1_FG)
    END AS ANZ_KUNDE_KVJ,
    CASE
      WHEN CAST(FORMAT_DATE('%Y%M%D', T1.DAT) AS INT64) >= ${DAT_BONANZAHL_SUG} + 20000
        THEN SUM(COALESCE(BONANZAHL_SUG, 0) * VJ_2_FG)
      ELSE SUM(COALESCE(BONANZAHL, 0) * VJ_2_FG)
    END AS ANZ_KUNDE_KVVJ,
    SUM(COALESCE(OFFEN, 0) * AKT_GJ_FG) AS ANZ_OFFEN,
    SUM(COALESCE(OFFEN, 0) * VJ_WT_1_FG) AS ANZ_OFFEN_WVJ,
    SUM(COALESCE(OFFEN, 0) * VJ_WT_2_FG) AS ANZ_OFFEN_WVVJ,
    SUM(COALESCE(OFFEN, 0) * VJ_1_FG) AS ANZ_OFFEN_KVJ,
    SUM(COALESCE(OFFEN, 0) * VJ_2_FG) AS ANZ_OFFEN_KVVJ
  FROM KFL_PRODUCTION_DBP_ETL.DAT_VJ_VERGLEICH_2 AS T1_2
  LEFT JOIN KFL_PRODUCTION_DBP_DATA.WUPCAL_2 AS T2
    ON T1.JOIN_DAT = T2.DAT
    AND T1.MANDANT_ID = T2.MANDANT_ID
    AND T1.WUP_ID = T2.WUP_ID
  LEFT JOIN KFL_PRODUCTION_DBP_DATA.MANDANT_2 AS T3
    ON T1.MANDANT_ID = T3.MANDANT_ID
  GROUP BY
    T1.MANDANT_ID,
    T1.NB_ID,
    T1.WUP_ID,
    WRG_ID,
    T1.GJ,
    T1.KJMO,
    T1.KJWO,
    T1.MO_KJ,
    T1.AKT_GJ,
    T1.AKT_MO,
    T1.AKT_WO,
    T1.AKT_TAG,
    T1.WTAG_ID,
    T1.DAT
) DT2;



--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE KFL_PRODUCTION_DBP_ETL.VIS_KUNDE_WUP_TMP_2 SET
 WUP_ID = CAST(x1.WUP_ID_ AS INTEGER) FROM (SELECT T1.MANDANT_ID AS MANDANT_ID_,
   T1.NB_ID AS NB_ID_,
   T2.WUP_ID AS WUP_ID_,
   T1.WUP_ID AS WUP_ID_ALT_
  FROM KFL_PRODUCTION_DBP_DATA.WUP_2 AS T1_2
   INNER JOIN KFL_PRODUCTION_DBP_DATA.WUP_2 AS T2 ON T1.WUP_ID = T2.WUP_ID_ALT AND T1.NB_ID = T2.NB_ID AND T1.MANDANT_ID =
      T2.MANDANT_ID AND T2.DAT_VON <= CURRENT_DATE) AS x1
WHERE VIS_KUNDE_WUP_TMP.MANDANT_ID = x1.MANDANT_ID_ AND VIS_KUNDE_WUP_TMP.NB_ID = x1.NB_ID_ AND VIS_KUNDE_WUP_TMP.WUP_ID
   = x1.WUP_ID_ALT_;
