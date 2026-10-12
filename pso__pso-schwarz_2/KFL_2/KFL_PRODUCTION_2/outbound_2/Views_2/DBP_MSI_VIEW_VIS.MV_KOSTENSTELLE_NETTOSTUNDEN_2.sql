CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kostenstelle_nettostunden_2 AS SELECT mandant_id,
 nb_id,
 wup_id,
 krk_id,
 kostenstelle_id,
 hr_objekt_bez_kurz,
 hr_objekt_bereich_id,
 dat,
 stunden_netto,
 stunden_netto_plan,
 stunden_netto_markt_pep
FROM kfl_production_dbp_view.v_kostenstelle_nettostunden_2;