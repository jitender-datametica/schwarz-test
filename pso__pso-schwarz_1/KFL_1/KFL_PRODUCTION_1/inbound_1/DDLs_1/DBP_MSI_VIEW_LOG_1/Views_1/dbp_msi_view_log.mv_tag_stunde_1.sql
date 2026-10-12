CREATE OR REPLACE VIEW dbp_msi_view_log.mv_tag_stunde_1
AS
SELECT
v01.dat,
v01.stunde,
v01.stunde_minuten,
v01.dat_zeit
FROM dbp_view.v_tag_stunde_1 v01;
