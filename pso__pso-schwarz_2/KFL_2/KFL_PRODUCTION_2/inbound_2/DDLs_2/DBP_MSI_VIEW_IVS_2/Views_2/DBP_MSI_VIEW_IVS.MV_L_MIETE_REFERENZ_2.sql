CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_MIETE_REFERENZ_2 as
                           SELECT
                           miete_referenz_id,
                           spr_id,
                           mandant_id,
                           miete_referenz_bez
                           FROM dbp_view.v_ivs_l_miete_referenz_2
                           WHERE spr_id = 22;