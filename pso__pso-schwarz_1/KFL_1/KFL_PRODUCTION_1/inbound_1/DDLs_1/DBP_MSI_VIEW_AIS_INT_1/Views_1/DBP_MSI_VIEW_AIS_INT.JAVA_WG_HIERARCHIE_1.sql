CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_WG_HIERARCHIE_1
(
MANDANT_ID,
OWG_ID,
WG_ID,
WUG_ID
)
AS
SELECT
owg.mandant_id,
owg.owg_id,
wg.wg_id,
wug.wug_id
FROM dbp_view.v_owg_per_1 owg

JOIN dbp_view.v_wg_per_1 wg
ON owg.mandant_id = wg.mandant_id
AND owg.owg_id = wg.owg_id
AND owg.dat_bis = wg.dat_bis
AND owg.arthiertyp_id = wg.arthiertyp_id

JOIN dbp_view.v_wug_1 wug_1
ON wg.mandant_id = wug.mandant_id
AND wg.wg_id = wug.wg_id
AND wg.arthiertyp_id = wug.arthiertyp_id

JOIN dbp_view.v_wg_filter_zu_1 wgf
ON wg.mandant_id = wgf.mandant_id
AND wg.wg_id = wgf.wg_id
AND wg_filter_id = 11

WHERE owg.arthiertyp_id = 2
AND owg.dat_bis = '9999-12-31';