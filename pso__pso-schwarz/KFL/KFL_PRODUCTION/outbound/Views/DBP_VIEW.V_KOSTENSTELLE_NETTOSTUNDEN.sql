CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kostenstelle_nettostunden AS SELECT mandant_id,
 wup_id,
 nb_id,
 krk_id,
 kostenstelle_id,
 hr_objekt_bez_kurz,
 dat,
 hr_objekt_bereich_id,
 stunden_netto,
 stunden_netto_plan,
 stunden_netto_markt_pep,
 quelle_id,
 planwert_quelle_id
FROM kfl_production_dbp_data.kostenstelle_nettostunden;