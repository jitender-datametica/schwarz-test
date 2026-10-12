CREATE OR REPLACE VIEW dbp_msi_view_log.mv_belegreferenz_2
AS
SELECT
v01.mandant_id,
v01.beleg_guid,
v01.beleg_pos_guid,
v01.referenz_belegtyp_id,
v01.referenzbeleg_guid,
v01.referenzbeleg_pos_guid,
v01.referenzbeleg_id,
v01.belegtyp_id,
v01.referenz_bs_id,
v01.partner_guid,
v01.referenzbeleg_pos_id,
v01.zeitzone,
v01.datzeit_termin_beginn,
v01.datzeit_termin_ende
FROM dbp_view.v_belegreferenz_2 v01;
