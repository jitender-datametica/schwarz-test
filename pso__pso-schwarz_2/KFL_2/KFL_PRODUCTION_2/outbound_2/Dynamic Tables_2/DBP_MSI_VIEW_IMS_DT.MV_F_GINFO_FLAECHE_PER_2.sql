CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_f_ginfo_flaeche_per_2 (
  mandant_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  techn_platz_id STRING(30),
  ginfo_flaeche_id STRING(50),
  ginfo_flaeche_typ_id STRING(50),
  ginfo_flaeche_netto NUMERIC(18, 2),
  ginfo_flaeche_brutto NUMERIC(18, 2),
  ginfo_achse_wert NUMERIC(18, 3),
  ginfo_achse_typ_id STRING(10)
) AS
SELECT
  wp.mandant_id AS mandant_id,
  wp.nb_id AS nb_id,
  wp.wup_id AS wup_id,
  tpl.techn_platz_id AS techn_platz_id,
  flp.ginfo_flaeche_id AS ginfo_flaeche_id,
  flp.ginfo_flaeche_typ_id AS ginfo_flaeche_typ_id,
  flp.ginfo_flaeche_netto AS ginfo_flaeche_netto,
  flp.ginfo_flaeche_brutto AS ginfo_flaeche_brutto,
  flp.ginfo_achse_wert AS ginfo_achse_wert,
  flp.ginfo_achse_typ_id AS ginfo_achse_typ_id
FROM (
  SELECT
    mandant_id,
    nb_id,
    wup_id
  FROM kfl_production_dbp_view.v_wup_2
) AS wp
LEFT JOIN (
  SELECT
    mandant_id,
    techn_platz_id,
    wup_id
  FROM kfl_production_dbp_view.v_techn_platz_per_2
  WHERE
    techn_platz_ebene_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE)
) AS tpl
  ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS flp
  ON tpl.techn_platz_id = flp.techn_platz_id
  AND CURRENT_DATE BETWEEN flp.dat_von AND flp.dat_bis;
