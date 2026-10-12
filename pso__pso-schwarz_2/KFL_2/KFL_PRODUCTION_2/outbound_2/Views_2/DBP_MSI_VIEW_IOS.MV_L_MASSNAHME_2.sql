CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_massnahme_2 AS SELECT V01.massnahme_id,
 V01.massnahmenart_id,
 V02.massnahmenart_bez,
 V01.massnahme_akt_fg,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 10
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 30
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 40
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 50
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 70
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 90
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 110
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 130
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 150
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 170
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 190
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 210
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 230
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 260
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 290
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 320
  WHEN V01.massnahmenart_id = 999
  THEN 999
  ELSE NULL
  END AS massnahmen_gruppe_id,
  CASE
  WHEN V01.massnahmenart_id BETWEEN 10 AND 29
  THEN 'Expansion | Neubau'
  WHEN V01.massnahmenart_id BETWEEN 30 AND 39
  THEN 'Übernahme'
  WHEN V01.massnahmenart_id BETWEEN 40 AND 49
  THEN 'Filialma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 50 AND 69
  THEN 'Modernisierung'
  WHEN V01.massnahmenart_id BETWEEN 70 AND 89
  THEN 'Standortoptimierungsauftrag'
  WHEN V01.massnahmenart_id BETWEEN 90 AND 109
  THEN 'Reorga'
  WHEN V01.massnahmenart_id BETWEEN 110 AND 129
  THEN 'Schlie\u00dfung'
  WHEN V01.massnahmenart_id BETWEEN 130 AND 149
  THEN 'Marktgestaltung | Rückfilialisierung'
  WHEN V01.massnahmenart_id BETWEEN 150 AND 169
  THEN 'Sonstige Ma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 170 AND 189
  THEN 'Konzessionärsma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 190 AND 209
  THEN 'Gastroma\u00dfnahmen'
  WHEN V01.massnahmenart_id BETWEEN 210 AND 229
  THEN 'Instandsetzungen | Sanierungen'
  WHEN V01.massnahmenart_id BETWEEN 230 AND 259
  THEN 'Expansion | Neubau Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 260 AND 289
  THEN 'Standortoptimierungsauftrag Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 290 AND 319
  THEN 'Bauma\u00dfnahme Sonderbauten'
  WHEN V01.massnahmenart_id BETWEEN 320 AND 339
  THEN 'sonstige Ma\u00dfnahme Sonderbauten'
  WHEN V01.massnahmenart_id = 999
  THEN 'nicht zugeordnet'
  ELSE NULL
  END AS massnahmen_gruppe
FROM kfl_production_dbp_view.v_l_massnahme_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu_2 AS V02 ON V01.massnahmenart_id = V02.massnahmenart_id
 INNER JOIN kfl_production_dbp_view.v_l_massnahmenart_2 AS V03 ON V01.massnahmenart_id = V03.massnahmenart_id AND V02.spr_id
    = 22;