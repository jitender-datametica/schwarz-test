CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_WG_HIER_EBENE3_SPR_ZU_RO as
                                                   SELECT

                                                   in_wg_ebene3_id,
                                                   in_wg_struktur_bez AS in_wg_ebene3_bez,
                                                   CASE WHEN length(in_wg_ebene3_id) = 6 THEN in_wg_struktur_bez ELSE '' END in_wg_ebene3_hier_bez

                                                   FROM dbp_msi_view_bis.mv_l_wg_hier_ebene3 v01
                                                   INNER JOIN dbp_view.v_in_wg_struktur_spr_zu v02
                                                   ON v01.in_wg_ebene3_id = v02.in_wg_struktur_id

                                                   WHERE v02.spr_id=95;