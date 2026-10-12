CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_SACHKONTO as
                SELECT
                sachkonto_id,
                mandant_id,
                sachkonto_bez,
                spr_id,
                sachkonto_gruppe_id,
                plandetail_id,
                plantyp_id
                FROM dbp_view.v_ivs_l_sachkonto
                WHERE spr_id = 22;