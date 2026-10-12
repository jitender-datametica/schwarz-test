CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_verrechfall_2 (mandant_id, verrechfall_id,
belos_vorgang_id, verrechfallart_id, belos_adresse_empfaenger_id, wrg_id, storno_fg, betrag_pauschalfracht,
betrag_fracht, verrechfall_status_id, belos_leistungsart_id, kunde_fg, fracht_satz_prz, fracht_satz_prz_pro_einh,
belos_adresse_rechnung_id, belos_adresse_steuerung_id) AS SELECT mandant_id,
 verrechfall_id,
 belos_vorgang_id,
 verrechfallart_id,
 belos_adresse_empfaenger_id,
 wrg_id,
 storno_fg,
 betrag_pauschalfracht,
 betrag_fracht,
 verrechfall_status_id,
 belos_leistungsart_id,
 kunde_fg,
 fracht_satz_prz,
 fracht_satz_prz_pro_einh,
 belos_adresse_rechnung_id,
 belos_adresse_steuerung_id
FROM kfl_production_dbp_view.v_verrechfall_2
WHERE belosart_fg = 0
  -- Berücksichtigt werden nur Verrechnungsfälle im Status_2 ""verrechnet"" (BC150), ""abgeglichen"" (BC151)und ""abgeschlossen"" (BC160)

  -- 01.07.10: für KW37 Anforderung 262654 auskommentiert
 -- verrechfall_status_id IN ('BC150', 'BC151', 'BC160')

  -- Eingeschränkt auf die Daten der Beschaffungslogistik;