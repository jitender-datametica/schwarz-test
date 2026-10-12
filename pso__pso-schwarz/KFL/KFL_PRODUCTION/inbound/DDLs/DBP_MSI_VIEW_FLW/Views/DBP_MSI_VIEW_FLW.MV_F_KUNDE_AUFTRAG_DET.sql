CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_KUNDE_AUFTRAG_DET
-- 26.10.2011 system_id entfernt
-- 30.03.2012 twie: kunde_auftrag dazugejoint und in_vw_id ausgegeben
-- 26.07.2012 twie: absagegrund_id hinzugefuegt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 06.02.2015 twie: Mandant Filterung entfernt, da flw Tabelle eh nur Mdt 1+2 beinhaltet -> Performanceverbesserung
-- 17.09.2015 twie: neue Felder; Dummywert bei absagegrund_id
-- 15.03.2016 twie: flw_art_id_kunde ersetzt durch sap_art_id_kunde
-- 12.09.2016 twie: SPEC0007947 Kunde aus flw_besch_partner ermitteln
-- 16.09.2021 twie: NSR2407053 Logik Absagegrund um Variante 'blank' erweitert

(
   mandant_id,
   verkaufs_beleg_id,
   verkaufs_beleg_pos_id,
   in_art_id,
   werk_id,
   in_vw_id,
   verk_menge_einh_id,
   menge_auftrag_vme_kum,
   menge_bes_bme_kum,
   menge_bes_bme_kum_kg,
   absagegrund_id,
   best_beleg_id_kunde,
   auftragsart_id,
   in_verkaufsorganisation_id,
   in_art_id_kunde,
   wert_ek_netto,
   zwsum_2_betrag,
   zwsum_4_betrag,
   in_kunde_id,
   mandant_id_kunde
) AS
SELECT
   v01.mandant_id,
   v01.verkaufs_beleg_id,
   v01.verkaufs_beleg_pos_id,
   v01.flw_art_id AS in_art_id,
   v01.werk_id,
   v02.flw_vw_id AS in_vw_id,
   v01.verk_menge_einh_id,
   v01.menge_auftrag_vme_kum,
   v01.menge_bes_bme_kum,
   CASE
      WHEN v05.basismenge_einh_id = 'KG' THEN v01.menge_bes_bme_kum
      WHEN v05.basismenge_einh_id = 'ST' THEN CAST(
         v01.menge_bes_bme_kum * v06.umrech_faktor AS DECIMAL(18, 6)
      )
   END AS menge_bes_bme_kum_kg,
   --Sowohl blank als auch NULL stehen für 'kein Absagegrund' mit ID -1
   CASE WHEN v01.absagegrund_id = '' THEN '-1'
   		ELSE COALESCE(v01.absagegrund_id, '-1') 
   END AS absagegrund_id,
   v02.best_beleg_id_kunde,
   v02.auftragsart_id,
   v02.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
   v01.sap_art_id_kunde AS in_art_id_kunde,
   v01.wert_ek_netto,
   v01.zwsum_2_betrag,
   (v01.zwsum_4_betrag / (1 + (v11.mwst / 100))) AS zwsum_4_betrag, --in netto umrechnen
   COALESCE(v03.flw_kunde_id, -1) AS in_kunde_id, --wenn kein Kunde ermittelbar Dummy -1
   COALESCE(v03.mandant_id, v01.mandant_id) AS mandant_id_kunde --mandant_id vom Kunde muss nicht mit der vom Verkaufsbeleg uebereinstimmen, deshalb eigener Mandant. Nur wenn kein Kunde ermittelbar ist, den Mandant vom Verkaufsbeleg nehmen
   
   FROM dbp_view.v_flw_kunde_auftrag_det v01
   INNER JOIN dbp_view.v_flw_kunde_auftrag v02 ON v01.mandant_id = v02.mandant_id
   AND v01.verkaufs_beleg_id = v02.verkaufs_beleg_id
   LEFT OUTER JOIN dbp_view.v_flw_besch_partner v03 ON v01.verkaufs_beleg_id = v03.faktura_beleg_id
   AND v03.partner_verwendung_id = 'WE'
   INNER JOIN dbp_view.v_flw_art v05 ON v01.mandant_id = v05.mandant_id
   AND v01.flw_art_id = v05.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per v06 ON v05.mandant_id = v06.mandant_id
   AND v05.flw_art_id = v06.flw_art_id
   AND (
      CASE
         WHEN v05.basismenge_einh_id = 'ST' THEN 'KG'
         WHEN v05.basismenge_einh_id = 'KG' THEN 'ST'
      END
   ) = v06.altnv_menge_einh_id
   INNER JOIN dbp_view.v_art v07 ON v05.art_id = v07.art_id
   AND v05.mandant_id = v07.mandant_id
   LEFT OUTER JOIN dbp_view.v_mwst_per v11 ON v07.mandant_id = v11.mandant_id
   AND v07.mwst_id = v11.mwst_id
   AND v02.dat_erstellung BETWEEN v11.dat_von
   AND v11.dat_bis
   ;