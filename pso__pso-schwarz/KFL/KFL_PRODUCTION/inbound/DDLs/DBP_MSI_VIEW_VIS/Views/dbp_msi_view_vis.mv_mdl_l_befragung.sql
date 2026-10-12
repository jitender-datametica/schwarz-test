CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_l_befragung
-- 30.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
AS
SELECT
v01.befragung_id
FROM dbp_view.v_mdl_l_befragung v01;