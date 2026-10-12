/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BSI_STORES_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 14739 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bsi_stores_1 (client_id, wh_id, wh_type_id, orig_store_nr, dwh_valid_from,
dwh_valid_to, store_desc, test_store_fg, mde_print_cd, mde_lang_cd, street, zip_code, city, phone_number, fax_number,
country_pol_cd, zip_code_pbx, postbox, opening_dt, real_opening_dt, closing_dt, store_valid_from, qty_min_dflt,
ord_unit_valid_store_cd, object_nr, licence_nr, last_refresh) AS SELECT client_id,
 wh_id,
 wh_type_id,
 orig_store_nr,
 dwh_valid_from,
 dwh_valid_to,
 store_desc,
 test_store_fg,
 mde_print_cd,
 mde_lang_cd,
 street,
 zip_code,
 city,
 phone_number,
 fax_number,
 country_iso_cd AS country_pol_cd,
 zip_code_pbx,
 postbox,
 opening_dt,
 real_opening_dt,
 closing_dt,
 store_valid_from,
 qty_min_dflt,
 ord_unit_valid_store_cd,
 object_nr,
 licence_nr,
 last_refresh
FROM ldl_p_lew_mart_cs.v_bsi_stores_1;