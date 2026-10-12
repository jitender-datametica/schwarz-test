CREATE OR REPLACE VIEW s_conl.v_item
AS
SELECT
client_id
    , item_sid
    , src_matnr
    , src_orig_item_nr
    , src_dat_valid_from
    , src_case_size
    , item_name
    , item_fam_grp_sid
    , sub_item_grp_sid_asis
    , item_grp_int_sid_asis
    , item_type_sid
    , item_grp_sid
    , pack_type_sid
    , uom_sid_base
    , uom_sid_sales
    , brand_sid
    , uom_cd_base
    , uom_cd_sales
    , gross_content_val
    , pack_cont_qty
    , config_item_cd
    , state_bges_cd
    , hazardous_material_cd
    , log_var_cd
    , pricing_ref_item_cd
    , uom_sid_packaging
    , uom_cd_packaging
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_actual_fg
    , active_fg
    , active_future_fg
    , dwh_updated
    , dwh_created
    , dwh_load_id 
FROM p_lew_bil_ac.v_item
WHERE client_id IN
 (SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_location_organization" ***/

