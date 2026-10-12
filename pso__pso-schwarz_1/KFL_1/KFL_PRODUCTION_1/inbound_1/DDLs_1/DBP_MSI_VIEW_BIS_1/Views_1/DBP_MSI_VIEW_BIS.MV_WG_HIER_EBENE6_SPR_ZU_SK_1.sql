CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_WG_HIER_EBENE6_SPR_ZU_SK_1 as
                                                                                    SELECT

                                                                                    in_wg_ebene6_id,
                                                                                    in_wg_struktur_bez AS in_wg_ebene6_bez,
                                                                                    CASE WHEN length(in_wg_ebene6_id) = 12 THEN in_wg_struktur_bez ELSE '' END in_wg_ebene6_hier_bez

                                                                                    FROM dbp_msi_view_bis.mv_l_wg_hier_ebene6_1 v01
                                                                                    INNER JOIN dbp_view.v_in_wg_struktur_spr_zu_1 v02
                                                                                    ON v01.in_wg_ebene6_id = v02.in_wg_struktur_id

                                                                                    WHERE v02.spr_id=108;