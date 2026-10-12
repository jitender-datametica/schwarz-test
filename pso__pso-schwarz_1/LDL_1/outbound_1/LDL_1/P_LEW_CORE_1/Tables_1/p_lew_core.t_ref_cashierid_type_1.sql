/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_core.t_ref_cashierid_type_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.06.2022    Ross, Ulrich               INIT
#                                                User Story 316900
#                                                 
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_cashierid_type_1 (
client_id INTEGER NOT NULL,
cashier_id INTEGER NOT NULL,
cashier_type STRING(5) COLLATE 'und:ci' NOT NULL,
create_date DATETIME NOT NULL,
update_date DATETIME NOT NULL,
PRIMARY KEY (client_id, cashier_id) NOT ENFORCED
);