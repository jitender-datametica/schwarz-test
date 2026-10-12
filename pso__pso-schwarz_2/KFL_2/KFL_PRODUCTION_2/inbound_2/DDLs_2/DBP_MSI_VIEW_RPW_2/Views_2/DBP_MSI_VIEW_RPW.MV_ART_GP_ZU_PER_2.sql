CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ART_GP_ZU_PER_2
          -- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig berechnet werden kann.
          -- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID

          (
          art_id
          ,mandant_id
          ,gp_id
          ,dat_von
          ,herst_id
          ,einkaufsorganisation_id
          ,gp_art_id
          ,dat_bis
          ,mhd_zeitraum_dz
          ,system_id
          )
          AS
             SELECT
             art_id,
             mandant_id,
             gp_id,
             dat_von,
             herst_id,
             einkaufsorganisation_id,
             gp_art_id,
             dat_bis,
             mhd_zeitraum_dz,
             7
             FROM dbp_view.v_art_gp_zu_per_2
             WHERE mandant_id = 1
             AND dat_bis = '9999-12-31'


             UNION


             -- Dummyartikel für MWSt ID 1
             SELECT
             art_id - 1 AS art_id,
             mandant_id,
             gp_id,
             dat_von,
             herst_id,
             einkaufsorganisation_id,
             gp_art_id,
             dat_bis,
             mhd_zeitraum_dz,
             7
             FROM dbp_view.v_art_gp_zu_per_2
             WHERE mandant_id = 1
             AND dat_bis = '9999-12-31'
             AND art_id BETWEEN -999000 AND -1000


             UNION


             -- Dummyartikel für MWSt ID 2
             SELECT
             art_id - 2 AS art_id,
             mandant_id,
             gp_id,
             dat_von,
             herst_id,
             einkaufsorganisation_id,
             gp_art_id,
             dat_bis,
             mhd_zeitraum_dz,
             7
             FROM dbp_view.v_art_gp_zu_per_2
             WHERE mandant_id = 1
             AND dat_bis = '9999-12-31'
             AND art_id BETWEEN -999000 AND -1000


             UNION


             -- Dummyartikel für MWSt ID 3
             SELECT
             art_id - 3 AS art_id,
             mandant_id,
             gp_id,
             dat_von,
             herst_id,
             einkaufsorganisation_id,
             gp_art_id,
             dat_bis,
             mhd_zeitraum_dz,
             7
             FROM dbp_view.v_art_gp_zu_per_2
             WHERE mandant_id = 1
             AND dat_bis = '9999-12-31'
             AND art_id BETWEEN -999000 AND -1000


             UNION


             -- Dummyartikel für MWSt ID 9
             SELECT
             art_id - 9 AS art_id,
             mandant_id,
             gp_id,
             dat_von,
             herst_id,
             einkaufsorganisation_id,
             gp_art_id,
             dat_bis,
             mhd_zeitraum_dz,
             7
             FROM dbp_view.v_art_gp_zu_per_2
             WHERE mandant_id = 1
             AND dat_bis = '9999-12-31'
             AND art_id BETWEEN -999000 AND -1000
 ;