CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_DISPOSITION_RHYTHMUS_1
(
disposition_rhythmus_id
,mandant_id
,nb_id
,system_id
,wup_id
)
AS
   SELECT
   disposition_rhythmus_id, mandant_id, nb_id, system_id, wup_id
   FROM dbp_view.v_l_disposition_rhythmus_1;