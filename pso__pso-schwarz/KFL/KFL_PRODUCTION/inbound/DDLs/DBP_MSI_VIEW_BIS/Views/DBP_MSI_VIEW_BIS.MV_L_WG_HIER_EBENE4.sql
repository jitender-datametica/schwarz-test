CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_WG_HIER_EBENE4 as
      SELECT   in_wg_ebene4_id,
      in_wg_ebene3_id

      FROM dbp_msi_view_bis.mv_wg_hier_denorm
      GROUP BY  in_wg_ebene4_id,
      in_wg_ebene3_id;