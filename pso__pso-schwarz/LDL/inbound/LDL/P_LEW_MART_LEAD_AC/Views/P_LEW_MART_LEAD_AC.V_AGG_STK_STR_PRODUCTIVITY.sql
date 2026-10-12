/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view p_LEW_MART_LEAD_AC.V_AGG_STK_STR_PRODUCTIVITY
#----------------------------------------------------------------------------
# History:
#  1.0    2021-07-10         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_agg_stk_str_productivity 
(
    client_id                      COMMENT 'MIS Client ID'                                     
    , loc_sid_store_move_to        COMMENT 'enthält surrogate Key des Stores moved'            
    , currency_iso_cd              COMMENT 'Währung ISO Code'                                  
    , cy_week_partial_week_id      COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'      
    , cy_month                     COMMENT 'Geschäftsjahr'                                     
    , busyear                      COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'           
    , stk_str_prod_wday1           COMMENT 'Stueckleistung am ersten Tag der Woche'            
    , stk_str_prod_wday2           COMMENT 'Stueckleistung am zweiten Tag der Woche'           
    , stk_str_prod_wday3           COMMENT 'Stueckleistung am dritten Tag der Woche'           
    , stk_str_prod_wday4           COMMENT 'Stueckleistung am vierten Tag der Woche'           
    , stk_str_prod_wday5           COMMENT 'Stueckleistung am fünften Tag der Woche'           
    , stk_str_prod_wday6           COMMENT 'Stueckleistung am sechsten Tag der Woche'          
    , stk_str_prod_wday7           COMMENT 'Stueckleistung am siebten Tag der Woche'           
    , stk_str_prod_wktd            COMMENT 'Stueckleistung wöchentlich'                        
    , stk_str_prod_mtd             COMMENT 'Stueckleistung Monat bis zum Datum'                
    , stk_str_prod_bytd            COMMENT 'Stueckleistung Jahr bis Datum'                     
    , del_stk_plan_wktd            COMMENT 'Delta plan wöchentlich'                            
    , del_stk_plan_mtd             COMMENT 'Delta plan Monat bis zum Datum'                    
    , del_stk_plan_bytd            COMMENT 'Delta plan Jahr bis Datum'                         
    , del_stk_pep_wktd             COMMENT 'Delta Pep wöchentlich'                             
    , del_stk_pep_mtd              COMMENT 'Delta Pep Monat bis zum Datum'                     
    , del_stk_pep_bytd             COMMENT 'Delta Pep Jahr bis Datum'                          
    , prev1y_stk_str_prod_wktd     COMMENT 'vorheriges Jahr Stueckleistung wöchentlich'        
    , prev1y_stk_str_prod_mtd      COMMENT 'vorheriges Jahr Stueckleistung Monat bis zum Datum'
    , prev1y_stk_str_prod_bytd     COMMENT 'vorheriges Jahr Stueckleistung Jahr bis Datum'     
) COMMENT = 'Stueckleistung (Piece Performance) for Filiale Cockpit'
AS
SELECT
    client_id                
    , loc_sid_store_move_to   
    , currency_iso_cd          
    , cy_week_partial_week_id  
    , cy_month                 
    , busyear                  
    , stk_str_prod_wday1       
    , stk_str_prod_wday2       
    , stk_str_prod_wday3       
    , stk_str_prod_wday4       
    , stk_str_prod_wday5       
    , stk_str_prod_wday6       
    , stk_str_prod_wday7       
    , stk_str_prod_wktd        
    , stk_str_prod_mtd         
    , stk_str_prod_bytd        
    , del_stk_plan_wktd            
    , del_stk_plan_mtd             
    , del_stk_plan_bytd            
    , del_stk_pep_wktd             
    , del_stk_pep_mtd              
    , del_stk_pep_bytd             
    , prev1y_stk_str_prod_wktd 
    , prev1y_stk_str_prod_mtd  
    , prev1y_stk_str_prod_bytd 
FROM P_LEW_MART_LEAD.t_agg_stk_str_productivity
;
