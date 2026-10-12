DECLARE SV_MIN_DT, SV_MAX_DT DATE;
DECLARE NB_DAYS_ORIG_RECEIPT INT64;

SET (SV_MIN_DT, SV_MAX_DT) = (SELECT AS STRUCT MIN(bus_dt), MAX(bus_dt) FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED`);
SET NB_DAYS_ORIG_RECEIPT = 360;

-- Create a temporary table to hold all relevant events for the analysis period.
CREATE OR REPLACE TEMP TABLE TMP_RELEVANT AS
WITH
retail_events AS (
    -- Select all receipts from the primary analysis scope
    SELECT
        re.retail_event_sid AS CASH_REGISTER_EVENT_SID,
        re.store_sid,
        re.cash_register_sid,
        re.cashier_hash,
        re.bus_dt,
        re.real_estate_sid,
        re.event_end_tmsp AS event_tmsp
    FROM
        `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
    INNER JOIN
        `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
        ON re.store_sid = sq.store_sid 
        AND re.bus_dt = sq.bus_dt
    WHERE
        sq.IS_DIRECTLY_ORDERED = 1
    UNION DISTINCT 
    -- Add original purchase receipts for returns within the analysis scope
    SELECT
        o_re.retail_event_sid AS CASH_REGISTER_EVENT_SID,
        o_re.store_sid,
        o_re.cash_register_sid,
        o_re.cashier_hash,
        o_re.bus_dt,
        o_re.real_estate_sid,
        o_re.event_end_tmsp AS event_tmsp
    FROM
        `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
    INNER JOIN
        `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` q_re
        ON q_re.store_sid = sq.store_sid 
        AND q_re.bus_dt = sq.bus_dt 
        AND q_re.RETAIL_EVENT_TYPE_CD = 'R'
    INNER JOIN
        `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP` er
        ON er.CASH_REGISTER_EVENT_SID = q_re.retail_event_sid 
        AND er.CASH_REGISTER_EVENT_REL_TYPE_CD = 'ORIGINAL'
    INNER JOIN
        `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` o_re
        ON o_re.retail_event_sid = er.REL_CASH_REGISTER_EVENT_SID
),
price_info_events AS (
    -- Select price information events from the analysis scope
    SELECT
        pie.price_info_event_sid AS CASH_REGISTER_EVENT_SID,
        pie.store_sid,
        pie.cash_register_sid,
        pie.cashier_hash,
        pie.bus_dt,
        pie.real_estate_sid,
        pie.event_tmsp
    FROM
        `${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT` pie
    INNER JOIN
        `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
        ON pie.store_sid = sq.store_sid 
        AND pie.bus_dt = sq.bus_dt
    WHERE
        sq.IS_DIRECTLY_ORDERED = 1
),
tech_events AS (
    -- Select technical events from the analysis scope
    SELECT
        tcre.tech_cash_register_event_sid AS CASH_REGISTER_EVENT_SID,
        tcre.store_sid,
        tcre.cash_register_sid,
        tcre.cashier_hash,
        tcre.bus_dt,
        tcre.real_estate_sid,
        tcre.event_tmsp
    FROM
        `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT` tcre
    INNER JOIN
        `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED` sq
        ON tcre.store_sid = sq.store_sid 
        AND tcre.bus_dt = sq.bus_dt
    WHERE
        sq.IS_DIRECTLY_ORDERED = 1
),
all_events AS (
    -- Combine all event types into a single source
    SELECT *, 'RE' AS EVENT_TYPE_CD FROM retail_events re
    UNION ALL
    SELECT *, 'PIE' AS EVENT_TYPE_CD FROM price_info_events pie
    UNION ALL
    SELECT *, 'TE' AS EVENT_TYPE_CD FROM tech_events te
)
-- Final selection and numbering of events
SELECT
    ae.CASH_REGISTER_EVENT_SID,
    ae.STORE_SID,
    ae.CASH_REGISTER_SID,
    ae.CASHIER_HASH,
    ae.BUS_DT,
    ae.EVENT_TYPE_CD,
    ae.REAL_ESTATE_SID,
    ae.EVENT_TMSP,
    ce.CASHIER_NR,
    ROW_NUMBER() OVER (PARTITION BY ae.STORE_SID, ae.BUS_DT, ce.CASHIER_NR ORDER BY EVENT_TMSP ASC) AS row_nr
FROM
    all_events ae
JOIN
    `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
    ON ce.CASHIER_HASH = ae.CASHIER_HASH;

-- Delete existing records from the target table that are part of the current processing batch
DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_PRINT`
WHERE CASH_REGISTER_EVENT_SID IN (
    SELECT CASH_REGISTER_EVENT_SID 
    FROM TMP_RELEVANT
)
;

-- Insert the processed and consolidated receipt data into the final table
INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_PRINT` (
    cash_register_event_sid, 
    cash_register_event_nr, 
    cashier_nr, 
    cash_register_event_line_seq, 
    event_auth_by_nr,
    line_auth_by_nr, 
    parent_line_seq, 
    first_line_of_event_fg, 
    cash_register_event_scenario_id, 
    retail_event_line_scenario_id,
    event_start_tmsp, 
    event_end_tmsp, 
    event_line_start_tmsp, 
    event_line_end_tmsp, 
    bus_dt, 
    store_sid, 
    store_nr,
    country_org_cd, 
    cash_register_nr, 
    prod_retail_line_type_cd, 
    prod_variant_sid, 
    local_prod_nr, 
    prod_variant_input_nr,
    prod_variant_input_nr_type_cd, 
    prod_name, 
    prod_entry_method_cd, 
    price_entry_method_cd, 
    paym_line_type_cd,
    paym_type_id, 
    fraud_detection_relevant_fg, 
    prod_return_reason_sid, 
    return_txt, 
    parent_retail_event_sid, 
    unit_price,
    prod_variant_cnt, 
    prod_variant_qty, 
    base_gross_val, 
    retail_line_gross_val, 
    retail_line_vat_val, 
    local_paym_val,
    tax_line_gross_val, 
    tax_line_val, 
    tax_pct, 
    cash_register_event_seq, 
    discount_fg, 
    orig_country_org_cd,
    orig_store_nr, 
    orig_bus_dt, 
    orig_cash_register_nr, 
    orig_cash_register_event_nr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp,
    dwh_load_id, 
    dwh_node_cd
)
WITH receipts AS 
(
    -- Process regular product lines from retail events
    SELECT
        fd.cash_register_event_sid, 
        CAST(e.cash_register_event_nr AS BIGNUMERIC) AS cash_register_event_nr, 
        l.retail_event_line_seq,
        IFNULL(l.parent_line_seq, -1) AS parent_line_seq,
        IF(l.retail_event_line_seq = MIN(l.retail_event_line_seq) OVER (PARTITION BY fd.cash_register_event_sid), TRUE, FALSE) AS first_line_of_event_fg,
        e.retail_event_scenario_id AS cash_register_event_scenario_id, 
        l.retail_event_line_scenario_id,
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        l.event_start_tmsp AS event_line_start_tmsp, 
        l.event_end_tmsp AS event_line_end_tmsp,
        l.bus_dt, 
        l.store_sid, 
        NULL AS store_nr, 
        l.country_org_cd, 
        l.cash_register_sid, 
        NULL AS cash_register_nr,
        e.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash, 
        l.auth_by_hash AS line_auth_by_hash,
        l.prod_retail_line_type_cd, 
        l.prod_variant_sid, 
        l.local_prod_nr, 
        l.prod_variant_input_nr, 
        l.prod_variant_input_nr_type_cd,
        pv.PROD_NAME, 
        l.prod_entry_method_cd, 
        l.price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id,
        l.return_txt, 
        l.unit_price, 
        l.prod_return_reason_sid, 
        l.prod_variant_cnt, 
        l.prod_variant_qty, 
        l.base_gross_val,
        l.retail_line_gross_val, 
        l.retail_line_vat_val, 
        NULL AS local_paym_val, 
        l.tax_pct, 
        NULL AS tax_line_gross_val,
        NULL AS tax_line_val, 
        fd.row_nr, 
        l.discount_fg,
IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   CONCAT(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 9, 2),
          SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 11, 2)),
   NULL) AS orig_country_org_cd,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 13, 8) AS NUMERIC),
   NULL) AS orig_store_nr,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   PARSE_DATE('%Y%m%d', SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 1, 8)),
   NULL) AS orig_bus_dt,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 21, 4) AS NUMERIC),
   NULL) AS orig_cash_register_nr,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 25) AS NUMERIC),
   NULL) AS orig_cash_register_event_nr

    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid 
    AND fd.cashier_hash = e.cashier_hash
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` l 
    ON fd.cash_register_event_sid = l.retail_event_sid 
    AND fd.bus_dt = l.bus_dt 
    AND fd.store_sid = l.store_sid 
    AND fd.cashier_hash = l.cashier_hash
    LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_SALES_VARIANT` pv 
    ON pv.sales_variant_sid = l.prod_variant_sid 
    AND pv.dwh_valid_fg = TRUE
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process voided (cancellation) lines
    SELECT
        fd.cash_register_event_sid, 
        e.cash_register_event_nr, 
        cl.retail_event_line_seq, 
        l.retail_event_line_seq AS parent_line_seq,
        FALSE AS first_line_of_event_fg, 
        e.retail_event_scenario_id AS cash_register_event_scenario_id,
        cl.retail_event_line_scenario_id, 
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        cl.EVENT_TMSP AS event_line_start_tmsp,
        cl.EVENT_TMSP AS event_line_end_tmsp, 
        cl.bus_dt, 
        cl.store_sid, 
        NULL AS store_nr, 
        cl.country_org_cd,
        l.cash_register_sid, 
        NULL AS cash_register_nr, 
        e.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash,
        cl.auth_by_hash AS line_auth_by_hash, 
        l.prod_retail_line_type_cd, 
        l.prod_variant_sid, 
        l.local_prod_nr,
        l.prod_variant_input_nr, 
        l.prod_variant_input_nr_type_cd, 
        pv.PROD_NAME, 
        l.prod_entry_method_cd,
        l.price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id,
        l.return_txt, 
        l.unit_price,
        l.prod_return_reason_sid, 
        l.prod_variant_cnt * -1 AS prod_variant_cnt, 
        l.prod_variant_qty * -1 AS prod_variant_qty,
        l.base_gross_val * -1 AS base_gross_val, 
        l.retail_line_gross_val * -1 AS retail_line_gross_val,
        l.retail_line_vat_val * -1 AS retail_line_vat_val, NULL AS local_paym_val, 
        l.tax_pct, 
        NULL AS tax_line_gross_val,
        NULL AS tax_line_val, 
        fd.row_nr, 
        l.discount_fg,
       
       IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   CONCAT(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 9, 2),
          SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 11, 2)),
   NULL) AS orig_country_org_cd,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 13, 8) AS NUMERIC),
   NULL) AS orig_store_nr,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   PARSE_DATE('%Y%m%d', SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 1, 8)),
   NULL) AS orig_bus_dt,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 21, 4) AS NUMERIC),
   NULL) AS orig_cash_register_nr,

