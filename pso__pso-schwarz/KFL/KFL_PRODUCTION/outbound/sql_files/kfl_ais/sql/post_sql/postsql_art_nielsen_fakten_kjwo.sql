--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied




INSERT INTO dbp_data.art_nielsen_fakten_kjwo (mandant_id, kjwo, nielsen_market_id, art_nielsen_id,
 umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa, distr_num, distr_gew, anz_maerkte,
 distr_num_4_wo, distr_gew_4_wo)
(SELECT mandant_id,
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
  SUM(anz_maerkte) AS anz_maerkte,
  AVG(distr_num_4_wo) AS distr_num_4_wo,
  AVG(distr_gew_4_wo) AS distr_gew_4_wo
 FROM ${TEMP_TABLE}
  
 GROUP BY mandant_id,
  kjwo,
  nielsen_market_id,
  art_nielsen_id);