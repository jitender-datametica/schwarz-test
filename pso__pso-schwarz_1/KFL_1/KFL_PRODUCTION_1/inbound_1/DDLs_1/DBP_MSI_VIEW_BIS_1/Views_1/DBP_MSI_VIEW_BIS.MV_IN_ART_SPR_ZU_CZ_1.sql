CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_ART_SPR_ZU_CZ_1
      -- SH 10.01.2013 initial;


      (
      mandant_id
      , in_art_id
      , art_bez

      )
      AS
         SELECT
         mandant_id,
         in_art_id,
         art_bez


        FROM dbp_view.v_in_art_spr_zu_1 v01
         where spr_id=124;