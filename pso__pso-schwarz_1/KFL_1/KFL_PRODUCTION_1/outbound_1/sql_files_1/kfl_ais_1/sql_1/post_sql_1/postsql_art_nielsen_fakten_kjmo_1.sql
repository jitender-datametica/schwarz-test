/* INSERT INTO KFL_PRODUCTION.dbp_data.art_nielsen_fakten_kjwo_1 (mandant_id,
                                                            kjwo,
                                                            nielsen_market_id,
                                                            art_nielsen_id,
                                                            umsatz_brutto,
                                                            umsatz_brutto_af,
                                                            umsatz_brutto_sa,
                                                            menge,
                                                            menge_af,
                                                            menge_sa,
                                                            distr_num,
                                                            distr_gew,
                                                            anz_maerkte)
SELECT mandant_id,
       kjwo,
       nielsen_market_id,
       art_nielsen_id,
       SUM(umsatz_brutto) AS umsatz_brutto,
       SUM(umsatz_brutto_af) AS umsatz_brutto_af,
       SUM(umsatz_brutto_sa) AS umsatz_brutto_sa,
       SUM(menge) AS menge,
       SUM(menge_af) AS menge_af,
       SUM(menge_sa) AS menge_sa,
       AVG(distr_num) AS distr_num,
       AVG(distr_gew) AS distr_gew,
       SUM(anz_maerkte) AS anz_maerkte
FROM ${TEMP_TABLE}
GROUP BY 1,2,3,4
;
*/
