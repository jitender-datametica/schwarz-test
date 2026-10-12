create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ITEM_STORE_STORAGE_STOCK_HIST_1(
	CLIENT_ID,
	ITEM_SID,
	LOC_SID,
	STORE_STORAGE_QTY,
	DELETED_FG,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
 client_id         
 ,item_sid          
 ,loc_sid           
 ,store_storage_qty 
 ,deleted_fg        
 ,dwh_valid_from    
 ,dwh_valid_to      
 ,dwh_load_id       
 ,dwh_created       
 ,dwh_updated
 FROM P_LEW_CORE.T_ITEM_STORE_STORAGE_STOCK_HIST_1
 ;
