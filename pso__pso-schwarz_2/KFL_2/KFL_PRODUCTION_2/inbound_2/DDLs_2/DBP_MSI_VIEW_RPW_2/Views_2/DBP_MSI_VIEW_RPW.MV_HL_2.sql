CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HL_2
                   (
                     hl_id
                     ,hl_name
                     ,mandant_id
                     ,system_id
                   )
                   AS
                      SELECT
                        hl_id,
                      hl_name,
                      mandant_id,
                      7
                      FROM dbp_view.v_hl_2
                      WHERE mandant_id = 1
 ;