CREATE OR REPLACE VOLATILE TABLE _woche_13 AS 
(
SELECT kjwo FROM dbp_data.woche WHERE akt_wo between (select AKT_WO-14 from dbp_data.woche where kjwo = ${kjwo_update}) and (select AKT_WO-2 from dbp_data.woche where kjwo = ${kjwo_update})
);

CREATE OR REPLACE VOLATILE TABLE _woche_26 AS 
(
SELECT kjwo FROM dbp_data.woche WHERE akt_wo between (select AKT_WO-27 from dbp_data.woche where kjwo = ${kjwo_update}) and (select AKT_WO-2 from dbp_data.woche where kjwo = ${kjwo_update})
);

CREATE OR REPLACE VOLATILE TABLE _woche_52 AS 
(
SELECT kjwo FROM dbp_data.woche WHERE akt_wo between (select AKT_WO-53 from dbp_data.woche where kjwo = ${kjwo_update}) and (select AKT_WO-2 from dbp_data.woche where kjwo = ${kjwo_update})
);

delete from dbp_msi_data.TUPEL_13_WOCHEN where kjwo_13 = (SELECT max(kjwo) from _woche_13) ; 

INSERT INTO dbp_msi_data.TUPEL_13_WOCHEN (mandant_id
,kjwo_13
,kjwo_update
,matching_id
,anzahl_markt_wochen_kombis_abverkauf_af
,anzahl_markt_wochen_kombis_abverkauf_sa
,anzahl_markt_wochen_kombis_abverkauf_af_vj
,anzahl_markt_wochen_kombis_abverkauf_sa_vj
,kassenumsatz_kl_absolut_brutto
,kassenumsatz_af_kl_absolut_brutto
,kassenumsatz_sa_kl_absolut_brutto
,kassenumsatz_kl_absolut_brutto_vj
,kassenumsatz_af_kl_absolut_brutto_vj
,kassenumsatz_sa_kl_absolut_brutto_vj
,kassenumsatz_kl_absolut_netto
,kassenumsatz_af_kl_absolut_netto
,kassenumsatz_sa_kl_absolut_netto
,kassenumsatz_kl_absolut_netto_vj
,kassenumsatz_af_kl_absolut_netto_vj
,kassenumsatz_sa_kl_absolut_netto_vj
,absatz_kl
,absatz_af_kl
,absatz_sa_kl
,absatz_kl_vj
,absatz_af_kl_vj
,absatz_sa_kl_vj
,absatz_sst1
,absatz_sst2
,absatz_sst3
,absatz_sst4
,absatz_sst5
,absatz_sst6
,absatz_sst7
,absatz_ksst1
,absatz_ksst2
,absatz_ksst3
,absatz_ksst4
,absatz_ksst5
,absatz_ksst6
,absatz_ksst7
,absatz_ost_basis
,absatz_ost_gross
,absatz_sued_ost
,absatz_sued_west
,absatz_west
,absatz_nord
,markt_wochen_sst1
,markt_wochen_sst2
,markt_wochen_sst3
,markt_wochen_sst4
,markt_wochen_sst5
,markt_wochen_sst6
,markt_wochen_sst7
,markt_wochen_ksst1
,markt_wochen_ksst2
,markt_wochen_ksst3
,markt_wochen_ksst4
,markt_wochen_ksst5
,markt_wochen_ksst6
,markt_wochen_ksst7
,markt_wochen_ost_basis
,markt_wochen_ost_gross
,markt_wochen_sued_ost
,markt_wochen_sued_west
,markt_wochen_west
,markt_wochen_nord
,anzahl_markt_wochen_kombis_abverkauf_mit_listung
,anzahl_markt_wochen_kombis_listung
,rohertrag_ekmep_olk_4n
,rohertrag_ekmep_olk_4n_vj
,rohertrag_ekmep_olk_4n_af
,rohertrag_ekmep_olk_4n_sa
,rohertrag_ekmep_olk_4n_af_vj
,rohertrag_ekmep_olk_4n_sa_vj
,totalabschriften_wert_netto_absolut
,preisabschriften_preisanderungen_wert_netto_absolut
,totalabschriften_wert_netto_absolut_vj
,preisabschriften_preisanderungen_wert_netto_absolut_vj
,kassenumsatz_kl_absolut_netto_wg
,totalabschriften_wert_netto_absolut_wg
,preisabschriften_preisanderungen_wert_netto_absolut_wg
,absatz_af_kl_listungswochen
,absatz_af_kl_vj_listungswochen
,absatz_sa_kl_listungswochen
,absatz_sa_kl_vj_listungswochen
,kassenumsatz_af_kl_absolut_netto_listungswochen
,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
,kassenumsatz_sa_kl_absolut_netto_listungswochen
,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
,rohertrag_ekmep_olk_4n_af_listungswochen
,rohertrag_ekmep_olk_4n_af_vj_listungswochen
,rohertrag_ekmep_olk_4n_sa_listungswochen
,rohertrag_ekmep_olk_4n_sa_vj_listungswochen
,td_insert
,td_update)
SELECT mandant_id
,(SELECT max(kjwo) from _woche_13) as kjwo_13
,${kjwo_update}
,matching_id
,SUM(anzahl_markt_wochen_kombis_abverkauf_af                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj                               )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj                               )
,SUM(kassenumsatz_kl_absolut_brutto                                           )
,SUM(kassenumsatz_af_kl_absolut_brutto                                        )
,SUM(kassenumsatz_sa_kl_absolut_brutto                                        )
,SUM(kassenumsatz_kl_absolut_brutto_vj                                        )
,SUM(kassenumsatz_af_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_sa_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_kl_absolut_netto                                            )
,SUM(kassenumsatz_af_kl_absolut_netto                                         )
,SUM(kassenumsatz_sa_kl_absolut_netto                                         )
,SUM(kassenumsatz_kl_absolut_netto_vj                                         )
,SUM(kassenumsatz_af_kl_absolut_netto_vj                                      )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj                                      )
,SUM(absatz_kl                                                                )
,SUM(absatz_af_kl                                                             )
,SUM(absatz_sa_kl                                                             )
,SUM(absatz_kl_vj                                                             )
,SUM(absatz_af_kl_vj                                                          )
,SUM(absatz_sa_kl_vj                                                          )
,SUM(absatz_sst1                                                              )
,SUM(absatz_sst2                                                              )
,SUM(absatz_sst3                                                              )
,SUM(absatz_sst4                                                              )
,SUM(absatz_sst5                                                              )
,SUM(absatz_sst6                                                              )
,SUM(absatz_sst7                                                              )
,SUM(absatz_ksst1                                                             )
,SUM(absatz_ksst2                                                             )
,SUM(absatz_ksst3                                                             )
,SUM(absatz_ksst4                                                             )
,SUM(absatz_ksst5                                                             )
,SUM(absatz_ksst6                                                             )
,SUM(absatz_ksst7                                                             )
,SUM(absatz_ost_basis                                                         )
,SUM(absatz_ost_gross                                                         )
,SUM(absatz_sued_ost                                                          )
,SUM(absatz_sued_west                                                         )
,SUM(absatz_west                                                              )
,SUM(absatz_nord                                                              )
,SUM(markt_wochen_sst1                                                        )
,SUM(markt_wochen_sst2                                                        )
,SUM(markt_wochen_sst3                                                        )
,SUM(markt_wochen_sst4                                                        )
,SUM(markt_wochen_sst5                                                        )
,SUM(markt_wochen_sst6                                                        )
,SUM(markt_wochen_sst7                                                        )
,SUM(markt_wochen_ksst1                                                       )
,SUM(markt_wochen_ksst2                                                       )
,SUM(markt_wochen_ksst3                                                       )
,SUM(markt_wochen_ksst4                                                       )
,SUM(markt_wochen_ksst5                                                       )
,SUM(markt_wochen_ksst6                                                       )
,SUM(markt_wochen_ksst7                                                       )
,SUM(markt_wochen_ost_basis                                                   )
,SUM(markt_wochen_ost_gross                                                   )
,SUM(markt_wochen_sued_ost                                                    )
,SUM(markt_wochen_sued_west                                                   )
,SUM(markt_wochen_west                                                        )
,SUM(markt_wochen_nord                                                        )
,SUM(anzahl_markt_wochen_kombis_abverkauf_mit_listung                         )
,SUM(anzahl_markt_wochen_kombis_listung                                       )
,SUM(rohertrag_ekmep_olk_4n                                                   )
,SUM(rohertrag_ekmep_olk_4n_vj                                                )
,SUM(rohertrag_ekmep_olk_4n_af                                                )
,SUM(rohertrag_ekmep_olk_4n_sa                                                )
,SUM(rohertrag_ekmep_olk_4n_af_vj                                             )
,SUM(rohertrag_ekmep_olk_4n_sa_vj                                             )
,SUM(totalabschriften_wert_netto_absolut                                      )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut                      )
,SUM(totalabschriften_wert_netto_absolut_vj                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_vj                   )
,SUM(kassenumsatz_kl_absolut_netto_wg                                         )
,SUM(totalabschriften_wert_netto_absolut_wg                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_wg                   )
,SUM(absatz_af_kl_listungswochen                                              )
,SUM(absatz_af_kl_vj_listungswochen                                           )
,SUM(absatz_sa_kl_listungswochen                                              )
,SUM(absatz_sa_kl_vj_listungswochen                                           )
,SUM(kassenumsatz_af_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_af_kl_absolut_netto_vj_listungswochen                       )
,SUM(kassenumsatz_sa_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj_listungswochen                       )
,SUM(rohertrag_ekmep_olk_4n_af_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_af_vj_listungswochen                              )
,SUM(rohertrag_ekmep_olk_4n_sa_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_sa_vj_listungswochen                              )
,MAX(current_timestamp)
,MAX(current_timestamp)
FROM dbp_data.tupel_kw
WHERE kjwo in (select kjwo from _woche_13 group by 1)
GROUP BY 1,2,3,4
;

