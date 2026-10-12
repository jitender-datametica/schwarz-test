
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_LOAD_STATUS_KPI_ASIS_2( 
  client_id 
, country_iso_cd  
, store_id  
, wh_id 
, dat_dayend  
, kpi_id  
, data_deliv_fg 
, kpi_avbl_fg 
, mod_tmsp  
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
   SELECT 
     kpi.client_id, 
   kpi.country_cd AS country_iso_cd,  
   kpi.st_loc_sid AS store_id,  
   wh.src_wh_id AS wh_id, 
   kpi.dat_dayend,  
   kpi.kpi_id,  
   kpi.data_deliv_fg, 
   kpi.kpi_avbl_fg, 
   kpi.mod_tmsp 
  FROM p_lew_mart_msi.t_sys_load_status_kpi_asis_2 AS kpi 
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh  
   ON wh.client_id = kpi.client_id  
   AND wh.loc_sid_wh = kpi.wh_loc_sid 
   AND wh.dwh_actual_fg = 1 
;
