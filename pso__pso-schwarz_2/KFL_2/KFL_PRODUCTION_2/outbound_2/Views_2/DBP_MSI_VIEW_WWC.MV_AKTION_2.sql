CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_aktion_2 (aktion_id, dat_von, dat_bis, mandant_id, dat_zeitraum
, kjwo_von) AS SELECT aktion_id,
 dat_von,
 dat_bis,
 mandant_id,
   CAST(dat_von AS STRING) || ' - ' || CAST(dat_bis AS STRING) AS dat_zeitraum,
 kjwo_von
FROM kfl_production_dbp_view.v_aktion_2 AS V01
UNION ALL
SELECT SUBSTR('          ', 1, 10) AS aktion_id,
 PARSE_DATE('%F', '1900-01-01') AS dat_von,
 PARSE_DATE('%F', '9999-12-31') AS dat_bis,
 mandant_id,
   CAST(PARSE_DATE('%F', '1900-01-01') AS STRING) || ' - ' || CAST(PARSE_DATE('%F', '9999-12-31') AS STRING) AS
 dat_zeitraum,
 190001 AS kjwo_von
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id <> 1
UNION ALL
SELECT SUBSTR('-1        ', 1, 10) AS aktion_id,
 PARSE_DATE('%F', '1900-01-01') AS dat_von,
 PARSE_DATE('%F', '9999-12-31') AS dat_bis,
 mandant_id,
   CAST(PARSE_DATE('%F', '1900-01-01') AS STRING) || ' - ' || CAST(PARSE_DATE('%F', '9999-12-31') AS STRING) AS
 dat_zeitraum,
 190001 AS kjwo_von
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id <> 1;