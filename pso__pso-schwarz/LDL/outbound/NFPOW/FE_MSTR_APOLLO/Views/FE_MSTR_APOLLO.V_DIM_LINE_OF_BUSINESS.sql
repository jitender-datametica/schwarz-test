/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LINE_OF_BUSINESS
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_line_of_business (lob_cd, lob_name, dwh_created_tmsp, dwh_updated_tmsp
, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_line_of_business AS MAIN;