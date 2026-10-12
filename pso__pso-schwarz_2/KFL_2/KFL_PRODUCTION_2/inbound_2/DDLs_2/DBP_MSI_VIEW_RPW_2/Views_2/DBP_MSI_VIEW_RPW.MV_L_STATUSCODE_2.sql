CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_STATUSCODE_2
                (
                mandant_id
                ,statuscode_id
                ,system_id
                )
                AS
                   SELECT
                   mandant_id,
                   statuscode_id,
                   7
                   FROM dbp_view.v_l_statuscode_2
                   WHERE mandant_id = 1
 ;