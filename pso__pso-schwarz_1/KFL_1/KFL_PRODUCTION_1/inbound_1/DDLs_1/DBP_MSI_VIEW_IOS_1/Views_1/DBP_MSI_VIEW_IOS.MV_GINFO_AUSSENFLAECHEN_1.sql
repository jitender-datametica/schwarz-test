CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GINFO_AUSSENFLAECHEN_1
AS
   SELECT
   v01.techn_platz_id, v02.grp_1_id, v02.grp_2_id, v02.grp_3_id, v02.grp_4_id, trim(v02.kaufland_typ_id) as kaufland_typ_id, v02.flaeche_attribut_id, v02.quelle_beauftragung, v01.ginfo_flaeche_brutto

   FROM dbp_view.v_ginfo_flaeche_det_per_1 v01
   INNER JOIN dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_1 v02
   ON  v01.kaufland_typ_id = v02.kaufland_typ_id
   WHERE v01.dat_bis = '9999-12-31'
   AND v02.kaufland_typ_id <> '-1'

   UNION ALL
   /* Flächen aus SITECARE_ATTRIBUT ergaenzen */
   SELECT
   v01.techn_platz_id, v02.grp_1_id, v02.grp_2_id, v02.grp_3_id, v02.grp_4_id, trim(v02.kaufland_typ_id)  as kaufland_typ_id, v02.flaeche_attribut_id, v02.quelle_beauftragung, CASE v02.quelle_beauftragung
   WHEN -1 THEN 0.
   WHEN 1 THEN v01.flaeche_cad
   WHEN 2 THEN v01.flaeche_schaetzung
   WHEN 3 THEN v01.flaeche_beauftragung
   END          AS  ginfo_flaeche_brutto
   FROM dbp_view.v_ginfo_flaeche_areaattr_per_1 v01
   INNER JOIN dbp_msi_v_view.v_ginfo_grp_aussen_flaechen_1 v02
   ON  v01.flaeche_attribut_id = v02.flaeche_attribut_id
   --   Anmerk.: quelle_beauftragung aus ginfo_grp_aussen_flaechen_1 ist nicht mit quelle_beauftragung aus
   --                  ginfo_flaeche_areaattr_per_1 gleichzusetzen, sondern dient nur als Kennzeichen, welche Spalte
   --                  angezeigt werden soll.
   WHERE v01.dat_bis = '9999-12-31'
   AND v02.flaeche_attribut_id <> -1
   AND v02.quelle_beauftragung <> -1
   ;