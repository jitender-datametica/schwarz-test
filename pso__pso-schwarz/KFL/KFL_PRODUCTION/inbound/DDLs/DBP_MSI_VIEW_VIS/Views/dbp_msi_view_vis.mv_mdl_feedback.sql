CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_feedback
AS
SELECT
v01.feedback_id,
v01.frage_id,
v01.antwort_id,
v01.dat_feedback,
v01.dat_einkauf,
v01.zeitspanne_einkauf_id,
v01.mandant_id,
v01.gf_id,
v01.wup_id,
v01.nb_id,
v01.de_wup_load_fg
FROM dbp_view.v_mdl_feedback v01;