CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BUCH_GRUND_INT_SPR_ZU
             (
             system_id
             ,mandant_id
             ,buch_grund_int_id
             ,spr_id
             ,buch_grund_int_bez
             )
             AS
                SELECT
                7,
                mandant_id,
                buch_grund_int_id,
                spr_id,
                buch_grund_int_bez
                FROM dbp_view.v_buch_grund_int_spr_zu
                WHERE mandant_id = 1
                AND  spr_id = 22;