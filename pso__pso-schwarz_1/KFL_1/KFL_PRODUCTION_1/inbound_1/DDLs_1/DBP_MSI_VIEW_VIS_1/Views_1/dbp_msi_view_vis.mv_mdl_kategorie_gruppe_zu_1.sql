CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_kategorie_gruppe_zu_1
-- 27.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
AS
SELECT
v01.kategorie_id,
v01.kategorie_gruppe_id
FROM dbp_view.v_mdl_kategorie_gruppe_zu_1 v01;