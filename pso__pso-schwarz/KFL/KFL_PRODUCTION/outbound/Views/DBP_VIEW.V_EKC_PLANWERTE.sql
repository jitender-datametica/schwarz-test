CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ekc_planwerte AS SELECT mandant_id,
 hwg_id,
 arthiertyp_id,
 dat,
 wrg_id,
 abschriftsbetrag_werbung_netto,
 umsatz_netto_sa,
 umsatz_netto_af,
 abschriftsbetrag_ohne_werbung_netto,
 wa_kalk_netto,
 wa_kalk_netto_af,
 wa_kalk_netto_sa
FROM kfl_production_dbp_data.ekc_planwerte;