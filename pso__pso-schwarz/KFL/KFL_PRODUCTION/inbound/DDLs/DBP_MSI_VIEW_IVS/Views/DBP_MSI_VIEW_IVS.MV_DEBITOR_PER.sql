CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_DEBITOR_PER
                              AS
                                 -- 2009-05-04
                                 -- LOOKUP Debitor Stammdaten
                                 -- Beziehung (1:n) Debitor-Konzessionaer
                                 -- 2011KW35 konzessionaer_id 0 auf '0'
                                 -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten

                                 SELECT
                                 dp.mandant_id,
                                 dp.debitor_id,
                                 dp.debitor_status_id,
                                 dp.dat_von,
                                 dp.dat_bis,
                                 COALESCE(dp.konzessionaer_id, '0')  konzessionaer_id,
                                 dp.ivs_fg

                                FROM dbp_view.v_ivs_debitor_per  dp

                                 WHERE dat_bis = '9999-12-31'
                                 AND ivs_fg = 1 -- nur Immo-Relevante Debitoren
                                 ;