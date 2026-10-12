CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_ewm_exc_kategorie_prompt_2
AS
--2021-03-18 | nwag2310 | AP0080760 | initial
SELECT
ewm_exc_kategorie_id
FROM dbp_view.v_l_ewm_exception_2
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by ewm_exc_kategorie_id;