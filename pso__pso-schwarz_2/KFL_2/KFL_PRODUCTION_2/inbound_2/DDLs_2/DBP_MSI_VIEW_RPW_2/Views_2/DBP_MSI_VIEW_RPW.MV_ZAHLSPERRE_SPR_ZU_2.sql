CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ZAHLSPERRE_SPR_ZU_2
                (
                mandant_id
                ,zahlsperre_id
                ,spr_id
                ,zahlsperre_bez
                ,system_id
                )
                AS
                   SELECT
                   mandant_id,
                   zahlsperre_id,
                   spr_id,
                   zahlsperre_bez,
                   7
                   FROM dbp_view.v_zahlsperre_spr_zu_2
                   WHERE mandant_id = 1
                   AND  spr_id = 22
 ;