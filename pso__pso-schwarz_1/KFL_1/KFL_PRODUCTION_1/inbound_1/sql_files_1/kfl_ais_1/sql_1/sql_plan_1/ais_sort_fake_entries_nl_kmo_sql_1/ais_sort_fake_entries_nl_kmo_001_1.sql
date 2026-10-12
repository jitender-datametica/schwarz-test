--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_nielsen_fakten_kjmo_1 (mandant_id,
                                                            kjmo,
                                                            nielsen_market_id,
                                                            art_nielsen_id,
                                                            wrg_id,
                                                            umsatz_brutto,
                                                            umsatz_brutto_af,
                                                            umsatz_brutto_sa,
                                                            menge,
                                                            menge_af,
                                                            menge_sa,
                                                            distr_num,
                                                            distr_gew,
                                                            anz_maerkte)
SELECT ${mandant_id},
       a.kjmo_sort AS kjmo,
       3 AS nielsen_market_id,
       -9999999 AS art_nielsen_id,
       b.default_wrg AS wrg_id,
       0 AS umsatz_brutto,
       0 AS umsatz_brutto_af,
       0 AS umsatz_brutto_sa,
       0 AS menge,
       0 AS menge_af,
       0 AS menge_sa,
       0 AS distr_num,
       0 AS distr_gew,
       0 AS anz_maerkte
FROM DBP_ETL_PROCESS.sort_monat_woche_1 a
CROSS JOIN DBP_DATA.mandant_1 b
WHERE a.kjmo_sort IN (SELECT kjmo FROM DBP_DATA.monat_1 WHERE akt_mo IN (SELECT MIN(akt_mo)-1 FROM DBP_DATA.tag_1 WHERE akt_wo = -1))
AND b.mandant_id = ${mandant_id}
AND a.kjmo_sort NOT IN (SELECT kjmo FROM DBP_DATA.art_nielsen_fakten_kjmo_1 WHERE mandant_id = ${mandant_id});

