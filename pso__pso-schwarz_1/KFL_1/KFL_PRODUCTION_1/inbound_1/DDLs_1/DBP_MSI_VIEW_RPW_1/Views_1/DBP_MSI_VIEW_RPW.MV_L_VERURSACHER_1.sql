CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_VERURSACHER_1
             (
             system_id
             ,mandant_id
             ,verursacher_id
             )
             AS
                SELECT
                7,
                mandant_id,
                verursacher_id
                FROM dbp_view.v_l_verursacher_1
                WHERE mandant_id = 1
 ;