/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.t_item_prpty_lst_lkup_2
#----------------------------------------------------------------------------
# History:
#  1.0  03.12.2019    Michal Malinowski        Initial Version
#                                              Patch: 20191128_2313_Artmerkmale_for_Art_Monitor
#                                              IDMO: IDMO-2511
#  1.1  28.07.2022    Torsten Bachmann         Increase STRING columns to 1000 for large strings
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_item_prpty_lst_lkup_2 (
client_id BIGNUMERIC(38,0),
item_prpty_lst_id BIGNUMERIC(38,0),
item_prpty_id_concat STRING(1000) COLLATE 'und:ci',
item_prpty_lst_name STRING(1000) COLLATE 'und:ci',
item_prpty_lst_local_name STRING(1000) COLLATE 'und:ci'
);