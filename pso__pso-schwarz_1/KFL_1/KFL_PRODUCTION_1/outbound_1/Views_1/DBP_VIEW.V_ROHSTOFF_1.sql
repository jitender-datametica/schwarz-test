CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_1 (rohstoff_nr
OPTIONS(description='Mintecs Interne ID des Rohstoffs.'), rohstoff_basis_einh_name
OPTIONS(description='Die Basiseinheit des Rohstoffs (native).'), rohstoff_bez
OPTIONS(description='Bezeichnung des Rohstoffs.'), rohstoff_kfl_bez
OPTIONS(description='Kaufland interne Bezeichnung des Rohstoffs.'), rohstoff_beschreibung_txt
OPTIONS(description='Beschreibung des Rohstoffs.'), rohstoff_qualitaet_txt
OPTIONS(description='Beschreibung der Qualität des Rohstoffs.'), rohstoff_herkunftsort_name
OPTIONS(description='Herkunfsort des Rohstoffs - Dieser kann Land_1, Region_1 oder Länderguppe sein.'),
rohstoff_lieferort_name OPTIONS(description='Land_1, Region_1 oder Ländergruppe, die den Rohstof fliefert.'),
rohstoff_quell_bez OPTIONS(description='Enthält Informationen zur Quelle des Rohstoffes.'))
OPTIONS(DESCRIPTION = `DIESE TABELLE ENTHÄLT INFORMATIONEN ÜBER DIE ROHSTOFFE VERWENDET BEI KAUFLAND.`) AS SELECT
 rohstoff_nr,
 rohstoff_basis_einh_name,
 rohstoff_bez,
 rohstoff_kfl_bez,
 rohstoff_beschreibung_txt,
 rohstoff_qualitaet_txt,
 rohstoff_herkunftsort_name,
 rohstoff_lieferort_name,
 rohstoff_quell_bez
FROM kfl_production_dbp_data.rohstoff_1;