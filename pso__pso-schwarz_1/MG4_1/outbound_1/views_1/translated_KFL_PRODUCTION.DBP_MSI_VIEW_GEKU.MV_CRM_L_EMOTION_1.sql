-- 22.07.2019 twie: SPEC0059158 Lookup CRM Emotion

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_emotion_1 (crm_emotion_id) AS SELECT crm_emotion_id
FROM kfl_production_dbp_view.v_crm_l_emotion_1;