CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_GP_1 
-- 24.08.2020, AP0033327, SPEC0067448, srom0404, hinzufuegen Region_1
(
  LIFNR
, mandant_id
, mandant_kbez
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
, ampel_flg
, einkaufsorganisation_id
, region_id
)
AS SELECT
  v01.gp_id AS LIFNR
, v01.mandant_id
, v02.mandant_kbez
, v01.dat_von
, v01.agb_id
, v01.dat_bis
, v01.iso_id
, v01.eigenverpackung_id
, v01.eigenmarke_id
, v01.audit_id
, v01.audit_dat
, v01.anlieferung_id
, v01.gp_name
, v01.gp_strasse
, v01.gp_plz
, v01.gp_ort
, v01.land_id
, CASE WHEN v01.hgp_id = -1 THEN v01.gp_id ELSE v01.hgp_id END AS hgp_id
, v01.zek_id
, v01.lieferzeit
, 1
, v01.einkaufsorganisation_id
, v03.region_id
FROM DBP_VIEW.v_gp_1 v01
INNER JOIN DBP_VIEW.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id
INNER JOIN DBP_VIEW.v_region_1 v03
   ON v01.mandant_id = v03.mandant_id
  AND v01.land_id    = v03.land_id
  AND v01.region_id  = v03.region_id
  AND v01.gp_id NOT BETWEEN 10000 AND 999999;