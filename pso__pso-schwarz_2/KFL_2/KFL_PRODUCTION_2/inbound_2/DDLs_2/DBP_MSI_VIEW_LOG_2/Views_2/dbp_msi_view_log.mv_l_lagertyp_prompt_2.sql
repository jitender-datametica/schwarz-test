CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagertyp_prompt_2 
-- 20201.01.22, AP0063967, SPEC0090556, srom0404, initial
-- 2023-10-12, AP0178083, nwag, filter out records with wup_id -1
AS
SELECT
v01.lagertyp_id
FROM dbp_view.v_l_lagertyp_2 v01
WHERE LENGTH(TRIM(v01.lagertyp_id))=4 
AND v01.wup_id > 0
GROUP BY v01.lagertyp_id;
