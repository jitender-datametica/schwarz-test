create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ART_GP_WUP_ZU_PER_2(
	MANDANT_ID,
	ART_ID,
	GP_ID,
	WUP_ID,
	NB_ID,
	EINKAUFSORGANISATION_ID,
	DAT_VON,
	DAT_BIS,
	BEZUGSWEG_ID,
	WRG_ID,
	KOMPONENTENMENGE,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 19.10.2018 twie: SPEC0041626 für die Sachkonten (-999000 <= art_id <= -1000) wird pro MWSt Satz ein eigener Dummyartikel erstellt, damit die MWSt. richtig berechnet werden kann.
-- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID
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
      FROM dbp_view.v_art_gp_wup_zu_per_2
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
      FROM dbp_view.v_art_gp_wup_zu_per_2
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
      FROM dbp_view.v_art_gp_wup_zu_per_2
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
      FROM dbp_view.v_art_gp_wup_zu_per_2
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
      FROM dbp_view.v_art_gp_wup_zu_per_2
      WHERE dat_bis = '9999-12-31'
      AND mandant_id = 1
      AND art_id BETWEEN -999000 AND -1000
 ;
