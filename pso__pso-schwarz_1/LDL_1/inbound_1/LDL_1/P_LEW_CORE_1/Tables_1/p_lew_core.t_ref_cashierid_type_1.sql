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

CREATE TABLE p_lew_core.t_ref_cashierid_type_1 (
client_id INTEGER NOT NULL,
cashier_id INTEGER NOT NULL,
cashier_type VARCHAR(5) COLLATE 'en-ci' NOT NULL,
create_date TIMESTAMP_NTZ(9) NOT NULL,
update_date TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT PK_T_BRAND PRIMARY KEY ( client_id ,cashier_id ),
UNIQUE ( client_id ,cashier_id)
)
;