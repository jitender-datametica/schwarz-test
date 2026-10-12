/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_KLEINBELEGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2020    Ulrich Ross            Init KZP
#  1.1  11.03.2021    Ulrich Ross            Add aggregation for quantities and alter GROUP BY to remove multiple rows for items with differnt cas_size
#  1.2  26.03.2021    Christian Wachauf      Migration to Snowflake.
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_kzp_filialbestand_1 (client_id, country_iso_cd, orig_item_nr,
src_orig_store_nr, calc_qty, inv_qty, diff_qty_inv_calc, valid_from, valid_to, load_id, dwh_created, timestamp_delta) AS
SELECT *
FROM ldl_p_lew_mart_cs.v_kzp_filialbestand_1;


