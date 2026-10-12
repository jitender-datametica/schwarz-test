CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_in_psp_element_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
	psp_id,
	psp_id_char,
	psp_bez,
	pc_id,
	krk_id,
	buchungskreis_id,
	geschaeftsbereich_id,
	dat_erfasst,
	techn_platz_id,
	dat_aenderung,
	in_projekt_id,
	statistisch_fg,
	benutzerfeld_1,
	benutzerfeld_2,
	benutzerfeld_4,
	dat_abschluss,
	psp_end_nr,
	gewerk_id,
	plan_aktivierungs_quote
FROM kfl_production_dbp_view.v_in_psp_element_2;