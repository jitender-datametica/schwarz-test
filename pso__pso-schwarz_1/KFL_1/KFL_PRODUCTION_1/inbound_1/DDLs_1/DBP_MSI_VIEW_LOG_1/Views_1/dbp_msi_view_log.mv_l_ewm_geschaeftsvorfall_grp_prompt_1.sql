CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_ewm_geschaeftsvorfall_grp_prompt_1
AS
--2021-03-18 | nwag2310 | AP0080760 | initial
SELECT
ewm_gv_grp_id
FROM dbp_view.v_l_ewm_geschaeftsvorfall_1
WHERE LEFT(lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(lagernummer_id))=4
group by ewm_gv_grp_id;