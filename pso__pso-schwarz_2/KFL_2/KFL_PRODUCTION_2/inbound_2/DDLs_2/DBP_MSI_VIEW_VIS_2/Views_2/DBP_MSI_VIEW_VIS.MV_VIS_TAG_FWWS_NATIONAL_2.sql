CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_NATIONAL_2 as
   -- FAKT-AGGREGAT FWWS Nationale Uebernahmequote (Bestellvorschlaege) pro Monat_2/Woche_2/Tag_2 - Mandant_2/Abt_2/WG
   -- Datenumfang:
   -- 2010KW47Q2a INITIAL nur Nationale Quote (ohne wup_id, gp_id)

   SELECT
   v01.mandant_id, v01.nb_id, v01.arthiertyp_id, v01.abt_id, v01.wg_id, v01.dat, v01.kjwo, v01.kjmo, v01.gj, v01.akt_tag, v01.anz_bestell_aenderung AS sum_bestell_aenderung, v01.anz_bestell_manuell   AS sum_bestell_manuell, v01.anz_bestell_vorschlag AS sum_bestell_vorschlag, v01.anz_bestell_vorschlag - v01.anz_bestell_aenderung AS sum_bestell_ueber, v01.anz_bestell_vorschlag + v01.anz_bestell_manuell   AS sum_bestellung

   FROM dbp_msi_v_view.v_vis_tag_fwws_gp_wg_2  v01;