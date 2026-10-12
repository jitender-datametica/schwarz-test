CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_MKL_WUP_2(
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      KJMO,
      DAT_AENDERUNG_MIN,
      DAT_AENDERUNG_MAX,
      DAT_WE_MIN,
      DAT_WE_MAX,
      ANZ_FEHLER,
      ANZ_KOPF_FEHLER,
      ANZ_POS_FEHLER,
      ANZ_RECH_POS
) AS
   -- FAKT Mengenkorrekturliste Zaehlung pro Filiale/Monat_2
   -- Basis: SAP Retailstore zrs_mkldata + FWWS/RPW
   -- Ersetzt: mv_mengenkorrekturliste_det_2, mv_vis_monat_fwws_wup_gp_pc_2, mv_vis_monat_fwws_wup_pc_2
   -- 20150814 Initial
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

   SELECT
      mkl.mandant_id
      , mkl.nb_id
      , mkl.wup_id
      , mkl.kjmo
      , mkl.dat_aenderung_min
      , mkl.dat_aenderung_max
      , mkl.dat_we_min
      , mkl.dat_we_max
      , mkl.anz_fehler                                         AS anz_fehler
      , mkl.anz_kopf_fehler                                    AS anz_kopf_fehler
      , mkl.anz_pos_fehler                                     AS anz_pos_fehler
      , fwws.anz_rech_pos                                      AS anz_rech_pos
   FROM
   (
      SELECT
         mkl.mandant_id
         , mkl.nb_id
         , wup.aktuell_wup_id AS wup_id
         , tt.kjmo
         , MIN(mkl.dat_aenderung)                              AS dat_aenderung_min -- erste Aenderung
         , MAX(mkl.dat_aenderung)                              AS dat_aenderung_max -- letzte Aenderung
         , MIN(mkl.dat_we)                                     AS dat_we_min -- erster WE
         , MAX(mkl.dat_we)                                     AS dat_we_max -- letzter WE
         , COUNT(*)                                            AS anz_fehler
         , SUM(kopf_fehler_fg )                                AS anz_kopf_fehler
         , SUM(pos_fehler_fg )                                 AS anz_pos_fehler
      FROM dbp_view.v_vis_mengen_korrektur_liste_2 mkl
      INNER JOIN dbp_view.v_vis_l_problemcode_2 pc
      ON mkl.mandant_id = pc.mandant_id
      AND mkl.problemcode_id = pc.problemcode_id
      INNER JOIN dbp_view.v_tag_2 tt
      ON mkl.dat_aenderung = tt.dat
      INNER JOIN dbp_view.v_wup_2 wup_2
   	ON mkl.mandant_id = wup.mandant_id AND mkl.wup_id = wup.wup_id

      WHERE mkl.anzeigen_fg = 1 -- Default

      GROUP BY 
         mkl.mandant_id
         , mkl.nb_id
         , wup.aktuell_wup_id
         , tt.kjmo
   ) mkl
   INNER JOIN
   (
      SELECT
         v01.mandant_id
         , wup.aktuell_wup_id                                  AS wup_id
         , v01.kjmo
         , SUM(anz_rech_pos)                                   AS anz_rech_pos
      FROM dbp_msi_v_view.v_vis_monat_fwws_wup_2 v01
      INNER JOIN dbp_view.v_wup_2 wup_2
   	ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

      GROUP BY 
          v01.mandant_id
         , wup.aktuell_wup_id
         , v01.kjmo
   ) fwws
   ON mkl.mandant_id = fwws.mandant_id
   AND mkl.wup_id = fwws.wup_id
   AND mkl.kjmo = fwws.kjmo
   ;