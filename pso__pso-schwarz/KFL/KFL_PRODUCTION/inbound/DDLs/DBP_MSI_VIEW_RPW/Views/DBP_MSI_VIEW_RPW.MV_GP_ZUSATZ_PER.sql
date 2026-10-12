CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_ZUSATZ_PER
             (
             mandant_id
             ,gp_id
             ,einkaufsorganisation_id
             ,dat_von
             ,entgelt_mind_kz
             ,ret_sperrprofil_id
             ,system_id
             ,dat_bis
             )
             AS
                SELECT
                mandant_id,
                gp_id,
                einkaufsorganisation_id,
                dat_von,
                entgelt_mind_kz,
                ret_sperrprofil_id,
                7,
                dat_bis
                FROM dbp_view.v_gp_zusatz_per
                WHERE (gp_id, mandant_id,  dat_bis) IN
                (
                SELECT
                gp_id,
                mandant_id,
                MAX(dat_bis)
                FROM dbp_view.v_gp_zusatz_per
                WHERE mandant_id = 1
                GROUP BY 1,2
                );