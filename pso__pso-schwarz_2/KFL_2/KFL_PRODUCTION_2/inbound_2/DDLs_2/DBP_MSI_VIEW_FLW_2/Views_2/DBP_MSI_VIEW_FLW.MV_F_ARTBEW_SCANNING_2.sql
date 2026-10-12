CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ARTBEW_SCANNING_2
-- 20170202: TTEZ1905; SPEC0018113 Initialanlage fuer den Bericht Analyse Scanningquote

(
in_kunde_id -- Attribut KUNDE
,mandant_id
,bewart_id -- Attribut BEWEGUNGSART (RETAIL)
,gp_id -- Attribut LIEFERANT(RETAIL)
,art_id
,dat
,in_art_id -- Attribut MATERIAL
,in_art_nr
,gtin_kasse
,vorgang_scanned
,vorgang_keyed
,vorgang_scanned_einzeln
,vorgang_keyed_einzeln
,anzahl_bon
,anzahl_registriert
)
AS
   SELECT

   --v01.wup_id
   v04.flw_kunde_id AS in_kunde_id, v01.mandant_id, v01.bewart_id, v01.gp_id, v01.art_id, v01.dat, v03.in_art_id, v03.in_art_nr, v01.gtin_kasse, v01.vorgang_scanned, v01.vorgang_keyed, v01.vorgang_scanned_einzeln, v01.vorgang_keyed_einzeln, v01.anzahl_bon, v01.anzahl_registriert

   FROM dbp_view.v_artbew_scanning_2 v01
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_2 v03     -- MARA_2 + Retailartikel

   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   LEFT JOIN dbp_view.v_flw_kunde_2 v04
   ON v01.wup_id = v04.wup_id
   AND v01.mandant_id = v04.mandant_id

   WHERE v01.mandant_id in (1,2);