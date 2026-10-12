CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_de_pruefung_2 AS SELECT pruefung_id,
 pruefung_nr,
 zustand_id,
 pruefung_bez,
 dat_start,
 dat_ende,
 revisor_id,
 pruefung_typ_id,
 pruefung_klasse_id,
 pruefung_ergebnis_wert,
 business_unit_id,
 mandant_id,
 wup_id
FROM kfl_production_dbp_data.amx_de_pruefung_2;