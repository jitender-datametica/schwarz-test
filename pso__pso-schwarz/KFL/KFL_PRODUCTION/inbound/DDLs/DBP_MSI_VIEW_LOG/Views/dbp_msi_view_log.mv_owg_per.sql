CREATE OR REPLACE VIEW dbp_msi_view_log.mv_owg_per
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage

AS
SELECT
v01.owg_id,
v01.arthiertyp_id,
v01.hwg_id
FROM dbp_view.v_owg_per v01
WHERE arthiertyp_id = 2
AND dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
GROUP BY v01.owg_id
        ,v01.arthiertyp_id
        ,v01.hwg_id;