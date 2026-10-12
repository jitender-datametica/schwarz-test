CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gp_2 (mandant_id, gp_id, einkaufsorganisation_id, dat_von,
dat_bis, anlieferung_id, gp_name, gp_name_sort, gp_strasse, gp_plz, gp_ort, land_id, hgp_id, zek_id, lieferzeit,
zahlungsziel, agb_id, iso_id, eigenverpackung_id, eigenmarke_id, audit_id, audit_dat, herst_fg, zahlart_id,
retour_sperr_fg, gp_branche_id, loesch_fg, system_id) AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 dat_von,
 dat_bis,
 anlieferung_id,
  CASE
  WHEN loesch_fg = 1
  THEN '{' || gp_name || '}'
  ELSE gp_name
  END AS gp_name,
 gp_name AS gp_name_sort,
 gp_strasse,
 gp_plz,
 gp_ort,
 land_id,
 hgp_id,
 zek_id,
 lieferzeit,
 zahlungsziel_id AS zahlungsziel,
 agb_id,
 iso_id,
 eigenverpackung_id,
 eigenmarke_id,
 audit_id,
 audit_dat,
 herst_fg,
 zahlart_id,
 COALESCE(retour_sperr_fg, 0) AS retour_sperr_fg,
 gp_branche_id,
 COALESCE(loesch_fg, 0) AS loesch_fg,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_2 AS V01
WHERE mandant_id = 1
 AND (gp_id > 999999 OR gp_id BETWEEN 9211 AND 9220 OR gp_id = - 1);