/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_supplier_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_apt_supplier_1 (client_id, country_iso_cd, orig_supplier_nr, valid_from,
valid_until, sup_name, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_apt_supplier_1;