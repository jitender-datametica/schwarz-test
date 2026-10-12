CREATE OR REPLACE VIEW dbp_msi_view_log.mv_auftrag_grund ( mandant_id,  auftrag_grund_id )
AS
SELECT
mandant_id,
auftrag_grund_id
FROM dbp_view.v_l_auftrag_grund;
