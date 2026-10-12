CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_bericht_2 AS SELECT fipo_bericht_id,
 fipo_pruef_objekt_id,
 fipo_pruef_modul_id,
 dat_fipo_bericht,
 mobil_erfasst_fg,
 nicht_auswerten_fg,
 fipo_person_id,
 dat_bis,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_fipo_bericht AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_fipo_bericht,
 fipo_bericht_text,
 dat_versorgung
FROM kfl_production_dbp_data.fipo_bericht_2;