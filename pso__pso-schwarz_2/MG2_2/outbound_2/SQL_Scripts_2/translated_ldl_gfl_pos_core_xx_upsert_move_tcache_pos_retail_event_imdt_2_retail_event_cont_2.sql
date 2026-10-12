CREATE OR REPLACE TEMP TABLE etl.vt_$_2{src2tgt_temp_table1}_${src_context_area}_process AS
SELECT * 
FROM ldl_data_production_etl.t_${src_input_table} src
;

-- All SIDs are generated in the previous process.
-- Use the allocated to access the internal organisation table to enrich
-- country_org_cd and curr_cd

INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        retail_event_sid,
        cash_register_event_nr,
        event_start_tmsp,
        event_end_tmsp,
        bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        cash_register_sid,
        real_estate_sid,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_nr,
        auth_by_nr,
        cust_sid,
        cust_ident_type_cd,
        retail_event_type_cd,
        retail_event_scenario_id,
        offline_fg,
        cancel_fg,
        suspend_fg,
        cont_retail_event_sid,
        training_fg,
        txn_gross_val,
        txn_net_val,
        txn_vat_val,
        curr_cd,
        turnover_relevant_fg,
        service_tm_sec_meas,
        paym_tm_sec_meas,
        scanned_lines_cnt,
        keyed_lines_cnt,
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
        src.cash_register_event_nr,
        src.event_start_tmsp,
        src.event_end_tmsp,
        src.bus_dt,
        src.store_sid,
        src.country_org_sid,
        org.country_org_cd,
        src.cash_register_sid,
        src.real_estate_sid,
        src.cash_register_type_cd,
        src.cash_register_usg_type_cd,
        CASE
          WHEN src.bus_dt < DATE_SUB(CURRENT_DATE(), INTERVAL ${retention_period_cashier_nr} WEEK)
            THEN -1
          ELSE src.checker_id
        END AS cashier_nr,
        CASE
          WHEN src.bus_dt < DATE_SUB(CURRENT_DATE(), INTERVAL ${retention_period_cashier_nr} WEEK)
            THEN -1
          ELSE src.receipt_authority_id
        END AS auth_by_nr,
        src.cust_sid,
        src.cust_ident_type_cd,
        src.retail_event_type_cd,
        src.retail_event_scenario_id,
        src.offline_fg,
        src.cancel_fg,
        src.suspend_fg,
        src.cont_retail_event_sid,
        src.training_fg,
        src.txn_gross_val,
        src.txn_net_val,
        src.txn_vat_val,
        org.curr_cd,
        src.turnover_relevant_fg,
        src.service_tm_sec_meas,
        src.paym_tm_sec_meas,
        src.scanned_lines_cnt,
        src.keyed_lines_cnt,
        'EJR' AS source_system,
        CURRENT_DATE() AS extraction_dt,
        CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_etl.vt_$_2{src2tgt_temp_table1}_${src_context_area}_process src
LEFT JOIN ldl_data_production_$_2{target_db}.t_internal_organization_2 org
  ON src.country_org_sid = org.int_org_sid
 AND src.bus_dt BETWEEN org.dwh_valid_from_tmsp AND org.dwh_valid_to_tmsp
;

-- Delete those records from source using the PK
DELETE FROM ldl_data_production_etl.t_${src_input_table} src
WHERE EXISTS (
    SELECT 1
    FROM ldl_data_production_etl.vt_$_2{src2tgt_temp_table1}_${src_context_area}_process process
    WHERE src.retail_event_sid = process.retail_event_sid
);
