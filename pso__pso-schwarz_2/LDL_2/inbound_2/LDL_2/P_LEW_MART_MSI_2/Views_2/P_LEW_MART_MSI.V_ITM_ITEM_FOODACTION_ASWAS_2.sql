/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_itm_item_foodatcion_aswas.
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  02.08.2021    Bachmann, Torsten        Materialize view
#                                              REP3-9070, PatchNo 2899
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_FOODACTION_ASWAS_2 AS
 /* 
 #DescStart# 
 #$Revision: 17198 $, $LastChangedBy: tbachmann $ 
 #SubjectAreas#: Artikelstamm 
 #DescEnd# 
 */ 
   SELECT	
       client_id                         /* Land_2 */ 
     , item_id                           /* Artikel_2 */ 
     , dat_valid                         /* Gueltigkeitsdatum */ 
   FROM P_LEW_MART_MSI.t_itm_item_foodaction_aswas_2
;
