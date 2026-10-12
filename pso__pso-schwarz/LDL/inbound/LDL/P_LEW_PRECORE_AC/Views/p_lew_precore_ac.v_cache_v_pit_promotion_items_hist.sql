CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promotion_items_hist
(
    client_id
    , pvpit_srcinst_id
    , pvpit_srcinst_code
    , pvpit_id
    , pvpit_cntry_id
    , pvpit_cntry_code
    , pvpit_item_no
    , pvpit_promdom_short_descr
    , pvpit_promsdm_short_descr
    , pvpit_stktyp_code
    , pvpit_pitm_valid_from
    , pvpit_pitm_valid_from_old
    , pvpit_pitmstatus_value
    , pvpit_pro_plan_factor
    , pvpit_amount_ausmusterung
    , pvpit_ausmusterung_no
    , pvpit_charge_no
    , pvpit_thcatn_name
    , pvpit_count_of_parts
    , pvpit_display_no
    , pvpit_display_dummy
    , pvpit_display_pvpit_id
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT
 client_id
,pvpit_srcinst_id
,pvpit_srcinst_code
,pvpit_id
,pvpit_cntry_id
,pvpit_cntry_code
,pvpit_item_no
,pvpit_promdom_short_descr
,pvpit_promsdm_short_descr
,pvpit_stktyp_code
,pvpit_pitm_valid_from
,pvpit_pitm_valid_from_old
,pvpit_pitmstatus_value
,pvpit_pro_plan_factor
,pvpit_amount_ausmusterung
,pvpit_ausmusterung_no
,pvpit_charge_no
,pvpit_thcatn_name
,pvpit_count_of_parts
,pvpit_display_no
,pvpit_display_dummy
,pvpit_display_pvpit_id
,deleted_fg
,dwh_valid_from
,dwh_valid_to
,dwh_load_id
,dwh_created
,dwh_updated
FROM p_lew_precore.t_cache_v_pit_promotion_items_hist ;



