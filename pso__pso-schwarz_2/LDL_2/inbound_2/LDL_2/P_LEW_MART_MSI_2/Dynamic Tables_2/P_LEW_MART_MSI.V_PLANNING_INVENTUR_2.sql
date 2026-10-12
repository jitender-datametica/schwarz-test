
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLANNING_INVENTUR_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
  
   /*INT-A-102 Inventur_2 (nicht Koexistent --> muss nachgezogen werden wenn die bdo_Coex_view angepasst ist)*/ 
   SELECT 
      a16.cy_month cy_month,  
   a16.cy_month_name cy_month_name, 
   a14.country_id country_id, 
   TRIM(a18.country_iso_cd) country_iso_cd, 
   a13.wh_id wh_id, 
   a13.client_id client_id, 
   a17.wh_desc wh_desc, 
   a13.store_id store_id, 
   a13.orig_store_nr, 
   a15.store_desc store_desc, 
   pa11.anzahlfilialenmitumsatzwawi anzahlfilialenmitumsatzwawi,  
   pa12.anzahlinventuren anzahlinventuren,  
   pa12.inventurdifferenzenlautsic inventurdifferenzenlautsic,  
   pa12.inventurumsatzlautsic inventurumsatzlautsic,  
   (pa12.inventurdifferenzenlautsic / CASE WHEN pa12.inventurumsatzlautsic = 0 THEN NULL ELSE pa12.inventurumsatzlautsic END * 100) inventurverlustinprozent  
   FROM 
   (  
     SELECT 
        a13.cy_month cy_month,  
   a12.store_id store_id, 
   a12.client_id client_id, 
   COUNT  
     (  
       DISTINCT 
          CASE WHEN a11.val_retail_asis <> 0  
               THEN ((a11.store_id * 100) + a11.client_id)  
          END 
     ) anzahlfilialenmitumsatzwawi  
     FROM p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_2 a11  
   INNER JOIN p_lew_mart_msi.v_org_store_skey_2 a12 
   ON a11.client_id = a12.client_id 
   AND a11.store_id = a12.store_id  
   INNER JOIN p_lew_mart_msi.v_cal_calendarday_2 a13  
   ON a11.dat_formdate = a13.dat_calendar 
   INNER JOIN p_lew_mart_msi.v_org_store_2 a14  
   ON a12.client_id = a14.client_id 
   AND a12.store_id = a14.store_id  
  
 WHERE  
   (  
  a13.dat_calendar BETWEEN a14.dat_opening AND a14.dat_closing  
     OR 
     (  
       a13.dat_calendar >= a14.dat_opening  
       AND a14.dat_closing IS NULL  
     )  
) 
   AND a11.currency_iso_cd = 'EUR'  
   GROUP BY a13.cy_month, a12.store_id, a12.client_id 
) pa11  
   FULL OUTER JOIN  
   (  
     SELECT 
        a12.cy_month cy_month,  
   a13.store_id store_id, 
   a13.client_id client_id, 
   COUNT  
     (  
       DISTINCT 
          CASE WHEN a11.diff_inv <> 0 
               THEN a11.inv_id  
          END 
     ) anzahlinventuren,  
   SUM(a11.diff_inv) inventurdifferenzenlautsic,  
   SUM(a11.val_retail_store_inv_stc) inventurumsatzlautsic  
     FROM p_lew_mart_msi.v_inv_store_2 a11  
   INNER JOIN p_lew_mart_msi.v_cal_calendarday_2 a12  
   ON a11.dat_valid_until = a12.dat_calendar  
   INNER JOIN p_lew_mart_msi.v_org_store_skey_2 a13 
   ON a11.client_id = a13.client_id 
   AND a11.store_id = a13.store_id  
  
 WHERE a11.currency_iso_cd = 'EUR'  
 GROUP BY a12.cy_month, a13.store_id, a13.client_id 
) pa12  
   ON pa11.client_id = pa12.client_id 
   AND pa11.cy_month = pa12.cy_month  
   AND pa11.store_id = pa12.store_id  
   INNER JOIN p_lew_mart_msi.v_org_store_skey_2 a13 
   ON COALESCE(pa11.client_id, pa12.client_id) = a13.client_id  
   AND COALESCE(pa11.store_id, pa12.store_id) = a13.store_id  
   INNER JOIN p_lew_mart_msi.v_ref_client_2 a14 
   ON a13.client_id = a14.client_id 
   INNER JOIN p_lew_mart_msi.v_org_store_2 a15  
   ON a13.client_id = a15.client_id 
   AND a13.store_id = a15.store_id  
   INNER JOIN p_lew_mart_msi.v_cal_month_desc_2 a16 
   ON COALESCE(pa11.cy_month, pa12.cy_month) = a16.cy_month 
   INNER JOIN p_lew_mart_msi.v_org_wh_2 a17 
   ON a13.client_id = a17.client_id 
   AND a13.wh_id = a17.wh_id  
   INNER JOIN p_lew_mart_msi.v_ref_country_2 a18  
   ON a14.country_id = a18.country_id 
;
