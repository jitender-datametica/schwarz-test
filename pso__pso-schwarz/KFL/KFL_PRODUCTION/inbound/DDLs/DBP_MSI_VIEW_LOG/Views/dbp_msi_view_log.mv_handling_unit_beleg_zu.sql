CREATE OR REPLACE VIEW dbp_msi_view_log.mv_handling_unit_beleg_zu
AS
SELECT
v01.mandant_id,
v01.quelle,
v01.log_guid,
v01.handling_unit_guid,
v01.beleg_guid,
v01.belegtyp_id
FROM dbp_view.v_handling_unit_beleg_zu v01;
