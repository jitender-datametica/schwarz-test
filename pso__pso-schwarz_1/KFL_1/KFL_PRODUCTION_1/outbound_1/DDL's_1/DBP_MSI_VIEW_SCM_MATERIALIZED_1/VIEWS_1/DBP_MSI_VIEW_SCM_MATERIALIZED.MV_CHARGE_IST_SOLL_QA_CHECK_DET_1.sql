-- 2025-03-06,AP0205147, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_charge_ist_soll_qa_check_det_1 (charge_nr_qa,
mandant_id, wup_id, nb_id, qa_mangel_id, qa_deklarationsfehler_id, kommentar_qa_txt, kommentar_ek_txt) AS SELECT V01.charge_nr_qa
 ,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 COALESCE(V04.qa_mangel_id, '-1') AS qa_mangel_id,
 COALESCE(V04.qa_deklarationsfehler_id, '-1') AS qa_deklarationsfehler_id,
 V04.kommentar_qa_txt,
 V04.kommentar_ek_txt
FROM kfl_production_dbp_view.v_charge_ist_qa_check_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_charge_ist_qa_check_det_1 AS V04 ON V01.charge_nr_qa = V04.charge_nr_qa AND V01.mandant_id
    = V04.mandant_id;