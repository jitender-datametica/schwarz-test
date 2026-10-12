CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_GP (
gp_id
, mandant_id
, dat_von
, agb_id
, dat_bis
, iso_id
, eigenverpackung_id
, eigenmarke
, audit
, audit_dat
, anlieferung
, gp_name
, strasse
, plz
, ort
, land_id
, hgp_id
, zek_id
, lieferzeit
, zahlungsziel_id
, ampel_flg
, einkaufsorganisation_id
, min_pal_faktor_lkw
, gln_bbnr
, gln_bsnr
, gln_bubkz
)
AS
   SELECT
   gp_id, mandant_id, dat_von, agb_id, dat_bis, iso_id, eigenverpackung_id, eigenmarke_id, audit_id, audit_dat, anlieferung_id, gp_name, gp_strasse, gp_plz, gp_ort, land_id, CASE WHEN COALESCE(hgp_id , -1) = -1 THEN gp_id ELSE  hgp_id END AS hgp_id, zek_id, lieferzeit, zahlungsziel_id, 1, einkaufsorganisation_id, min_pal_faktor_lkw, gln_bbnr, gln_bsnr, gln_bubkz

   FROM dbp_view.v_gp;