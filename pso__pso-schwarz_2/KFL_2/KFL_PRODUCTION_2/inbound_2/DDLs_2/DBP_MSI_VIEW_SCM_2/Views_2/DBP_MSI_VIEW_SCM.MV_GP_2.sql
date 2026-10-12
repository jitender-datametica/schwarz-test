CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_GP_2 AS
SELECT
   gp_id,
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
      WHEN hgp_id = -1 THEN gp_id
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
   COALESCE(isd_fg,0) AS ISD_FG
FROM DBP_VIEW.v_gp_2
WHERE (einkaufsorganisation_id <> -1 AND mandant_id <> 1) 
   OR (gp_id NOT BETWEEN 10000 AND 999999 AND mandant_id = 1);