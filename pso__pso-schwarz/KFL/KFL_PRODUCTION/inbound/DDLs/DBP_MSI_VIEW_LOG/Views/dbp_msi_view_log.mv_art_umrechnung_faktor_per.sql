CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_umrechnung_faktor_per -- 16.12.2020, AP0064865, SPEC0085770 srom0404, initiale Anlage

AS
SELECT
v01.mandant_id,
v01.art_id,
v01.dat_von,
v01.dat_bis,
Cast(v02_pal.umrech_zaehler AS FLOAT) / Cast(v02_pal.umrech_nenner AS FLOAT) AS umrech_faktor,
CASE
WHEN Trim(v01.ausg_menge_einh_id) = '' THEN 'ST'
ELSE v01.ausg_menge_einh_id END AS einh_kolli,
CASE
WHEN ((Cast(v03_kol.umrech_zaehler AS FLOAT) / Cast(v03_kol.umrech_nenner AS FLOAT)) IS NOT NULL ) THEN (Cast(v03_kol.umrech_zaehler AS FLOAT) / Cast(v03_kol.umrech_nenner AS FLOAT))
ELSE CAST(1 AS FLOAT) END AS faktor_kolli,
v01.paletten_faktor_einh_id AS einh_pal,
Cast(v02_pal.umrech_zaehler AS FLOAT) / Cast(v02_pal.umrech_nenner AS FLOAT) AS faktor_pal
FROM dbp_view.v_art_vorschlagswert_per v01
LEFT JOIN dbp_view.v_art_umrechnung_faktor_per v02_pal
ON v01.art_id                  = v02_pal.art_id
AND v01.mandant_id              = v02_pal.mandant_id
AND v01.paletten_faktor_einh_id = v02_pal.altnv_menge_einh_id
AND v02_pal.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')

LEFT JOIN dbp_view.v_art_umrechnung_faktor_per v03_kol
ON v01.art_id                  = v03_kol.art_id
AND v01.mandant_id              = v03_kol.mandant_id
AND v01.ausg_menge_einh_id      = v03_kol.altnv_menge_einh_id
AND v03_kol.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')

WHERE v01.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD');
