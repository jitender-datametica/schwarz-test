CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_ewm_geschaeftsvorfall_grp_2
AS
--2021-03-18 | nwag2310 | AP0080760 | initial
-- 2021-05-27, AP0070892, SPEC0112147,knopd, adding null value
SELECT
mandant_id,
lagernummer_id,
ewm_gv_grp_id
FROM dbp_view.v_l_ewm_geschaeftsvorfall_2
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by mandant_id, lagernummer_id, ewm_gv_grp_id

UNION

SELECT
mandant_id,
lagernummer_id,
'' as ewm_gv_grp_id
FROM dbp_view.v_l_ewm_geschaeftsvorfall_2
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by mandant_id, lagernummer_id, ewm_gv_grp_id
;