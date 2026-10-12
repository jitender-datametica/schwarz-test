CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_frage_befragung_bereich_kategorie_zu
-- 27.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
-- 22.01.2021 snik1809 - added kategorie_gruppe_id
AS
SELECT
v01.frage_id,
v01.befragung_id,
v01.bereich_id,
v01.kategorie_id,
v02.kategorie_gruppe_id
FROM dbp_view.v_mdl_frage_befragung_bereich_kategorie_zu v01
INNER JOIN dbp_view.v_mdl_kategorie_gruppe_zu v02
on v01.kategorie_id = v02.kategorie_id;