CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_label_repair_result (price_label_repair_result_cd
OPTIONS(description='THE CODE FOR THE POSSIBLE RESULT OF THE LABEL REPAIR.'), price_label_producer_name
OPTIONS(description='THE NAME OF THE COMPANY THAT MANUFACTURES PRICE LABELS.'), price_label_repair_result_descr
OPTIONS(description='THE DESCRIPTION FOR THE POSSIBLE RESULT OF THE LABEL REPAIR.'), dwh_load_id
OPTIONS(description='THE IDENTIFIER OF THE LAST LOAD RUN WHICH INSERTED OR UPDATED THIS ROW.'), dwh_created
OPTIONS(description='THE TIMESTAMP WHEN THE ROW WAS INSERTED.'), dwh_updated
OPTIONS(description='THE TIMESTAMP WHEN THE ROW WAS UPDATED THE LAST TIME.'))
OPTIONS(DESCRIPTION = `THE LIST OF POSSIBLE REPAIR OUTCOMES (RECYCLING, CREDIT NOTE, RETURNED FUNCTIONAL). SOURCE: MANUALL FILLED (ESL)`)
AS SELECT price_label_repair_result_cd,
 price_label_producer_name,
 price_label_repair_result_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_repair_result;