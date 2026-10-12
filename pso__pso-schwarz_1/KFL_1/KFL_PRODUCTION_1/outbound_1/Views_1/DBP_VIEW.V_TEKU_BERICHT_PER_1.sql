CREATE OR REPLACE VIEW kfl_production_dbp_view.v_teku_bericht_per_1 AS SELECT teku_bericht_id,
 dat_von,
 dat_bis,
 dat_besuchs_beginn,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_besuchs_beginn AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_besuchs_beginn,
 dat_besuchs_ende,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_besuchs_ende AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT
    '000000'))) AS zeit_besuchs_ende,
 mandant_id,
 wup_id,
 teku_checkliste_id,
 testkunde_id,
 loeschung_fg,
 nicht_auswerten_fg,
 dat_erfasst
FROM kfl_production_dbp_data.teku_bericht_per_1;