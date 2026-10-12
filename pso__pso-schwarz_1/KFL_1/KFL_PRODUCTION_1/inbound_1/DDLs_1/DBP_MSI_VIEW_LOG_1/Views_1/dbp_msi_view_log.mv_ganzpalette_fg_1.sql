CREATE OR REPLACE VIEW dbp_msi_view_log.mv_ganzpalette_fg_1 
-- 18.09.2020, AP0064865, SPEC0085770, baranowska, c reate view (analog LIS)

AS
SELECT
v01.mandant_id,
v01.art_id,
CASE
WHEN v01.ausg_menge_einh_id = 'PAL' THEN 1
ELSE 0 END AS ganzpalette_fg
FROM dbp_view.v_art_vorschlagswert_per_1 v01
WHERE v01.mandant_id <> 1
  AND v01.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')

UNION ALL
SELECT
v01.mandant_id,
v01.art_id,
CASE
WHEN v01.ausg_menge_einh_id = v01.paletten_faktor_einh_id AND Trim(v01.ausg_menge_einh_id) <> ' ' THEN 1
ELSE 0 END AS ganzpalette_fg
FROM dbp_view.v_art_vorschlagswert_per_1 v01
WHERE v01.mandant_id = 1
  AND v01.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD');
