CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_art_wg_zu_per_1
AS
SELECT
art_id,
mandant_id,
arthiertyp_id,
wug_id,
case when art_id=-1 then -1 else wg_id end as wg_id,
dat_von,
dat_bis
FROM dbp_view.v_art_wg_zu_per_1
WHERE arthiertyp_id=2
AND dat_bis = '9999-12-31';