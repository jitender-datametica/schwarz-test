/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_ref_currency_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#  1.0 2020-03-05 Pawel Wieczorek         Initial version
#                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
#                                         The same view as x_lew_mart_msi_ac.v_ref_currency_2   
#
#
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_ref_currency_2
COMMENT = 'Currency Rate'
(
 curr_tot_id                   
,country_id                    
,client_id                     
,currency_iso_cd               
,currency_desc                 
,to_currency_iso_cd            
,rate_currency_exchange        
,local_currency_fg             
)
AS
SELECT
 curr_tot_id                   
,country_id                    
,client_id                     
,currency_iso_cd               
,currency_desc                 
,to_currency_iso_cd            
,rate_currency_exchange        
,local_currency_fg  
FROM P_LEW_MART_LIDL_DIGITAL.v_ref_currency_2
;


