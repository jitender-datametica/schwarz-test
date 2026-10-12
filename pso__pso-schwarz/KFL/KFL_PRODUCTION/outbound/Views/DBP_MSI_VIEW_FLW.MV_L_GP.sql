CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_gp (gp_id, mandant_id, dat_von, agb_id, dat_bis, iso_id,
eigenverpackung_id, eigenmarke, audit, audit_dat, anlieferung, gp_name, strasse, plz, ort, land_id, region_id,
sap_region_id, hgp_id, zek_id, lieferzeit, zahlungsziel, ampel_flg, gln_bbnr, gln_bsnr, gln_bubkz, iln_id) AS SELECT G.gp_id
 ,
 G.mandant_id,
 G.dat_von,
 G.agb_id,
 G.dat_bis,
 G.iso_id,
 G.eigenverpackung_id,
 G.eigenmarke_id AS eigenmarke,
 G.audit_id AS audit,
 G.audit_dat,
 G.anlieferung_id AS anlieferung,
 G.gp_name,
 G.gp_strasse AS strasse,
 G.gp_plz AS plz,
 G.gp_ort AS ort,
 G.land_id,
 G.region_id,
 R.sap_region_id,
 G.hgp_id,
 G.zek_id,
 G.lieferzeit,
 G.zahlungsziel_id AS zahlungsziel,
 1 AS ampel_flg,
 G.gln_bbnr,
 G.gln_bsnr,
 G.gln_bubkz,
 NULL AS iln_id
FROM kfl_production_dbp_view.v_gp AS G
 INNER JOIN kfl_production_dbp_view.v_region AS R ON G.mandant_id = R.mandant_id AND G.land_id = R.land_id AND G.region_id
    = R.region_id
WHERE G.mandant_id IN (1, 2);