CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ART_GP_WUP_ZU_PER
   -- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig berechnet werden kann.
   -- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID

   (
   mandant_id
   ,art_id
   ,gp_id
   ,wup_id
   ,nb_id
   ,einkaufsorganisation_id
   ,dat_von
   ,dat_bis
   ,bezugsweg_id
   ,wrg_id
   ,komponentenmenge
   ,system_id
   )
   AS
      SELECT
      mandant_id,
      art_id,
      gp_id,
      wup_id,
      nb_id,
      einkaufsorganisation_id,
      dat_von,
      dat_bis,
      bezugsweg_id,
      wrg_id,
      komponentenmenge,
      7
      FROM dbp_view.v_art_gp_wup_zu_per
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1


      UNION


      -- Dummyartikel für MWSt ID 1
      SELECT
      mandant_id,
      art_id -1 AS art_id,
      gp_id,
      wup_id,
      nb_id,
      einkaufsorganisation_id,
      dat_von,
      dat_bis,
      bezugsweg_id,
      wrg_id,
      komponentenmenge,
      7
      FROM dbp_view.v_art_gp_wup_zu_per
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1
      AND art_id BETWEEN -999000 AND -1000


      UNION


      -- Dummyartikel für MWSt ID 2
      SELECT
      mandant_id,
      art_id -2 AS art_id,
      gp_id,
      wup_id,
      nb_id,
      einkaufsorganisation_id,
      dat_von,
      dat_bis,
      bezugsweg_id,
      wrg_id,
      komponentenmenge,
      7
      FROM dbp_view.v_art_gp_wup_zu_per
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1
      AND art_id BETWEEN -999000 AND -1000


      UNION


      -- Dummyartikel für MWSt ID 3
      SELECT
      mandant_id,
      art_id -3 AS art_id,
      gp_id,
      wup_id,
      nb_id,
      einkaufsorganisation_id,
      dat_von,
      dat_bis,
      bezugsweg_id,
      wrg_id,
      komponentenmenge,
      7
      FROM dbp_view.v_art_gp_wup_zu_per
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1
      AND art_id BETWEEN -999000 AND -1000


      UNION


      -- Dummyartikel für MWSt ID 9
      SELECT
      mandant_id,
      art_id -9 AS art_id,
      gp_id,
      wup_id,
      nb_id,
      einkaufsorganisation_id,
      dat_von,
      dat_bis,
      bezugsweg_id,
      wrg_id,
      komponentenmenge,
      7
      FROM dbp_view.v_art_gp_wup_zu_per
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1
      AND art_id BETWEEN -999000 AND -1000
 ;