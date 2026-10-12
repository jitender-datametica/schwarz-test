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
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BSI_STORES_2
(
client_id
,wh_id
,wh_type_id
,orig_store_nr
,dwh_valid_from
,dwh_valid_to
,store_desc
,test_store_fg
,mde_print_cd
,mde_lang_cd
,street
,zip_code
,city
,phone_number
,fax_number
,country_iso_cd
,zip_code_pbx
,postbox
,opening_dt
,real_opening_dt
,closing_dt
,store_valid_from
,qty_min_dflt
,ord_unit_valid_store_cd
,object_nr
,licence_nr
,last_refresh
)
AS
  SELECT
  s.client_id
  ,s.src_wh_id
  ,s.wh_type_id
  ,s.src_orig_store_nr
  ,s.dwh_valid_from
  ,s.dwh_valid_to
  ,s.store_desc
  ,COALESCE(s.test_store_fg,0)                                                   AS test_store_fg
  ,COALESCE(s.mde_print_cd,0)                                                    AS mde_print_cd
  ,COALESCE(s.mde_lang_cd,0)                                                     AS mde_lang_cd
  ,COALESCE(s.street, '<<unknown>>')                                             AS street
  ,COALESCE(s.zip_code, '<<unknown>>')                                           AS zip_code
  ,COALESCE(s.city, '<<unknown>>')                                               AS city
  ,COALESCE(s.phone_number,'<<unknown>>')                                        AS phone_number
  ,s.fax_number
  ,COALESCE(s.country_iso_cd,'<<unknown>>')                                      AS country_iso_cd
  ,s.zip_code                                                                    AS zip_code_pbx
  ,s.postbox
  ,COALESCE(s.opening_dt, TO_DATE('01.01.1900', 'dd.mm.yyyy'))        AS opening_dt
  ,COALESCE(s.real_opening_dt, TO_DATE('01.01.1900', 'dd.mm.yyyy'))   AS real_opening_dt
  ,s.closing_dt
  ,s.dat_rec_start
  ,COALESCE(s.qty_min_dflt,'0')                                                    AS qty_min_dflt
  ,s.ord_unit_valid_store_cd
  ,s.object_nr
  ,s.licence_nr
  ,CURRENT_TIMESTAMP                                                             AS last_refresh
  FROM p_lew_mart_cs.v_gen_store_2 s
;