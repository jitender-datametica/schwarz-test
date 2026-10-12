CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_model_1 (model_sid OPTIONS(description='Surrogate Key MODEL'), model_name
OPTIONS(description='name of the model'), model_descr OPTIONS(description='description of the model'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. A MODEL CONSISTS OF ONE OR MORE SEGMENTATIONS WHICH ARE DEFINED TOGETHER AND INTENDED TO RUN TOGETHER`)
AS SELECT model_sid,
 model_name,
 model_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_model_1;