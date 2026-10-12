CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_VERMIETER_PER_2 as
                    --------------------------------------------------------------
                    -- 2008-12-15  tammdaten Vermieter
                    -- 2013KW02 Transkription ergaenzt
                    --------------------------------------------------------------

                    SELECT
                    mandant_id,
                    vermieter_id,
                    dat_von,
                    dat_bis,
                    dbp_process.transcriptc(vermieter_name) AS vermieter_name,
                    intern_fg,
                    land_id,
                    vermieter_plz,
                    dbp_process.transcriptc(vermieter_ort) AS vermieter_ort,
                    dbp_process.transcriptc(vermieter_strasse) AS vermieter_strasse,
                    vermieter_rechtsform,
                    dat_insolvenz_eintritt,
                    vermieter_branche_id
                    FROM dbp_view.v_ivs_vermieter_per_2

                    WHERE dat_bis = '9999-12-31'
;