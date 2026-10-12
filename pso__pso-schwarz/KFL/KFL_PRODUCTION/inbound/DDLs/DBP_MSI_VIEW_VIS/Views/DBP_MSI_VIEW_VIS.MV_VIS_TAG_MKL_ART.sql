CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_MKL_ART (
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      DAT,
      KJ,
      DAT_WE,
      DAT_AENDERUNG,
      PROBLEMCODE_ID,
      MKL_BELEG_ID,
      MKL_BELEG_POS_ID,
      ART_ID,
      GP_ID,
      REF_BELEG_ID,
      VERURSACHER_ID,
      MENGE_WE,
      WE_MENGE_EINH_ID,
      RETOURE_FG,
      MENGE_KOR,
      KOR_MENGE_EINH_ID,
      ANZEIGEN_FG,
      KOPF_FEHLER_FG,
      POS_FEHLER_FG
)
AS
   -- FAKT Mengenkorrekturliste Artikel/Lieferant/Problemcode pro Filiale/Tag
   -- Basis: SAP Retailstore [zrs_mkldata]
   -- Ersetzt: mv_mengenkorrekturliste_det, mv_vis_monat_fwws_wup_gp_pc, mv_vis_monat_fwws_wup_pc
   -- 20150814 Initial
   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
   mkl.mandant_id
   , mkl.nb_id
   , wup.aktuell_wup_id AS wup_id
   , mkl.dat_aenderung                                                     AS dat      -- Mapping auf Zeithierarchie
   , mkl.kj                                                                            -- Inhalt unklar (not used)
   , mkl.dat_we, mkl.dat_aenderung, mkl.problemcode_id                                 -- mkl_problemcode!
   , mkl.mkl_beleg_id, mkl.mkl_beleg_pos_id
   , CASE 
      WHEN pc.kopf_fehler_fg = 1 AND mkl.anzeigen_fg = 1 AND (mkl.menge_kor = mkl.menge_we) THEN -1
      ELSE mkl.art_id END                                                  AS art_id   -- Logik Artikel Anzeige
   , mkl.gp_id
   , mkl.ref_beleg_id
   , mkl.verursacher_id
   , mkl.menge_we
   , mkl.we_menge_einh_id
   , mkl.retoure_fg
   , mkl.menge_kor
   , mkl.kor_menge_einh_id
   , mkl.anzeigen_fg                  -- Steuerung Berichtsanzeige
   , pc.kopf_fehler_fg
   , pc.pos_fehler_fg

   FROM dbp_view.v_vis_mengen_korrektur_liste mkl
   INNER JOIN dbp_view.v_vis_l_problemcode pc
   ON mkl.mandant_id = pc.mandant_id
   AND mkl.problemcode_id = pc.problemcode_id
   INNER JOIN dbp_view.v_wup wup
 	ON mkl.mandant_id = wup.mandant_id AND mkl.wup_id = wup.wup_id

   ;