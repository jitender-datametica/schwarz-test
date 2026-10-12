CREATE OR REPLACE VIEW kfl_production_dbp_view.v_auslieferung_kopf AS SELECT mandant_id,
 beleg_guid,
 belegtyp_id,
 belegart_id,
 beleg_id,
 odo_typ_id,
 lief_pal_typ_akaf_id,
 anz_lt_geplant,
 anz_hu_geplant,
 akaf_anfragenummer,
 datzeit_erstellung,
 datzeit_aenderung
FROM kfl_production_dbp_data.auslieferung_kopf;