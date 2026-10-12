CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_gp_2 (gp_id, mandant_id, dat_von, agb_id, dat_bis,
iso_id, eigenverpackung_id, eigenmarke, audit, audit_dat, anlieferung, gp_name, strasse, plz, ort, land_id, hgp_id,
zek_id, lieferzeit, zahlungsziel_id, ampel_flg, einkaufsorganisation_id, min_pal_faktor_lkw, gln_bbnr, gln_bsnr,
gln_bubkz) AS SELECT gp_id,
 mandant_id,
 dat_von,
 agb_id,
 dat_bis,
 iso_id,
 eigenverpackung_id,
 eigenmarke_id AS eigenmarke,
 audit_id AS audit,
 audit_dat,
 anlieferung_id AS anlieferung,
 gp_name,
 gp_strasse AS strasse,
 gp_plz AS plz,
 gp_ort AS ort,
 land_id,
  CASE
  WHEN COALESCE(hgp_id, -1) = -1
  THEN gp_id
  ELSE hgp_id
  END AS hgp_id,
 zek_id,
 lieferzeit,
 zahlungsziel_id,
 1 AS ampel_flg,
 einkaufsorganisation_id,
 min_pal_faktor_lkw,
 gln_bbnr,
 gln_bsnr,
 gln_bubkz
FROM kfl_production_dbp_view.v_gp_2;