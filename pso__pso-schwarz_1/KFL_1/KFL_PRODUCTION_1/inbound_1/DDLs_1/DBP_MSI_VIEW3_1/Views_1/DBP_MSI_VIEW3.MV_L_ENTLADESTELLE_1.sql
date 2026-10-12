CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_ENTLADESTELLE_1
(
mandant_id
,entladestelle_id
,gatename
)
AS
   SELECT
   mandant_id, entladestelle_id, gatename
   FROM dbp_view.v_l_entladestelle_1
;