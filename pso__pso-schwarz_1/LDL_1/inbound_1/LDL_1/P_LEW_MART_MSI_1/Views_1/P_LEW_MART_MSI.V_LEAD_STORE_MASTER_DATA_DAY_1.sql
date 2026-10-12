CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_LEAD_STORE_MASTER_DATA_DAY_1
( 
dat_calendar 
, client_id 
, store_id 
, open_store_fg 
, new_store_fg 
, moved_store_fg 
, closed_store_fg 
, real_closed_store_fg 
, sales_area 
, currency_iso_cd
, curr_tot_id 
, building_type_id
, building_status_id
, bereinigt_fg
, bereinigt_VJW_fg
, bereinigt_VJM_fg
, time_working_netto_fg
, bereinigt_vvj_fg
, bereinigt_VVJW_fg
, bereinigt_VVJM_fg
, bereinigt_vvvj_fg
, bereinigt_VVVJW_fg
, bereinigt_VVVJM_fg
 )
AS 
   SELECT
   dat_calendar 
   , client_id 
   , store_id 
   , open_store_fg
   , new_store_fg 
   , moved_store_fg
   , closed_store_fg
   , real_closed_store_fg
   , sales_area
   , currency_iso_cd
   , curr_tot_id 
   , building_type_id
   , building_status_id
   , bereinigt_fg
   , bereinigt_VJW_fg
   , bereinigt_VJM_fg
   , time_working_netto_fg
   , bereinigt_vvj_fg
   , bereinigt_VVJW_fg
   , bereinigt_VVJM_fg
   , bereinigt_vvvj_fg
   , bereinigt_VVVJW_fg
   , bereinigt_VVVJM_fg
   FROM P_LEW_MART_MSI.T_LEAD_STORE_MASTER_DATA_DAY_1;