delete from dbp_msi_data.TUPEL_26_WOCHEN where kjwo_26 = (SELECT max(kjwo) from _woche_26) ; 

INSERT INTO dbp_msi_data.TUPEL_26_WOCHEN (mandant_id
,kjwo_26
,kjwo_update
,matching_id
,anzahl_markt_wochen_kombis_abverkauf_af
,anzahl_markt_wochen_kombis_abverkauf_sa
,anzahl_markt_wochen_kombis_abverkauf_af_vj
,anzahl_markt_wochen_kombis_abverkauf_sa_vj
,kassenumsatz_kl_absolut_brutto
,kassenumsatz_af_kl_absolut_brutto
,kassenumsatz_sa_kl_absolut_brutto
,kassenumsatz_kl_absolut_brutto_vj
,kassenumsatz_af_kl_absolut_brutto_vj
,kassenumsatz_sa_kl_absolut_brutto_vj
,kassenumsatz_kl_absolut_netto
,kassenumsatz_af_kl_absolut_netto
,kassenumsatz_sa_kl_absolut_netto
,kassenumsatz_kl_absolut_netto_vj
,kassenumsatz_af_kl_absolut_netto_vj
,kassenumsatz_sa_kl_absolut_netto_vj
,absatz_kl
,absatz_af_kl
,absatz_sa_kl
,absatz_kl_vj
,absatz_af_kl_vj
,absatz_sa_kl_vj
,absatz_sst1
,absatz_sst2
,absatz_sst3
,absatz_sst4
,absatz_sst5
,absatz_sst6
,absatz_sst7
,absatz_ksst1
,absatz_ksst2
,absatz_ksst3
,absatz_ksst4
,absatz_ksst5
,absatz_ksst6
,absatz_ksst7
,absatz_ost_basis
,absatz_ost_gross
,absatz_sued_ost
,absatz_sued_west
,absatz_west
,absatz_nord
,markt_wochen_sst1
,markt_wochen_sst2
,markt_wochen_sst3
,markt_wochen_sst4
,markt_wochen_sst5
,markt_wochen_sst6
,markt_wochen_sst7
,markt_wochen_ksst1
,markt_wochen_ksst2
,markt_wochen_ksst3
,markt_wochen_ksst4
,markt_wochen_ksst5
,markt_wochen_ksst6
,markt_wochen_ksst7
,markt_wochen_ost_basis
,markt_wochen_ost_gross
,markt_wochen_sued_ost
,markt_wochen_sued_west
,markt_wochen_west
,markt_wochen_nord
,anzahl_markt_wochen_kombis_abverkauf_mit_listung
,anzahl_markt_wochen_kombis_listung
,rohertrag_ekmep_olk_4n
,rohertrag_ekmep_olk_4n_vj
,rohertrag_ekmep_olk_4n_af
,rohertrag_ekmep_olk_4n_sa
,rohertrag_ekmep_olk_4n_af_vj
,rohertrag_ekmep_olk_4n_sa_vj
,totalabschriften_wert_netto_absolut
,preisabschriften_preisanderungen_wert_netto_absolut
,totalabschriften_wert_netto_absolut_vj
,preisabschriften_preisanderungen_wert_netto_absolut_vj
,kassenumsatz_kl_absolut_netto_wg
,totalabschriften_wert_netto_absolut_wg
,preisabschriften_preisanderungen_wert_netto_absolut_wg
,absatz_af_kl_listungswochen
,absatz_af_kl_vj_listungswochen
,absatz_sa_kl_listungswochen
,absatz_sa_kl_vj_listungswochen
,kassenumsatz_af_kl_absolut_netto_listungswochen
,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
,kassenumsatz_sa_kl_absolut_netto_listungswochen
,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
,rohertrag_ekmep_olk_4n_af_listungswochen
,rohertrag_ekmep_olk_4n_af_vj_listungswochen
,rohertrag_ekmep_olk_4n_sa_listungswochen
,rohertrag_ekmep_olk_4n_sa_vj_listungswochen
,td_insert
,td_update)
SELECT mandant_id
,(SELECT max(kjwo) from _woche_26) as kjwo_26
,${kjwo_update}
,matching_id
,SUM(anzahl_markt_wochen_kombis_abverkauf_af                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj                               )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj                               )
,SUM(kassenumsatz_kl_absolut_brutto                                           )
,SUM(kassenumsatz_af_kl_absolut_brutto                                        )
,SUM(kassenumsatz_sa_kl_absolut_brutto                                        )
,SUM(kassenumsatz_kl_absolut_brutto_vj                                        )
,SUM(kassenumsatz_af_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_sa_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_kl_absolut_netto                                            )
,SUM(kassenumsatz_af_kl_absolut_netto                                         )
,SUM(kassenumsatz_sa_kl_absolut_netto                                         )
,SUM(kassenumsatz_kl_absolut_netto_vj                                         )
,SUM(kassenumsatz_af_kl_absolut_netto_vj                                      )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj                                      )
,SUM(absatz_kl                                                                )
,SUM(absatz_af_kl                                                             )
,SUM(absatz_sa_kl                                                             )
,SUM(absatz_kl_vj                                                             )
,SUM(absatz_af_kl_vj                                                          )
,SUM(absatz_sa_kl_vj                                                          )
,SUM(absatz_sst1                                                              )
,SUM(absatz_sst2                                                              )
,SUM(absatz_sst3                                                              )
,SUM(absatz_sst4                                                              )
,SUM(absatz_sst5                                                              )
,SUM(absatz_sst6                                                              )
,SUM(absatz_sst7                                                              )
,SUM(absatz_ksst1                                                             )
,SUM(absatz_ksst2                                                             )
,SUM(absatz_ksst3                                                             )
,SUM(absatz_ksst4                                                             )
,SUM(absatz_ksst5                                                             )
,SUM(absatz_ksst6                                                             )
,SUM(absatz_ksst7                                                             )
,SUM(absatz_ost_basis                                                         )
,SUM(absatz_ost_gross                                                         )
,SUM(absatz_sued_ost                                                          )
,SUM(absatz_sued_west                                                         )
,SUM(absatz_west                                                              )
,SUM(absatz_nord                                                              )
,SUM(markt_wochen_sst1                                                        )
,SUM(markt_wochen_sst2                                                        )
,SUM(markt_wochen_sst3                                                        )
,SUM(markt_wochen_sst4                                                        )
,SUM(markt_wochen_sst5                                                        )
,SUM(markt_wochen_sst6                                                        )
,SUM(markt_wochen_sst7                                                        )
,SUM(markt_wochen_ksst1                                                       )
,SUM(markt_wochen_ksst2                                                       )
,SUM(markt_wochen_ksst3                                                       )
,SUM(markt_wochen_ksst4                                                       )
,SUM(markt_wochen_ksst5                                                       )
,SUM(markt_wochen_ksst6                                                       )
,SUM(markt_wochen_ksst7                                                       )
,SUM(markt_wochen_ost_basis                                                   )
,SUM(markt_wochen_ost_gross                                                   )
,SUM(markt_wochen_sued_ost                                                    )
,SUM(markt_wochen_sued_west                                                   )
,SUM(markt_wochen_west                                                        )
,SUM(markt_wochen_nord                                                        )
,SUM(anzahl_markt_wochen_kombis_abverkauf_mit_listung                         )
,SUM(anzahl_markt_wochen_kombis_listung                                       )
,SUM(rohertrag_ekmep_olk_4n                                                   )
,SUM(rohertrag_ekmep_olk_4n_vj                                                )
,SUM(rohertrag_ekmep_olk_4n_af                                                )
,SUM(rohertrag_ekmep_olk_4n_sa                                                )
,SUM(rohertrag_ekmep_olk_4n_af_vj                                             )
,SUM(rohertrag_ekmep_olk_4n_sa_vj                                             )
,SUM(totalabschriften_wert_netto_absolut                                      )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut                      )
,SUM(totalabschriften_wert_netto_absolut_vj                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_vj                   )
,SUM(kassenumsatz_kl_absolut_netto_wg                                         )
,SUM(totalabschriften_wert_netto_absolut_wg                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_wg                   )
,SUM(absatz_af_kl_listungswochen                                              )
,SUM(absatz_af_kl_vj_listungswochen                                           )
,SUM(absatz_sa_kl_listungswochen                                              )
,SUM(absatz_sa_kl_vj_listungswochen                                           )
,SUM(kassenumsatz_af_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_af_kl_absolut_netto_vj_listungswochen                       )
,SUM(kassenumsatz_sa_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj_listungswochen                       )
,SUM(rohertrag_ekmep_olk_4n_af_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_af_vj_listungswochen                              )
,SUM(rohertrag_ekmep_olk_4n_sa_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_sa_vj_listungswochen                              )
,MAX(current_timestamp)
,MAX(current_timestamp)
FROM dbp_data.tupel_kw
WHERE kjwo in (select kjwo from _woche_26 group by 1)
GROUP BY 1,2,3,4
;

