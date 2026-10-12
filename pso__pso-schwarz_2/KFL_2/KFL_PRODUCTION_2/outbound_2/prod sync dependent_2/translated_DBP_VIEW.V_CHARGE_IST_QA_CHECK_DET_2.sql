CREATE OR REPLACE VIEW kfl_production_dbp_view.v_charge_ist_qa_check_det_2 (mandant_id, seq_nr, charge_nr_qa, qa_mangel_id
, qa_deklarationsfehler_id, kommentar_qa_txt, kommentar_ek_txt) AS SELECT mandant_id,
 seq_nr,
 charge_nr_qa,
 qa_mangel_id,
 qa_deklarationsfehler_id,
 kommentar_qa_txt,
 kommentar_ek_txt
FROM kfl_production_dbp_data.charge_ist_qa_check_det_2;