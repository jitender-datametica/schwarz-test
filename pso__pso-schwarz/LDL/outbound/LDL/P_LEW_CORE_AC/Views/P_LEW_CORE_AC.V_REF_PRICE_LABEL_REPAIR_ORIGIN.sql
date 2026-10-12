CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_label_repair_origin (price_label_repair_origin_name
OPTIONS(description='Declaration if the price label damage is customer fault or producer fault.'),
price_label_producer_name OPTIONS(description='The name of the company that manufactures price labels.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The timestamp when the row was inserted.'), dwh_updated
OPTIONS(description='The timestamp when the row was updated the last time.'))
OPTIONS(DESCRIPTION = `THIS REFERENCE TABLE CONTAINS DATA ABOUT WHO WAS DECLARED AS RESPONSABLE FOR THE PRICE LABEL DAMAGE.SOURCES: MANUALLY FILLED (ESL)`)
AS SELECT price_label_repair_origin_name,
 price_label_producer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_repair_origin;