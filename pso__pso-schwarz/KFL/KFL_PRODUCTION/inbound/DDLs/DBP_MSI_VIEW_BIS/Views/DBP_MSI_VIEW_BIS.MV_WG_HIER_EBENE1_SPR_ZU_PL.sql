CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_WG_HIER_EBENE1_SPR_ZU_PL as
                                                                                 SELECT

                                                                                 in_wg_ebene1_id,
                                                                                 in_wg_struktur_bez AS in_wg_ebene1_bez

                                                                                 FROM dbp_msi_view_bis.mv_l_wg_hier_ebene1 v01
                                                                                 INNER JOIN dbp_view.v_in_wg_struktur_spr_zu v02
                                                                                 ON v01.in_wg_ebene1_id = v02.in_wg_struktur_id

                                                                                 WHERE v02.spr_id=90;