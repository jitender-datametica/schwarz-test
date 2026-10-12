/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BSI_STORES_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bsi_stores_2 (client_id, wh_id, wh_type_id, orig_store_nr, dwh_valid_from,
dwh_valid_to, store_desc, test_store_fg, mde_print_cd, mde_lang_cd, street, zip_code, city, phone_number, fax_number,
country_iso_cd, zip_code_pbx, postbox, opening_dt, real_opening_dt, closing_dt, store_valid_from, qty_min_dflt,
ord_unit_valid_store_cd, object_nr, licence_nr, last_refresh) AS SELECT client_id,
 src_wh_id AS wh_id,
 wh_type_id,
 src_orig_store_nr AS orig_store_nr,
 dwh_valid_from,
 dwh_valid_to,
 store_desc,
 COALESCE(test_store_fg, 0) AS test_store_fg,
 COALESCE(mde_print_cd, 0) AS mde_print_cd,
 COALESCE(mde_lang_cd, 0) AS mde_lang_cd,
 COALESCE(street, '<<unknown>>') AS street,
 COALESCE(zip_code, '<<unknown>>') AS zip_code,
 COALESCE(city, '<<unknown>>') AS city,
 COALESCE(phone_number, '<<unknown>>') AS phone_number,
 fax_number,
 COALESCE(country_iso_cd, '<<unknown>>') AS country_iso_cd,
 zip_code AS zip_code_pbx,
 postbox,
 COALESCE(opening_dt, PARSE_DATE('%d.%m.%Y', '01.01.1900')) AS opening_dt,
 COALESCE(real_opening_dt, PARSE_DATE('%d.%m.%Y', '01.01.1900')) AS real_opening_dt,
 closing_dt,
 dat_rec_start AS store_valid_from,
 COALESCE(qty_min_dflt, '0') AS qty_min_dflt,
 ord_unit_valid_store_cd,
 object_nr,
 licence_nr,
 CURRENT_TIMESTAMP() AS last_refresh
FROM ldl_p_lew_mart_cs.v_gen_store_2 AS S;