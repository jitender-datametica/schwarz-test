CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_WG_1 as
      SELECT

      in_wg_id,
      MAX(in_wg_struktur_id) AS   in_wg_ebene6_id --muss über alle Länder identisch sein

      FROM dbp_view.v_in_l_wg_1
      GROUP BY in_wg_id
;