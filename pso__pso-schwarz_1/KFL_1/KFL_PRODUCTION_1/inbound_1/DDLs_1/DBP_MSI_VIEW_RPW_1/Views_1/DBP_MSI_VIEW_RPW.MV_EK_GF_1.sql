CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_EK_GF_1
       (
         gf_id
         ,gf_name
         ,mandant_id
         ,ek_flg
         ,system_id
       )
       AS
          SELECT
            gf_id,
          gf_name,
          mandant_id,
          ek_fg,
          7 AS system_id
          FROM dbp_view.v_gf_1
          WHERE mandant_id=1
            AND ek_fg = 1
 ;