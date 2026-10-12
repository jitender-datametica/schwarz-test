CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_LEIST (
         leist_id
         ,leist_bez
         ,mandant_id
         ,spr_id
         ,system_id
)
         AS
            SELECT
              leist_id,
            leist_bez,
            mandant_id,
            spr_id,
            7
            FROM dbp_view.v_artkz_leist
            WHERE mandant_id = 1
 ;