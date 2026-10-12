CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_l_kategorie_1
-- 01.12.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
AS
SELECT
v01.kategorie_id
FROM dbp_view.v_mdl_l_kategorie_1 v01;