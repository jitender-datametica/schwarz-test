/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_item_asis
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  07.01.2022    Ao, Lin                      Adding new column item_familygroup_id_lago
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_gen_item_asis
(
      client_id
    , item_sid
    , item_sid_config
    , orig_item_nr
    , orig_item_nr_int
    , item_familygroup_id
    , item_familygroup_id_lago
    , subitemgroup_id
    , int_subitemgroup_id
    , item_actiongroup_id
    , item_sub_actiongroup_id
    , case_size
    , case_size_lago
    , src_country_lidl_cd
    , valid_from
    , valid_until
    , buying_employee_skey
    , buying_employee_name
    , brand_name
    , itemstatus_cd
    , packagetype_desc
    , case_euro
    , case_plu_fg
    , plu_nr
    , buying_list_type_id
    , unitsize
    , vat_id
    , smallest_unit
    , weight_fg
    , dangerous_goods_fg
    , dwh_updated
    , dwh_created
    , dwh_load_id
    )
AS
SELECT
      client_id
    , item_sid
    , item_sid_config
    , orig_item_nr
    , orig_item_nr_int
    , item_familygroup_id
    , item_familygroup_id_lago
    , subitemgroup_id
    , int_subitemgroup_id
    , item_actiongroup_id
    , item_sub_actiongroup_id
    , case_size
    , case_size_lago    
    , src_country_lidl_cd
    , valid_from
    , valid_until
    , buying_employee_skey
    , buying_employee_name
    , brand_name
    , itemstatus_cd
    , packagetype_desc
    , case_euro
    , case_plu_fg
    , plu_nr
    , buying_list_type_id
    , unitsize
    , vat_id
    , smallest_unit
    , weight_fg
    , dangerous_goods_fg
    , dwh_updated
    , dwh_created
    , dwh_load_id
FROM p_lew_mart_cs.t_gen_item_asis
;

