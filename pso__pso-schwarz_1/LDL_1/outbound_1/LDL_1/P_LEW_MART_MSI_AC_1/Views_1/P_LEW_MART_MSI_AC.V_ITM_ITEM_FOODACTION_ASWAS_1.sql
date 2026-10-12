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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_item_foodaction_aswas_1 AS SELECT client_id,
 item_id,
 dat_valid
FROM ldl_p_lew_mart_msi.t_itm_item_foodaction_aswas_1;