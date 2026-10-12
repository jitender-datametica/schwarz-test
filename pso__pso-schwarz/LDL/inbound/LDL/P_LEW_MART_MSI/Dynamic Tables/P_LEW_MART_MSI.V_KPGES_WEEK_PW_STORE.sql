
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_WEEK_PW_STORE 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   */ 
   SELECT   
   iweek.client_id,  
   osk.orig_store_nr,   
   osk.st_loc_sid AS store_id,   
   iweek.indicator_id,  
   pweek.cy_week_partial_week_id,   
   CASE WHEN pweek.cy_week_partial_week_id2 = 9 THEN  
   CASE WHEN iweek.indicator_id IN (117,120,125,126,133,135,136,155,156,157,163,168,   
   169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250,  
   251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286)   
   THEN iweek.val_indicator / cry.rate_currency_exchange ELSE iweek.val_indicator END  
   ELSE NULL END AS val_indicator,  
   cry.currency_iso_cd, 
   iweek.dat_dayend  
   
   FROM p_lew_core_ac.v_wawi_indicator_week AS iweek  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON  iweek.client_id = cry.client_id 
   AND iweek.indicator_type_id = 1  
   AND iweek.org_type_id = 90 
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act AS osk   
   ON  osk.client_id = iweek.client_id 
   AND osk.orig_store_nr = iweek.org_unit_nr 
   INNER JOIN p_lew_core_ac.v_wawi_cal_week_partial_week AS pweek 
   ON pweek.cy_week_partial_week_id1 = iweek.cy * 100 + iweek.cal_week  
;
