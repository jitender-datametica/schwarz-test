CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_GP
-- 24.10.2013 twie: neue Lookup von AIS_DE uebernommen, fuer DE und CZ
(
gp_id
,mandant_id
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
,land_id
, region_id
, sap_region_id
, hgp_id
, zek_id
, lieferzeit
, zahlungsziel
, ampel_flg
, gln_bbnr
, gln_bsnr
, gln_bubkz
, iln_id
)
AS
   SELECT
   g.gp_id, g.mandant_id, dat_von, agb_id, dat_bis, iso_id, eigenverpackung_id, eigenmarke_id, audit_id, audit_dat, anlieferung_id, gp_name, gp_strasse, gp_plz, gp_ort, g.land_id, g.region_id, sap_region_id, hgp_id, zek_id, lieferzeit, zahlungsziel_id, 1, gln_bbnr, gln_bsnr, gln_bubkz, null AS iln_id
   FROM dbp_view.v_gp g, dbp_view.v_region r

   WHERE g.mandant_id in (1,2)
   AND g.mandant_id = r.mandant_id
   AND g.land_id = r.land_id
   AND g.region_id = r.region_id;