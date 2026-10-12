CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_SACHKONTO_GRUPPE_1 as
           SELECT
           sachkonto_gruppe_id,
           sachkonto_gruppe_bez,
           mandant_id,
           spr_id
           FROM dbp_view.v_ivs_l_sachkonto_gruppe_1
           WHERE spr_id = 22;