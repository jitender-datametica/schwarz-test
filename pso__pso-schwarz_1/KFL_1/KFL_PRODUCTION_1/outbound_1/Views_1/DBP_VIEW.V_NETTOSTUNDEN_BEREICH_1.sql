CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nettostunden_bereich_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 hr_objekt_bereich_id,
 stunden_1,
 quelle_id,
 stunden_typ_fg,
 dat_zeit_aenderung
FROM kfl_production_dbp_data.nettostunden_bereich_1;