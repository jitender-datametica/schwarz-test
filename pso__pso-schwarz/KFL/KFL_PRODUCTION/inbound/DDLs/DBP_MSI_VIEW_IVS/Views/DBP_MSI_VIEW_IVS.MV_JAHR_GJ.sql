CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_JAHR_GJ as
                   -- 2008-12-15
                   -- FAKTVIEW Zeit für KER
                   -- Dynamisch letzte 5 Jahre

                   SELECT
                   gj,
                   akt_gj,
                   akt_gj_komplett
            FROM dbp_view.v_jahr_gj

            WHERE akt_gj BETWEEN -5 AND 1;