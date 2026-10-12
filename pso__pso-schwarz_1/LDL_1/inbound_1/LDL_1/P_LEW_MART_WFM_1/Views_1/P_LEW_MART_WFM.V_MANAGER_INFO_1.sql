CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_MANAGER_INFO_1
AS 
SELECT DISTINCT
      locctry.global_loc_ctry_cd AS country_iso_cd
    , locctry.src_wh_id AS wh_id
    , -1 AS store_id
    , locorg.sales_manager_id
    , COALESCE(locorg.sales_manager_name,'Bezirksleiter') AS sales_manager_name
    , locorg.account_manager_id
    , COALESCE(locorg.account_manager_name,'Vertriebsleiter') AS account_manager_name
    , locorg.general_manager_id
    , COALESCE(locorg.general_manager_name,'Geschaeftsfuehrer') AS general_manager_name 
FROM (
   SELECT  
     loc.client_id
   , loc.src_orig_store_nr
   , loc.loc_sid_store
   , loc.global_loc_ctry_cd
   , loc.src_wh_id
   FROM(
      --Ermitteln der Store - WH Beziehung von allen Stores die geöffnet und active sind
      SELECT  
        locstore.client_id
      , locstore.src_orig_store_nr
      , whdel.loc_sid_store
      , locstore.global_loc_ctry_cd AS global_loc_ctry_cd
      , locwh.src_wh_id 
      FROM p_lew_core_ac.v_location_1 AS locstore
      
      INNER JOIN p_lew_core_ac.v_store_to_wh_delivery_hist_1 AS whdel
         ON locstore.loc_sid = whdel.loc_sid_store
       AND whdel.deleted_fg = 0
       AND locstore.client_id = whdel.client_id
       AND CURRENT_DATE BETWEEN whdel.dwh_valid_from AND whdel.dwh_valid_to
       AND CURRENT_DATE BETWEEN whdel.active_from_dt AND whdel.active_to_dt
      
      INNER JOIN p_lew_core_ac.v_location_1 AS locwh
            ON whdel.loc_sid_wh = locwh.loc_sid
         AND whdel.client_id = locwh.client_id
         AND locwh.wh_store_mark = 'B'
         AND locwh.src_wh_id IS NOT NULL
         
      INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS mig 
         ON locstore.client_id = mig.client_id 
        
      WHERE locstore.src_store_id IS NOT NULL
         AND locstore.wh_store_mark = 'A'
         AND locstore.opening_dt <= CURRENT_DATE AND (locstore.closing_dt IS NULL OR locstore.closing_dt > CURRENT_DATE) 
         AND Current_Date BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
    ) AS loc
WHERE loc.global_loc_ctry_cd IS NOT NULL
) locctry

LEFT OUTER JOIN (
   SELECT  
     lo.client_id
   , lo.loc_sid_wh
   , lo.loc_sid_store
   , lo.sales_manager_id
   , lo.sales_manager_name
   , lo.account_manager_id
   , lo.account_manager_name
   , lo.general_manager_id
   , lo.general_manager_name  
   FROM p_lew_bil_ac.v_location_organization_1 AS lo
   WHERE lo.active_fg =1
   AND lo.dwh_actual_fg =1
   AND lo.account_manager_id <> -99
) AS locorg
ON locctry.client_id = locorg.client_id
AND locctry.loc_sid_store = locorg.loc_sid_store
       
WHERE locorg.sales_manager_id IS NOT NULL

UNION ALL

SELECT DISTINCT
  c.country_iso_cd                 AS country_iso_cd
, b.src_wh_id                        AS wh_id            
, -1                                          AS store_id
, sales_manager_id               AS sales_manager_id        
, COALESCE(sales_manager_name,'Bezirksleiter') AS sales_manager_name
, account_manager_id          AS account_manager_id    
, COALESCE(account_manager_name,'Vertriebsleiter')    AS account_manager_name  
, CAST(general_manager_id AS INTEGER) AS general_manager_id           
, COALESCE(general_manager_name,'Geschaeftsfuehrer') AS general_manager_name      
FROM ( SELECT 
                client_id
                ,st_loc_sid
                ,sales_manager_id 
                ,sales_manager_name
                ,account_manager_id
                ,account_manager_name
                ,general_manager_id
                ,general_manager_name               
            FROM  p_lew_core_ac.v_wawi_org_salesorg_1 AS org
            WHERE (org.client_id, org.st_loc_sid) IN
                (
                    SELECT stm.client_id
                          , stm.st_loc_sid
                    FROM p_lew_core_ac.v_wawi_org_salesorg_1 AS stm
                    WHERE CURRENT_DATE BETWEEN stm.dat_rec_start AND stm.dat_rec_end
                )
            QUALIFY ROW_NUMBER() OVER 
                (
                    PARTITION BY client_id, st_loc_sid 
                    ORDER BY CASE WHEN sales_manager_id <> -100 THEN 'Nicht-Dummies' ELSE 'Dummies' END DESC ,dat_rec_end DESC
                ) = 1     
            
  ) AS org  
     
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_skey_act_1  AS skey
     ON  org.client_id = skey.client_id
   AND org.st_loc_sid  = skey.st_loc_sid
  
                             
INNER JOIN p_lew_core_ac.v_location_1 AS b
    ON skey.client_id = b.client_id
    AND skey.wh_loc_sid = b.loc_sid

INNER JOIN p_lew_core_ac.v_wawi_org_store_act_1 AS a
    ON  a.client_id = skey.client_id
    AND a.wh_loc_sid = skey.wh_loc_sid
    AND a.st_loc_sid = skey.st_loc_sid

INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_1 AS cc
    ON  skey.client_id = cc.client_id

INNER JOIN p_lew_core_ac.v_wawi_ref_country_1 AS c
    ON  cc.country_id = c.country_id
    
INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS mig 
    ON cc.client_id = mig.client_id 

WHERE (
(a.dat_opening_ovis <= CURRENT_DATE AND a.dat_closing_ovis IS NULL)
    OR 
(a.dat_opening_ovis <= CURRENT_DATE AND a.dat_closing_ovis > CURRENT_DATE)
 )
 AND (a.client_id,skey.orig_store_nr) NOT IN 
(
    SELECT wh.client_id, loc.src_wh_id 
    FROM p_lew_core_ac.v_wawi_org_wh_1 AS wh
    
    INNER JOIN p_lew_core_ac.v_location_1 as loc
    ON wh.client_id = loc.client_id 
    AND wh.wh_loc_sid = loc.loc_sid
    
    WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end 
        AND CURRENT_DATE > dat_opening 
)
  AND (    Current_Date < mig.migration_dat_valid_from
        OR Current_Date > mig.migration_dat_valid_to
      )
;