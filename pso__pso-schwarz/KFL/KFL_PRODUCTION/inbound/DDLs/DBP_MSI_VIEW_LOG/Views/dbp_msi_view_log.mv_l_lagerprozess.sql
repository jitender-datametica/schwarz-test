CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagerprozess
-- 07.10.2020, AP0064865, SPEC0085770, baranowska, create view

AS
SELECT
v01.mandant_id,
v01.lagernummer_id,
v01.lagerprozess_id,
v01.richtung_id
FROM dbp_view.v_l_lagerprozess v01;