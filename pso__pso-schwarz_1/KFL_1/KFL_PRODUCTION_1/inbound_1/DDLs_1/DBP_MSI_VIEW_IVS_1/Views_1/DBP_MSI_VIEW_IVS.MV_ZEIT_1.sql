CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_ZEIT_1 as
                                    -- 2009-06-18
                                    -- ZEIT_1 aggregiert auf Basis Tag_1-Tabelle
                                    -- 2009KW27 initial;
                                    -- Ermittlung erster/letzter Tag_1, ohne distinct

                                    SELECT
                                    t0.gj,
                                    t0.akt_gj,
                                    t0.akt_gj_komplett,
                                    t0.kj,
                                    t0.kjmo,
                                    t0.akt_mo,
                                    t0.akt_mo_komplett,
                                    MIN(t0.dat)  kjmo_dat_von,
                                    MAX(t0.dat)  kjmo_dat_bis
                                   FROM dbp_view.v_tag_1 t0

                                    GROUP BY
                                    t0.gj
                                    , t0.akt_gj
                                    , t0.akt_gj_komplett
                                    , t0.kj
                                    , t0.kjmo
                                    , t0.akt_mo
                                    , t0.akt_mo_komplett
;