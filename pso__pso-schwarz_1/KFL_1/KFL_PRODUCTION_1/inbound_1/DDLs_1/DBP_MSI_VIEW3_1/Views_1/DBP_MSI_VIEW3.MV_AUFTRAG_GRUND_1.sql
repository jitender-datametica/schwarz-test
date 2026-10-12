CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_AUFTRAG_GRUND_1
(mandant_id, auftrag_grund_id)
AS
   SELECT mandant_id, auftrag_grund_id
   FROM dbp_view.v_l_auftrag_grund_1;