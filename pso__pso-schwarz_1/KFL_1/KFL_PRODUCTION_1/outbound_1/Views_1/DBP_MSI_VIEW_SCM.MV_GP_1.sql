CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_gp_1 AS SELECT gp_id,
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
  WHEN hgp_id = - 1
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
 gln_bubkz,
 COALESCE(isd_fg, 0) AS isd_fg
FROM kfl_production_dbp_view.v_gp_1
WHERE einkaufsorganisation_id <> - 1 AND mandant_id <> 1
 OR gp_id NOT BETWEEN 10000 AND 999999 AND mandant_id = 1;