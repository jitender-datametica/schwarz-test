CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_kreistyp_gruppe_zu_per_1 AS SELECT V00.art_id,
 V00.mandant_id,
 COALESCE(V01.kreistyp_id, '') AS kreistyp_id,
 V01.dat_von,
 COALESCE(V01.kreistyp_gruppe_id, '') AS kreistyp_gruppe_id,
 V01.dat_bis
FROM kfl_production_dbp_view.v_art_1 AS V00
 LEFT JOIN kfl_production_dbp_view.v_art_kreistyp_gruppe_zu_per_1 AS V01 ON V00.mandant_id = V01.mandant_id AND V00.art_id
     = V01.art_id AND V01.dat_bis = DATE '9999-12-31'
WHERE V00.dat_bis = DATE '9999-12-31';