CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_repair_state_1 (price_label_client_id
OPTIONS(description='Surrogate Key CLIENT. Indicates from which country_1 price label was sent to repair'),
price_label_repair_batch_nr OPTIONS(description='An identifier for the repair batch, grouping labels in the repair.'),
price_label_sid OPTIONS(description='Surrogate Key PRICE LABEL.'), repair_start_dt
OPTIONS(description='Start date of the label repair.'), repair_end_dt
OPTIONS(description='End date of the label repair.'), price_label_producer_name
OPTIONS(description='The name of the company that manufactures price labels.'), price_label_warranty_status_cd
OPTIONS(description='The code for the status_1 of electronic price shields.'), price_label_repair_result_cd
OPTIONS(description='The code for the possible result of the label repair.'), price_label_repair_origin_name
OPTIONS(description='Declaration if the price label damage is customer fault or producer fault.'), defect_txt
OPTIONS(description='Description of issue that das detected (Dispay Defect, Damage, etc.).'), repair_process_name
OPTIONS(description='Process that was started after the initial diagnostic (Scrap, Repair, etc.).'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The timestamp when the row was inserted.'), dwh_updated
OPTIONS(description='The timestamp when the row was updated the last time.'))
OPTIONS(DESCRIPTION = `REPAIR RESULT FOR THE DAMAGED PRICE LABEL.SOURCE: SOLUM, IMAGOTAG (ESL)`) AS SELECT
 price_label_client_id,
 price_label_repair_batch_nr,
 price_label_sid,
 repair_start_dt,
 repair_end_dt,
 price_label_producer_name,
 price_label_warranty_status_cd,
 price_label_repair_result_cd,
 price_label_repair_origin_name,
 defect_txt,
 repair_process_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_repair_state_1;