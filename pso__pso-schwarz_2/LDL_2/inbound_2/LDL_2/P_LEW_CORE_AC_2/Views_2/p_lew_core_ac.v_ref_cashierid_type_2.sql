/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_core_ac.v_ref_cashierid_type_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.06.2022    Ross, Ulrich               INIT
#                                                User Story 316900
#                                                 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_cashierid_type_2
(
    client_id
    , cashier_id
    , cashier_type
    , create_date
    , update_date
)
AS
SELECT
client_id
, cashier_id
, cashier_type
, create_date
, update_date
FROM p_lew_core.t_ref_cashierid_type_2
;