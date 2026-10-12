CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_POSTEN
       (
         posten_id
         ,posten_bez
         ,mandant_id
         ,spr_id
         ,system_id
       )
       AS
          SELECT
            posten_id,
          posten_bez,
          mandant_id,
          spr_id,
          7
          FROM dbp_view.v_artkz_posten
          WHERE mandant_id = 1
 ;