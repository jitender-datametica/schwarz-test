CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_JAHR_KJ_1
   -- 03.11.2014 twie: initial
   (
   kj
   ,akt_kj
   ,akt_kj_komplett
   )
   AS
      SELECT
     kj,
      akt_kj,
      akt_kj_komplett

      FROM dbp_view.v_jahr_kj_1;