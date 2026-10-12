CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gp_2 AS SELECT mandant_id,
 gp_id,
 gp_name,
 gp_strasse,
 gp_plz,
 gp_ort,
 land_id AS gp_land_id,
 gp_branche_id,
 dat_von AS gp_dat_von,
 dat_bis AS gp_dat_bis,
 einkaufsorganisation_id,
 anlieferung_id,
 hgp_id,
 zek_id,
 lieferzeit,
 agb_id,
 iso_id,
 eigenverpackung_id,
 eigenmarke_id,
 audit_id,
 audit_dat,
 herst_fg,
 IFNULL(retour_sperr_fg, 0) AS retour_sperr_fg,
 IFNULL(loesch_fg, 0) AS loesch_fg
FROM kfl_production_dbp_view.v_gp_2 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND (mandant_id = 1 AND (gp_id > 999999 OR gp_id BETWEEN 9210 AND 9230 OR gp_id BETWEEN 6900 AND 6910) OR mandant_id <>
     1 AND gp_id > 999);