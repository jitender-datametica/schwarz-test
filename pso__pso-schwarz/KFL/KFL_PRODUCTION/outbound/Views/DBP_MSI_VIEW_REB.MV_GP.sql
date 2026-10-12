CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_gp (gp_id, mandant_id, dat_von, agb_id, dat_bis, iso_id,
eigenverpackung_id, eigenmarke, audit, audit_dat, anlieferung, gp_name, strasse, plz, ort, land_id, region_id,
sap_region_id, hgp_id, zek_id, lieferzeit, zahlungsziel, ampel_flg, gln_bbnr, gln_bsnr, gln_bubkz, iln_id) AS SELECT V01
 .gp_id,
 V01.mandant_id,
 V01.dat_von,
 V01.agb_id,
 V01.dat_bis,
 V01.iso_id,
 V01.eigenverpackung_id,
 V01.eigenmarke_id AS eigenmarke,
 V01.audit_id AS audit,
 V01.audit_dat,
 V01.anlieferung_id AS anlieferung,
 V01.gp_name,
 V01.gp_strasse AS strasse,
 V01.gp_plz AS plz,
 V01.gp_ort AS ort,
 V01.land_id,
 V01.region_id,
 V02.sap_region_id,
 V01.hgp_id,
 V01.zek_id,
 V01.lieferzeit,
 V01.zahlungsziel_id AS zahlungsziel,
 1 AS ampel_flg,
 V01.gln_bbnr,
 V01.gln_bsnr,
 V01.gln_bubkz,
 NULL AS iln_id
FROM kfl_production_dbp_view.v_gp AS V01
 INNER JOIN kfl_production_dbp_view.v_region AS V02 ON V01.mandant_id = V02.mandant_id AND V01.land_id = V02.land_id AND
   V01.region_id = V02.region_id
WHERE V01.mandant_id = 1
 AND V01.gp_id NOT BETWEEN 10000 AND 999999;