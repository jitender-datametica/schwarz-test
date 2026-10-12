CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_DISPOSITION_RHYTHMUS_LTF
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
(
mandant_id
,disposition_rhythmus_ltf_id
)
AS
   SELECT
   v01.mandant_id, v01.disposition_rhythmus_ltf_id
   FROM dbp_view.v_l_disposition_rhythmus_ltf v01;