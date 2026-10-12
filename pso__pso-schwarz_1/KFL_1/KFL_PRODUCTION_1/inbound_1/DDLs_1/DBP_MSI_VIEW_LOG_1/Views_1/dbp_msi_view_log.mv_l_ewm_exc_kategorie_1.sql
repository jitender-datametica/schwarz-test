CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_ewm_exc_kategorie_1
AS
--2021-03-18 | nwag2310 | AP0080760 | initial
SELECT
mandant_id,
lagernummer_id,
ewm_exc_kategorie_id
FROM dbp_view.v_l_ewm_exception_1
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by mandant_id,lagernummer_id,ewm_exc_kategorie_id ;