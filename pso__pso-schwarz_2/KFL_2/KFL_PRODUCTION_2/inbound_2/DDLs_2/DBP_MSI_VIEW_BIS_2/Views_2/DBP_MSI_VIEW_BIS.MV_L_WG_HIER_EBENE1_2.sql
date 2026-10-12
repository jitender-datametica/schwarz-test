CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_WG_HIER_EBENE1_2 as
            select  in_wg_ebene1_id

            from dbp_msi_view_bis.mv_wg_hier_denorm_2
            group by 1;