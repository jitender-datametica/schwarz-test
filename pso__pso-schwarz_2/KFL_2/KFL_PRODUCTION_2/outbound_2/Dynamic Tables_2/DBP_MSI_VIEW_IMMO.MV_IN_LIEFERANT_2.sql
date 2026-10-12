CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_in_lieferant_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_lief_id AS in_lief_id,
  mandant_id AS mandant_id,
  lief_name_1 AS lief_name_1,
  lief_name_2 AS lief_name_2,
  gp_ort AS gp_ort,
  gp_plz AS gp_plz,
  in_lief_nr AS in_lief_nr,
  mandant_id_werk AS mandant_id_werk,
  system_id AS system_id,
  loesch_fg AS loesch_fg,
  in_lief_id_int AS in_lief_id_int,
  subkategorie_1_id AS subkategorie_1_id,
  konzern_id AS konzern_id,
  werk_id AS werk_id,
  bis_relevant_fg AS bis_relevant_fg
FROM kfl_production_dbp_view.v_in_lieferant_2;
