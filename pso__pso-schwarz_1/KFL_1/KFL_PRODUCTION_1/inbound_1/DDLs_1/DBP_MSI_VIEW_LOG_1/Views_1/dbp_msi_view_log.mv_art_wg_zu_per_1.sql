CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_wg_zu_per_1 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 art_id
,mandant_id
,arthiertyp_id
,wug_id
,wg_id
,dat_von
,dat_bis
)
AS
SELECT
v01.art_id,
v01.mandant_id,
v01.arthiertyp_id,
v01.wug_id,
v01.wg_id,
v01.dat_von,
v01.dat_bis
FROM dbp_view.v_art_wg_zu_per_1 v01
WHERE arthiertyp_id = 2
AND v01.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD');
