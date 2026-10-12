/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_ejr_org_checker
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_ORG_CHECKER
(	
client_id	
, store_id	
, orig_store_nr	
, checker_id	
, void_fg	
, deposit_fg	
, return_fg	
, aborted_suspended_fg	
, discount_fg
, other_fg	
, link_param	
)	
AS	
   SELECT	
   client_id,	
   st_loc_sid AS store_id,	
   orig_store_nr,	
   checker_id,	
   void_fg,	
   deposit_fg,	
   return_fg,	
   aborted_suspended_fg,	
   discount_fg,
   other_fg,	
   link_param	
  FROM p_lew_mart_msi.t_msi_ejr_org_checker;