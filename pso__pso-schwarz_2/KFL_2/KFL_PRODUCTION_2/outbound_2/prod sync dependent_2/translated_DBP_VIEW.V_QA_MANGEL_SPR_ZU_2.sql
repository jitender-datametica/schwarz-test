CREATE OR REPLACE VIEW kfl_production_dbp_view.v_qa_mangel_spr_zu_2 (mandant_id, qa_mangel_id, spr_id, qa_mangel_bez) AS
SELECT mandant_id,
 qa_mangel_id,
 spr_id,
 qa_mangel_bez
FROM kfl_production_dbp_data.qa_mangel_spr_zu_2;