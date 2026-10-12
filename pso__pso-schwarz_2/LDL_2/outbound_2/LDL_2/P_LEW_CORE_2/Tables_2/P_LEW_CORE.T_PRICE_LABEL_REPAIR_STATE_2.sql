CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label_repair_state_2 (
price_label_client_id BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key CLIENT. Indicates from which country_2 price label was sent to repair'),
price_label_repair_batch_nr STRING(100) NOT NULL
OPTIONS(description='An identifier for the repair batch, grouping labels in the repair.'),
price_label_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PRICE LABEL.'),
repair_start_dt DATE NOT NULL OPTIONS(description='Start date of the label repair.'),
repair_end_dt DATE OPTIONS(description='End date of the label repair.'),
price_label_producer_name STRING(100) OPTIONS(description='The name of the company that manufactures price labels.'),
price_label_warranty_status_cd STRING(100) OPTIONS(description='The code for the status_2 of electronic price shields.'),
price_label_repair_result_cd STRING(100) OPTIONS(description='The code for the possible result of the label repair.'),
price_label_repair_origin_name STRING(100)
OPTIONS(description='Declaration if the price label damage is customer fault or producer fault.'),
defect_txt STRING(1000) OPTIONS(description='Description of issue that das detected (Dispay Defect, Damage, etc.).'),
repair_process_name STRING(100)
OPTIONS(description='Process that was started after the initial diagnostic (Scrap, Repair, etc.).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (price_label_repair_batch_nr, price_label_sid, repair_start_dt) NOT ENFORCED
) OPTIONS(description='Repair result for the damaged price label.             Source: Solum, Imagotag (ESL)');