IF(LENGTH(CAST(l.orig_sales_event_sid AS STRING)) = 34,
   SAFE_CAST(SUBSTR(CAST(l.orig_sales_event_sid AS STRING), 25) AS NUMERIC),
   NULL) AS orig_cash_register_event_nr
 
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` l 
    ON fd.cash_register_event_sid = l.retail_event_sid 
    AND fd.bus_dt = l.bus_dt 
    AND fd.store_sid = l.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CANCELLATION_LINE` cl 
    ON fd.bus_dt = cl.bus_dt 
    AND fd.cash_register_event_sid = cl.retail_event_sid 
    AND l.cancel_line_seq = cl.retail_event_line_seq 
    AND fd.store_sid = l.store_sid
    LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_SALES_VARIANT` pv 
    ON pv.sales_variant_sid = l.prod_variant_sid 
    AND pv.dwh_valid_fg = TRUE
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process payment lines
    SELECT
        fd.cash_register_event_sid, 
        e.cash_register_event_nr, 
        pl.retail_event_line_seq, 
        -1 AS parent_line_seq,
        FALSE AS first_line_of_event_fg, 
        e.retail_event_scenario_id AS cash_register_event_scenario_id,
        pl.retail_event_line_scenario_id, 
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        pl.paym_start_tmsp AS event_line_start_tmsp,
        pl.paym_end_tmsp AS event_line_end_tmsp, 
        pl.bus_dt, 
        pl.store_sid, 
        NULL AS store_nr, 
        pl.country_org_cd,
        pl.cash_register_sid, 
        NULL AS cash_register_nr, 
        e.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash,
        NULL AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd, 
        NULL AS prod_variant_sid, 
        NULL AS local_prod_nr,
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd, 
        NULL AS prod_name, 
        NULL AS prod_entry_method_cd,
        NULL AS price_entry_method_cd, 
        CAST(pl.paym_line_type_cd AS STRING) AS paym_line_type_cd, 
        CAST(pl.paym_type_id AS STRING) AS paym_type_id, 
        NULL AS return_txt, 
        NULL AS unit_price,
        NULL AS prod_return_reason_sid, 
        NULL AS prod_variant_cnt, 
        NULL AS prod_variant_qty, 
        NULL AS base_gross_val,
        NULL AS retail_line_gross_val, 
        NULL AS retail_line_vat_val, 
        pl.local_paym_val, 
        NULL AS tax_pct,
        NULL AS tax_line_gross_val, 
        NULL AS tax_line_val, 
        fd.row_nr, 
        NULL AS DISCOUNT_FG, 
        NULL AS orig_country_org_cd,
        NULL AS orig_store_nr, 
        NULL AS orig_bus_dt, 
        NULL AS orig_cash_register_nr, 
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PAYMENT_LINE` pl 
    ON fd.cash_register_event_sid = pl.retail_event_sid 
    AND fd.bus_dt = pl.bus_dt 
    AND fd.store_sid = pl.store_sid
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process subtotal lines
    SELECT
        fd.cash_register_event_sid, 
        e.cash_register_event_nr, 
        st.retail_event_line_seq, 
        -1 AS parent_line_seq,
        FALSE AS first_line_of_event_fg, 
        e.retail_event_scenario_id AS cash_register_event_scenario_id,
        CAST(850 AS NUMERIC) AS retail_event_line_scenario_id, 
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        st.event_tmsp AS event_line_start_tmsp,
        st.event_tmsp AS event_line_end_tmsp, 
        st.bus_dt, 
        st.store_sid, 
        NULL AS store_nr, 
        st.country_org_cd,
        st.cash_register_sid, 
        NULL AS cash_register_nr, 
        st.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash,
        NULL AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd, 
        NULL AS prod_variant_sid, 
        NULL AS local_prod_nr,
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd, 
        NULL AS prod_name, 
        NULL AS prod_entry_method_cd,
        NULL AS price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id, 
        NULL AS return_txt,
        NULL AS unit_price, 
        NULL AS prod_return_reason_sid, 
        NULL AS prod_variant_cnt, 
        NULL AS prod_variant_qty,
        NULL AS base_gross_val,
         NULL AS retail_line_gross_val,
         NULL AS retail_line_vat_val,
         NULL AS local_paym_val,
        NULL AS tax_pct, 
        NULL AS tax_line_gross_val, 
        NULL AS tax_line_val, 
        fd.row_nr, 
        NULL AS discount_fg,
        NULL AS orig_country_org_cd, 
        NULL AS orig_store_nr, 
        NULL AS orig_bus_dt, 
        NULL AS orig_cash_register_nr,
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_SUBTOTAL_LINE` st 
    ON fd.cash_register_event_sid = st.retail_event_sid 
    AND fd.bus_dt = st.bus_dt 
    AND fd.store_sid = st.store_sid
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process tax lines
    SELECT
        fd.cash_register_event_sid, 
        e.cash_register_event_nr, 
        tl.retail_event_line_seq, 
        -1 AS parent_line_seq,
        FALSE AS first_line_of_event_fg, 
        e.retail_event_scenario_id AS cash_register_event_scenario_id,
        CAST(855 AS NUMERIC) AS retail_event_line_scenario_id,
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        tl.event_tmsp AS event_line_start_tmsp,
        tl.event_tmsp AS event_line_end_tmsp, 
        tl.bus_dt, 
        tl.store_sid, 
        NULL AS store_nr, 
        tl.country_org_cd,
        tl.cash_register_sid, 
        NULL AS cash_register_nr, 
        tl.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash,
        NULL AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd, 
        NULL AS prod_variant_sid, 
        NULL AS local_prod_nr,
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd, 
        NULL AS prod_name, 
        NULL AS prod_entry_method_cd,
        NULL AS price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id, 
        NULL AS return_txt,
        NULL AS unit_price, 
        NULL AS prod_return_reason_sid, 
        NULL AS prod_variant_cnt, 
        NULL AS prod_variant_qty,
        NULL AS base_gross_val, 
        NULL AS retail_line_gross_val, 
        NULL AS retail_line_vat_val, 
        NULL AS local_paym_val,
        tl.TAX_PCT AS tax_pct, 
        tl.gross_val AS tax_line_gross_val, 
        tl.tax_val AS tax_line_val, 
        fd.row_nr,
        NULL AS discount_fg, 
        NULL AS orig_country_org_cd, 
        NULL AS orig_store_nr, 
        NULL AS orig_bus_dt,
        NULL AS orig_cash_register_nr, 
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_TAX_LINE` tl 
    ON fd.cash_register_event_sid = tl.retail_event_sid 
    AND fd.bus_dt = tl.bus_dt 
    AND fd.store_sid = tl.store_sid
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process discount lines
    SELECT
        fd.cash_register_event_sid, 
        e.cash_register_event_nr, 
        dl.retail_event_line_seq, 
        dl.discounted_line_seq AS parent_line_seq,
        FALSE AS first_line_of_event_fg, e.retail_event_scenario_id AS cash_register_event_scenario_id,
        dl.retail_event_line_scenario_id, 
        e.event_start_tmsp, 
        e.event_end_tmsp, 
        dl.event_tmsp AS event_line_start_tmsp,
        dl.event_tmsp AS event_line_end_tmsp, 
        dl.bus_dt, 
        dl.store_sid, 
        NULL AS store_nr, 
        dl.country_org_cd,
        dl.cash_register_sid, 
        NULL AS cash_register_nr, 
        dl.cashier_hash, 
        e.auth_by_hash AS event_auth_by_hash,
        dl.auth_by_hash AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd, 
        dl.prod_variant_sid, 
        NULL AS local_prod_nr,
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd, 
        NULL AS prod_name, 
        NULL AS prod_entry_method_cd,
        NULL AS price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id,
        NULL AS return_txt,
        NULL AS unit_price, 
        NULL AS prod_return_reason_sid, 
        dl.discounted_cnt AS prod_variant_cnt,
        dl.discounted_qty AS prod_variant_qty, 
        NULL AS base_gross_val, 
        dl.discount_val AS retail_line_gross_val,
        NULL AS retail_line_vat_val, 
        NULL AS local_paym_val, 
        NULL AS tax_pct, 
        NULL AS tax_line_gross_val,
        NULL AS tax_line_val, 
        fd.row_nr, 
        NULL AS discount_fg, 
        NULL AS orig_country_org_cd, 
        NULL AS orig_store_nr,
        NULL AS orig_bus_dt, 
        NULL AS orig_cash_register_nr, 
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` e 
    ON fd.cash_register_event_sid = e.retail_event_sid 
    AND fd.bus_dt = e.bus_dt 
    AND fd.store_sid = e.store_sid
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_DISCOUNT_LINE` dl 
    ON fd.cash_register_event_sid = dl.retail_event_sid 
    AND fd.bus_dt = dl.bus_dt 
    AND fd.store_sid = dl.store_sid
    WHERE fd.EVENT_TYPE_CD = 'RE'

    UNION ALL

    -- Process technical events
    SELECT
        fd.cash_register_event_sid, 
        tc.cash_register_event_nr, 
        1 AS retail_event_line_seq, 
        -1 AS parent_line_seq,
        TRUE AS first_line_of_event_fg, 
        -- tech_cash_register_event_type_cd AS cash_register_event_scenario_id,
        -- tech_cash_register_event_type_cd AS retail_event_line_scenario_id, 
        SAFE_CAST(tech_cash_register_event_type_cd AS BIGNUMERIC) AS cash_register_event_scenario_id,
        SAFE_CAST(tech_cash_register_event_type_cd AS BIGNUMERIC) AS retail_event_line_scenario_id,
        tc.event_tmsp AS event_start_tmsp,
        tc.event_tmsp AS event_end_tmsp, 
        tc.event_tmsp AS event_line_start_tmsp, 
        tc.event_tmsp AS event_line_end_tmsp,
        tc.bus_dt, 
        tc.store_sid, 
        NULL AS store_nr, 
        tc.country_org_cd, 
        tc.cash_register_sid, 
        NULL AS cash_register_nr,
        tc.cashier_hash, 
        NULL AS event_auth_by_hash, 
        NULL AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd,
        NULL AS prod_variant_sid, 
        NULL AS local_prod_nr, 
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd,
        NULL AS prod_name, 
        NULL AS prod_entry_method_cd, 
        NULL AS price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd,
        CAST(NULL AS STRING) AS paym_type_id,
        NULL AS return_txt, 
        NULL AS unit_price, 
        NULL AS prod_return_reason_sid,
        NULL AS prod_variant_cnt, 
        NULL AS prod_variant_qty, 
        NULL AS base_gross_val, 
        NULL AS retail_line_gross_val,
        NULL AS retail_line_vat_val, 
        NULL AS local_paym_val, 
        NULL AS tax_pct, 
        NULL AS tax_line_gross_val,
        NULL AS tax_line_val, 
        fd.row_nr, 
        NULL AS discount_fg, 
        NULL AS orig_country_org_cd, 
        NULL AS orig_store_nr,
        NULL AS orig_bus_dt, 
        NULL AS orig_cash_register_nr, 
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT` tc 
    ON fd.cash_register_event_sid = tc.tech_cash_register_event_sid 
    AND fd.bus_dt = tc.bus_dt 
    AND fd.store_sid = tc.store_sid
    WHERE fd.EVENT_TYPE_CD = 'TE'

    UNION ALL

    -- Process price info events
    SELECT
        fd.cash_register_event_sid, 
        pr.cash_register_event_nr, 
        1 AS retail_event_line_seq, 
        -1 AS parent_line_seq,
        TRUE AS first_line_of_event_fg, 
        -- 480 AS cash_register_event_scenario_id,
        CAST(480 AS BIGNUMERIC) AS cash_register_event_scenario_id, 
        CAST(480 AS NUMERIC) AS retail_event_line_scenario_id,
        pr.event_tmsp AS event_start_tmsp, 
        pr.event_tmsp AS event_end_tmsp, 
        pr.event_tmsp AS event_line_start_tmsp,
        pr.event_tmsp AS event_line_end_tmsp, 
        pr.bus_dt, 
        pr.store_sid, 
        NULL AS store_nr, 
        pr.country_org_cd,
        pr.cash_register_sid, 
        NULL AS cash_register_nr, 
        pr.cashier_hash, 
        NULL AS event_auth_by_hash,
        NULL AS line_auth_by_hash, 
        NULL AS prod_retail_line_type_cd, 
        pr.prod_variant_sid, 
        NULL AS local_prod_nr,
        NULL AS prod_variant_input_nr, 
        NULL AS prod_variant_input_nr_type_cd, 
        pv.PROD_NAME, 
        NULL AS prod_entry_method_cd,
        NULL AS price_entry_method_cd, 
        CAST(NULL AS STRING) AS paym_line_type_cd, 
        CAST(NULL AS STRING) AS paym_type_id,
        NULL AS return_txt,
        pr.PROD_PRICE AS unit_price, 
        NULL AS prod_return_reason_sid, 
        NULL AS prod_variant_cnt, 
        NULL AS prod_variant_qty,
        NULL AS base_gross_val, 
        NULL AS retail_line_gross_val, 
        NULL AS retail_line_vat_val, 
        NULL AS local_paym_val,
        NULL AS tax_pct, 
        NULL AS tax_line_gross_val, 
        NULL AS tax_line_val, 
        fd.row_nr, 
        NULL AS discount_fg,
        NULL AS orig_country_org_cd, 
        NULL AS orig_store_nr, 
        NULL AS orig_bus_dt, 
        NULL AS orig_cash_register_nr,
        NULL AS orig_cash_register_event_nr
    FROM TMP_RELEVANT fd
    INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT` pr 
    ON fd.cash_register_event_sid = pr.price_info_event_sid 
    AND fd.bus_dt = pr.bus_dt 
    AND fd.store_sid = pr.store_sid
    LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_SALES_VARIANT` pv 
    ON pv.sales_variant_sid = pr.prod_variant_sid 
    AND pv.dwh_valid_fg = TRUE
    WHERE fd.EVENT_TYPE_CD = 'PIE'
)
-- Final select to join with dimensional data and insert into the target table
SELECT
    fd.cash_register_event_sid, 
    CAST(fd.cash_register_event_nr AS STRING) AS cash_register_event_nr, 
    ch.cashier_nr, 
    fd.retail_event_line_seq,
    e_ah.cashier_nr AS event_auth_by_nr, 
    l_ah.cashier_nr AS line_auth_by_nr, 
    fd.parent_line_seq,
    fd.first_line_of_event_fg, 
    fd.cash_register_event_scenario_id, 
    fd.retail_event_line_scenario_id,
    fd.event_start_tmsp, 
    fd.event_end_tmsp, 
    fd.event_line_start_tmsp, 
    fd.event_line_end_tmsp, 
    fd.bus_dt,
    fd.store_sid, 
    o.curr_int_org_nr AS store_nr, 
    fd.country_org_cd, 
    rik.resource_item_nat_key_nr AS cash_register_nr,
    fd.prod_retail_line_type_cd, 
    fd.prod_variant_sid, 
    fd.local_prod_nr, 
    fd.prod_variant_input_nr,
    fd.prod_variant_input_nr_type_cd, 
    fd.prod_name, 
    fd.prod_entry_method_cd, 
    fd.price_entry_method_cd,
    fd.paym_line_type_cd, 
    CAST(fd.paym_type_id AS BIGNUMERIC) AS paym_type_id,
    CASE WHEN s.cash_register_event_sid IS NOT NULL THEN TRUE ELSE FALSE END AS fraud_detection_relevant_fg,
    fd.prod_return_reason_sid, 
    fd.return_txt, 
    NULL AS parent_retail_event_sid, 
    fd.unit_price,
    fd.prod_variant_cnt, 
    fd.prod_variant_qty, 
    fd.base_gross_val, 
    fd.retail_line_gross_val,
    fd.retail_line_vat_val, 
    fd.local_paym_val, 
    fd.tax_line_gross_val, 
    fd.tax_line_val, 
    fd.tax_pct,
    fd.row_nr, 
    fd.discount_fg, 
    CAST(fd.orig_country_org_cd AS STRING) AS orig_country_org_cd, 
    CAST(fd.orig_store_nr AS STRING) AS orig_store_nr, 
    CAST(fd.orig_bus_dt AS DATE) AS orig_bus_dt,
    CAST(fd.orig_cash_register_nr AS BIGNUMERIC) AS orig_cash_register_nr, 
    CAST(fd.orig_cash_register_event_nr AS BIGNUMERIC) AS orig_cash_register_event_nr,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    ${LOAD_ID} AS dwh_load_id, -- Using GENERATE_UUID() for a unique load ID
    'MANUAL' AS dwh_node_cd
FROM receipts fd
JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ch 
ON fd.cashier_hash = ch.cashier_hash
LEFT JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` e_ah 
ON fd.event_auth_by_hash = e_ah.cashier_hash
LEFT JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` l_ah 
ON fd.line_auth_by_hash = l_ah.cashier_hash
LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION` o 
ON fd.store_sid = o.int_org_sid 
AND o.dwh_valid_fg = TRUE 
AND o.int_org_type_cd = 'STORE'
LEFT JOIN `${BQ_PROJECT_ID}.META.T_RESOURCE_ITEM_KEY` rik 
ON fd.cash_register_sid = rik.resource_item_sid 
AND rik.dwh_valid_fg = TRUE 
AND rik.resource_item_key_type_cd = 'REG'
LEFT JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT` s 
ON fd.cash_register_event_sid = s.cash_register_event_sid;
