/*
    All SIDs are generated in the previous process.
   Use the allocated to access the internal organisation table to enrich
   country_org_cd and curr_cd and set product_variant_sid to -1 (no product data yet!)
*/

CREATE OR REPLACE TEMP TABLE etl.vt_${src2tgt_temp_table1}_${src_context_area}_process
AS SELECT *
FROM ldl_data_production_etl.t_${src_input_table} src
;

INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        retail_event_sid,
        retail_event_line_seq,
        event_start_tmsp,
        event_end_tmsp,
        bus_dt,
        retail_event_end_tmsp,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_nr,
        auth_by_nr,
        cust_sid,
        prod_retail_line_type_cd,
        retail_event_line_scenario_id,
        prod_variant_sid,
        prod_variant_input_nr,
        prod_variant_input_nr_type_cd,
        displayed_prod_variant_name,
        weight_based_fg,
        prod_variant_cnt,
        prod_variant_qty,
        uom_cd,
        unit_price,
        base_gross_val,
        retail_line_gross_val,
        retail_line_net_val,
        retail_line_vat_val,
        tax_class_cd,
        geo_area_sid,
        tax_pct,
        curr_cd,
        turnover_relevant_fg,
        discount_fg,
        prod_entry_method_cd,
        price_entry_method_cd,
        prod_return_reason_sid,
        return_txt,
        orig_sales_event_sid,
        parent_line_seq,
        cancel_line_seq,
        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT
        src.retail_event_sid,
        src.retail_event_line_seq,
        src.event_start_tmsp,
        src.event_end_tmsp,
        src.bus_dt,
        src.retail_event_end_tmsp,
        src.store_sid,
        src.country_org_sid,
        COALESCE(org.country_org_cd, '-1') AS country_org_cd,
        src.real_estate_sid,
        src.cash_register_sid,
        src.cash_register_type_cd,
        src.cash_register_usg_type_cd,
        src.cashier_nr,
        src.auth_by_nr,
        src.cust_sid,
        src.prod_retail_line_type_cd,
        src.retail_event_line_scenario_id,
        '-1' AS prod_variant_sid,
        src.prod_variant_input_nr,
        src.prod_variant_input_nr_type_cd,
        src.displayed_prod_variant_name,
        src.weight_based_fg,
        src.prod_variant_cnt,
        src.prod_variant_qty,
        src.uom_cd,
        src.unit_price,
        src.base_gross_val,
        src.retail_line_gross_val,
        src.retail_line_net_val,
        src.retail_line_vat_val,
        src.tax_class_cd,
        src.geo_area_sid,
        src.tax_pct,
        COALESCE(org.curr_cd, '-1') AS curr_cd,
        src.turnover_relevant_fg,
        CASE WHEN src.base_gross_val > src.retail_line_gross_val THEN TRUE ELSE FALSE END AS discount_fg,
        src.prod_entry_method_cd,
        src.price_entry_method_cd,
        src.prod_return_reason_sid,
        src.return_txt,
        src.orig_sales_event_sid,
        src.parent_line_seq,
        src.cancel_line_seq,
        'EJR' AS source_system,
        CURRENT_DATE() AS extraction_dt,
        CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_etl.vt_${src2tgt_temp_table1}_${src_context_area}_process src
LEFT JOIN ldl_data_production_${target_db}.t_internal_organization org
    ON src.country_org_sid = org.int_org_sid
   AND src.bus_dt BETWEEN org.dwh_valid_from_tmsp AND org.dwh_valid_to_tmsp
;

-- Delete those records from source using the PK
DELETE FROM ldl_data_production_etl.t_${src_input_table} src
WHERE EXISTS (
    SELECT 1
    FROM ldl_data_production_etl.vt_${src2tgt_temp_table1}_${src_context_area}_process process
    WHERE
        src.retail_event_sid = process.retail_event_sid
    AND src.retail_event_line_seq = process.retail_event_line_seq
);
