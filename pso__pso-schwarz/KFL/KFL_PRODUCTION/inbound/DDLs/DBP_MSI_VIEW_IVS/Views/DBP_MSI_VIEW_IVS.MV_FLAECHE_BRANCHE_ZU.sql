CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_BRANCHE_ZU
                                      (
                                      mandant_id,
                                      flaeche_id,
                                      branche_id
                                      )
                                      AS
                                         SELECT
                                         mandant_id,
                                         flaeche_id,
                                         MAX(branche_id)
                                         FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi
                                         WHERE (mandant_id, flaeche_id, dat_flaeche_uebergabe)  IN
                                         (
                                         SELECT
                                         mandant_id,
                                         flaeche_id,
                                         MAX(dat_flaeche_uebergabe)
                                         FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi mfzp
                                         GROUP BY 1,2
                                         )
                                         GROUP BY 1,2;