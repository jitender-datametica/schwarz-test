CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagertyp_2
 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- 2023-10-12, AP0178083, nwag, filter out records with wup_id -1
--2024-10-25, AP0244269, nwag, Map 5 to 1
--2024-10-30, dknop, changing lagersortiment_id to vchar
AS
SELECT
v01.lagernummer_id,
v01.lagertyp_id,
v01.lagertyp_typ_id,
v01.lagerzone_id,
CASE WHEN v01.lagersortiment_id = '5' THEN '1' ELSE v01.lagersortiment_id END AS lagersortiment_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.griffzone_typ_id
FROM dbp_view.v_l_lagertyp_2 v01
WHERE LENGTH(TRIM(v01.lagertyp_id))=4 
AND v01.wup_id > 0;
