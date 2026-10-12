/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_SUPPLIER
#----------------------------------------------------------------------------
# History:
#  1.0  13.06.2023    Aparna Rayanki           Initial Version
#  1.1  23.06.2023    Aparna Rayanki           Removed vat_nr and active_fg columns
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_nfpo_supplier (nfpo_sup_sid, nfpo_sup_nr, nfpo_sup_name,
nfpo_gtin_ownership_cd, nfpo_gtin_ownership_descr, nfpo_country_sid, nfpo_country_cd, nfpo_country_name, street_name,
city_name, zip, eks_sup_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_supplier AS MAIN;