CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_EMOTION
AS
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Emotion

   SELECT

   crm_emotion_id

   FROM dbp_view.v_crm_l_emotion;