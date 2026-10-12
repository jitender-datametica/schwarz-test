CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAGER_BEWGRUND_SPR_ZU_2
       (
         mandant_id
        ,grund_id
        ,spr_id
        ,grund_bez
        ,system_id
       )
       AS
          SELECT
            mandant_id,
          grund_id,
          spr_id,
          MAX(grund_bez),
          7
          FROM dbp_view.v_lager_bewgrund_spr_zu_2
          WHERE spr_id = 22
            AND mandant_id = 1
          GROUP BY 1,2,3,5
 ;