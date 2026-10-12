-- LDL_AUTODISPO_DEVELOPMENT.FE_MSTR_AUTODISPO.V_ORACLE_FK_STORE_STOCK source


CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_store_stock AS SELECT fss_store_nr AS store,
 country,
 fss_item_nr AS item_nr,
 fss_quantity AS quantity,
 DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(fss_time_id - 365.25 * 4712 - 2 AS INTEGER) DAY) AS stocktime,
 mod_date
FROM ldl_autodispo_core.t_oracle_v_fk_store_stock;