delete from dbp_msi_data.TUPEL_52_WOCHEN where kjwo_52 = (SELECT max(kjwo) from _woche_52) ; 

INSERT INTO dbp_msi_data.TUPEL_52_WOCHEN (mandant_id
,kjwo_52
,kjwo_update
,matching_id
,anzahl_markt_wochen_kombis_abverkauf_af
,anzahl_markt_wochen_kombis_abverkauf_sa
,anzahl_markt_wochen_kombis_abverkauf_af_vj
,anzahl_markt_wochen_kombis_abverkauf_sa_vj
,kassenumsatz_kl_absolut_brutto
,kassenumsatz_af_kl_absolut_brutto
,kassenumsatz_sa_kl_absolut_brutto
,kassenumsatz_kl_absolut_brutto_vj
,kassenumsatz_af_kl_absolut_brutto_vj
,kassenumsatz_sa_kl_absolut_brutto_vj
,kassenumsatz_kl_absolut_netto
,kassenumsatz_af_kl_absolut_netto
,kassenumsatz_sa_kl_absolut_netto
,kassenumsatz_kl_absolut_netto_vj
,kassenumsatz_af_kl_absolut_netto_vj
,kassenumsatz_sa_kl_absolut_netto_vj
,absatz_kl
,absatz_af_kl
,absatz_sa_kl
,absatz_kl_vj
,absatz_af_kl_vj
,absatz_sa_kl_vj
,absatz_sst1
,absatz_sst2
,absatz_sst3
,absatz_sst4
,absatz_sst5
,absatz_sst6
,absatz_sst7
,absatz_ksst1
,absatz_ksst2
,absatz_ksst3
,absatz_ksst4
,absatz_ksst5
,absatz_ksst6
,absatz_ksst7
,absatz_ost_basis
,absatz_ost_gross
,absatz_sued_ost
,absatz_sued_west
,absatz_west
,absatz_nord
,markt_wochen_sst1
,markt_wochen_sst2
,markt_wochen_sst3
,markt_wochen_sst4
,markt_wochen_sst5
,markt_wochen_sst6
,markt_wochen_sst7
,markt_wochen_ksst1
,markt_wochen_ksst2
,markt_wochen_ksst3
,markt_wochen_ksst4
,markt_wochen_ksst5
,markt_wochen_ksst6
,markt_wochen_ksst7
,markt_wochen_ost_basis
,markt_wochen_ost_gross
,markt_wochen_sued_ost
,markt_wochen_sued_west
,markt_wochen_west
,markt_wochen_nord
,anzahl_markt_wochen_kombis_abverkauf_mit_listung
,anzahl_markt_wochen_kombis_listung
,rohertrag_ekmep_olk_4n
,rohertrag_ekmep_olk_4n_vj
,rohertrag_ekmep_olk_4n_af
,rohertrag_ekmep_olk_4n_sa
,rohertrag_ekmep_olk_4n_af_vj
,rohertrag_ekmep_olk_4n_sa_vj
,totalabschriften_wert_netto_absolut
,preisabschriften_preisanderungen_wert_netto_absolut
,totalabschriften_wert_netto_absolut_vj
,preisabschriften_preisanderungen_wert_netto_absolut_vj
,kassenumsatz_kl_absolut_netto_wg
,totalabschriften_wert_netto_absolut_wg
,preisabschriften_preisanderungen_wert_netto_absolut_wg
,absatz_af_kl_listungswochen
,absatz_af_kl_vj_listungswochen
,absatz_sa_kl_listungswochen
,absatz_sa_kl_vj_listungswochen
,kassenumsatz_af_kl_absolut_netto_listungswochen
,kassenumsatz_af_kl_absolut_netto_vj_listungswochen
,kassenumsatz_sa_kl_absolut_netto_listungswochen
,kassenumsatz_sa_kl_absolut_netto_vj_listungswochen
,rohertrag_ekmep_olk_4n_af_listungswochen
,rohertrag_ekmep_olk_4n_af_vj_listungswochen
,rohertrag_ekmep_olk_4n_sa_listungswochen
,rohertrag_ekmep_olk_4n_sa_vj_listungswochen
,td_insert
,td_update)
SELECT mandant_id
,(SELECT max(kjwo) from _woche_52) as kjwo_52
,${kjwo_update}
,matching_id
,SUM(anzahl_markt_wochen_kombis_abverkauf_af                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa                                  )
,SUM(anzahl_markt_wochen_kombis_abverkauf_af_vj                               )
,SUM(anzahl_markt_wochen_kombis_abverkauf_sa_vj                               )
,SUM(kassenumsatz_kl_absolut_brutto                                           )
,SUM(kassenumsatz_af_kl_absolut_brutto                                        )
,SUM(kassenumsatz_sa_kl_absolut_brutto                                        )
,SUM(kassenumsatz_kl_absolut_brutto_vj                                        )
,SUM(kassenumsatz_af_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_sa_kl_absolut_brutto_vj                                     )
,SUM(kassenumsatz_kl_absolut_netto                                            )
,SUM(kassenumsatz_af_kl_absolut_netto                                         )
,SUM(kassenumsatz_sa_kl_absolut_netto                                         )
,SUM(kassenumsatz_kl_absolut_netto_vj                                         )
,SUM(kassenumsatz_af_kl_absolut_netto_vj                                      )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj                                      )
,SUM(absatz_kl                                                                )
,SUM(absatz_af_kl                                                             )
,SUM(absatz_sa_kl                                                             )
,SUM(absatz_kl_vj                                                             )
,SUM(absatz_af_kl_vj                                                          )
,SUM(absatz_sa_kl_vj                                                          )
,SUM(absatz_sst1                                                              )
,SUM(absatz_sst2                                                              )
,SUM(absatz_sst3                                                              )
,SUM(absatz_sst4                                                              )
,SUM(absatz_sst5                                                              )
,SUM(absatz_sst6                                                              )
,SUM(absatz_sst7                                                              )
,SUM(absatz_ksst1                                                             )
,SUM(absatz_ksst2                                                             )
,SUM(absatz_ksst3                                                             )
,SUM(absatz_ksst4                                                             )
,SUM(absatz_ksst5                                                             )
,SUM(absatz_ksst6                                                             )
,SUM(absatz_ksst7                                                             )
,SUM(absatz_ost_basis                                                         )
,SUM(absatz_ost_gross                                                         )
,SUM(absatz_sued_ost                                                          )
,SUM(absatz_sued_west                                                         )
,SUM(absatz_west                                                              )
,SUM(absatz_nord                                                              )
,SUM(markt_wochen_sst1                                                        )
,SUM(markt_wochen_sst2                                                        )
,SUM(markt_wochen_sst3                                                        )
,SUM(markt_wochen_sst4                                                        )
,SUM(markt_wochen_sst5                                                        )
,SUM(markt_wochen_sst6                                                        )
,SUM(markt_wochen_sst7                                                        )
,SUM(markt_wochen_ksst1                                                       )
,SUM(markt_wochen_ksst2                                                       )
,SUM(markt_wochen_ksst3                                                       )
,SUM(markt_wochen_ksst4                                                       )
,SUM(markt_wochen_ksst5                                                       )
,SUM(markt_wochen_ksst6                                                       )
,SUM(markt_wochen_ksst7                                                       )
,SUM(markt_wochen_ost_basis                                                   )
,SUM(markt_wochen_ost_gross                                                   )
,SUM(markt_wochen_sued_ost                                                    )
,SUM(markt_wochen_sued_west                                                   )
,SUM(markt_wochen_west                                                        )
,SUM(markt_wochen_nord                                                        )
,SUM(anzahl_markt_wochen_kombis_abverkauf_mit_listung                         )
,SUM(anzahl_markt_wochen_kombis_listung                                       )
,SUM(rohertrag_ekmep_olk_4n                                                   )
,SUM(rohertrag_ekmep_olk_4n_vj                                                )
,SUM(rohertrag_ekmep_olk_4n_af                                                )
,SUM(rohertrag_ekmep_olk_4n_sa                                                )
,SUM(rohertrag_ekmep_olk_4n_af_vj                                             )
,SUM(rohertrag_ekmep_olk_4n_sa_vj                                             )
,SUM(totalabschriften_wert_netto_absolut                                      )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut                      )
,SUM(totalabschriften_wert_netto_absolut_vj                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_vj                   )
,SUM(kassenumsatz_kl_absolut_netto_wg                                         )
,SUM(totalabschriften_wert_netto_absolut_wg                                   )
,SUM(preisabschriften_preisanderungen_wert_netto_absolut_wg                   )
,SUM(absatz_af_kl_listungswochen                                              )
,SUM(absatz_af_kl_vj_listungswochen                                           )
,SUM(absatz_sa_kl_listungswochen                                              )
,SUM(absatz_sa_kl_vj_listungswochen                                           )
,SUM(kassenumsatz_af_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_af_kl_absolut_netto_vj_listungswochen                       )
,SUM(kassenumsatz_sa_kl_absolut_netto_listungswochen                          )
,SUM(kassenumsatz_sa_kl_absolut_netto_vj_listungswochen                       )
,SUM(rohertrag_ekmep_olk_4n_af_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_af_vj_listungswochen                              )
,SUM(rohertrag_ekmep_olk_4n_sa_listungswochen                                 )
,SUM(rohertrag_ekmep_olk_4n_sa_vj_listungswochen                              )
,MAX(current_timestamp)
,MAX(current_timestamp)
FROM dbp_data.tupel_kw
WHERE kjwo in (select kjwo from _woche_52 group by 1)
GROUP BY 1,2,3,4
;
