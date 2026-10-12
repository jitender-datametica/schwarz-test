CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_sonderabwicklung_2
--17.02.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_2
AS
SELECT
v01.mandant_id,
v01.sonderabwicklung_id
FROM dbp_view.v_l_sonderabwicklung_2 v01;