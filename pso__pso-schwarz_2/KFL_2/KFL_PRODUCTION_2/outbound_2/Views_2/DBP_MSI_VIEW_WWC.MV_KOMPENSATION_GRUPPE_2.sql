CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_kompensation_gruppe_2 (mandant_id, zcgnr, zcgname,
komp_kriterium_bez, zapprove, anz_art_komp_gruppe) AS SELECT mandant_id,
 komp_gruppe_id AS zcgnr,
 komp_gruppe_bez AS zcgname,
 komp_kriterium_bez,
 freigabe_fg AS zapprove,
 anz_art_komp_gruppe
FROM kfl_production_dbp_view.v_kompensation_gruppe_2;