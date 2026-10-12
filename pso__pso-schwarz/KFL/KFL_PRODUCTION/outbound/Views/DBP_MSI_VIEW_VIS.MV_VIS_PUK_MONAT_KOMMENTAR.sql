CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_puk_monat_kommentar (mandant_id, vs_id, gf_id, vkl_id,
wup_id, kjmo, kennzahl_id, puk_typ_id, puk_id, puk_parent_id, ursache_kjmo, massnahme_kjmo, zeit_aktualisierung) AS
SELECT WP.mandant_id,
 WP.vs_id,
 WP.gf_id,
 WP.vkl_id,
 WP.wup_id,
 MO.kjmo,
 PKK.kennzahl_id,
 PKT.puk_typ_id,
 COALESCE(puk1.puk1, puk2.puk2, puk3.puk3, puk4.puk4, puk5.puk5, CASE
   WHEN PKT.puk_typ_id = 1
   THEN WP.wup_id
   WHEN PKT.puk_typ_id = 2
   THEN WP.vkl_id
   WHEN PKT.puk_typ_id = 3
   THEN WP.gf_id
   WHEN PKT.puk_typ_id = 4
   THEN WP.vs_id
   WHEN PKT.puk_typ_id = 5
   THEN WP.mandant_id
   ELSE NULL
   END) AS puk_id,
 COALESCE(puk1.prn1, puk2.prn2, puk3.prn3, puk4.prn4, puk5.prn5, CASE
   WHEN PKT.puk_typ_id = 1
   THEN WP.vkl_id
   WHEN PKT.puk_typ_id = 2
   THEN WP.gf_id
   WHEN PKT.puk_typ_id = 3
   THEN WP.vs_id
   WHEN PKT.puk_typ_id = 4
   THEN WP.mandant_id
   WHEN PKT.puk_typ_id = 5
   THEN 0
   ELSE NULL
   END) AS puk_parent_id,
 COALESCE(puk1.urs1, puk2.urs2, puk3.urs3, puk4.urs4, puk5.urs5) AS ursache_kjmo,
 COALESCE(puk1.msn1, puk2.msn2, puk3.msn3, puk4.msn4, puk5.msn5) AS massnahme_kjmo,
 COALESCE(puk1.akt1, puk2.akt2, puk3.akt3, puk4.akt4, puk5.akt5) AS zeit_aktualisierung
FROM kfl_production_dbp_data.wup AS WP
 INNER JOIN kfl_production_dbp_data.monat AS MO ON TRUE
 INNER JOIN kfl_production_dbp_data.vis_l_puk_kennzahl AS PKK ON TRUE
 INNER JOIN kfl_production_dbp_data.vis_l_puk_typ AS PKT ON TRUE
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   kennzahl_id,
   puk_typ_id,
   puk_id AS puk1,
   puk_parent_id AS prn1,
   ursache_kjmo AS urs1,
   massnahme_kjmo AS msn1,
   zeit_aktualisierung AS akt1
  FROM kfl_production_dbp_data.vis_puk_monat_kommentar AS PUK
  WHERE puk_typ_id = 1) AS puk1 ON WP.aktuell_wup_id = puk1.puk1 AND WP.mandant_id = puk1.mandant_id AND MO.kjmo = puk1
     .kjmo AND PKK.kennzahl_id = puk1.kennzahl_id AND PKT.puk_typ_id = puk1.puk_typ_id
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   kennzahl_id,
   puk_typ_id,
   puk_id AS puk2,
   puk_parent_id AS prn2,
   ursache_kjmo AS urs2,
   massnahme_kjmo AS msn2,
   zeit_aktualisierung AS akt2
  FROM kfl_production_dbp_data.vis_puk_monat_kommentar AS PUK
  WHERE puk_typ_id = 2) AS puk2 ON WP.vkl_id = puk2.puk2 AND WP.mandant_id = puk2.mandant_id AND MO.kjmo = puk2.kjmo AND
    PKK.kennzahl_id = puk2.kennzahl_id AND PKT.puk_typ_id = puk2.puk_typ_id
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   kennzahl_id,
   puk_typ_id,
   puk_id AS puk3,
   puk_parent_id AS prn3,
   ursache_kjmo AS urs3,
   massnahme_kjmo AS msn3,
   zeit_aktualisierung AS akt3
  FROM kfl_production_dbp_data.vis_puk_monat_kommentar AS PUK
  WHERE puk_typ_id = 3) AS puk3 ON WP.gf_id = puk3.puk3 AND WP.mandant_id = puk3.mandant_id AND MO.kjmo = puk3.kjmo AND
    PKK.kennzahl_id = puk3.kennzahl_id AND PKT.puk_typ_id = puk3.puk_typ_id
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   kennzahl_id,
   puk_typ_id,
   puk_id AS puk4,
   puk_parent_id AS prn4,
   ursache_kjmo AS urs4,
   massnahme_kjmo AS msn4,
   zeit_aktualisierung AS akt4
  FROM kfl_production_dbp_data.vis_puk_monat_kommentar AS PUK
  WHERE puk_typ_id = 4) AS puk4 ON WP.vs_id = puk4.puk4 AND WP.mandant_id = puk4.mandant_id AND MO.kjmo = puk4.kjmo AND
    PKK.kennzahl_id = puk4.kennzahl_id AND PKT.puk_typ_id = puk4.puk_typ_id
 LEFT JOIN (SELECT mandant_id,
   kjmo,
   kennzahl_id,
   puk_typ_id,
   puk_id AS puk5,
   puk_parent_id AS prn5,
   ursache_kjmo AS urs5,
   massnahme_kjmo AS msn5,
   zeit_aktualisierung AS akt5
  FROM kfl_production_dbp_data.vis_puk_monat_kommentar AS PUK
  WHERE puk_typ_id = 5) AS puk5 ON WP.mandant_id = puk5.puk5 AND WP.mandant_id = puk5.mandant_id AND MO.kjmo = puk5.kjmo
       AND PKK.kennzahl_id = puk5.kennzahl_id AND PKT.puk_typ_id = puk5.puk_typ_id AND MO.akt_mo BETWEEN - 4 AND (- 1)
WHERE WP.nb_id = 0
 AND WP.dat_von > DATE '1900-01-01'
 AND WP.dat_eroeffnung > DATE '1900-01-01';