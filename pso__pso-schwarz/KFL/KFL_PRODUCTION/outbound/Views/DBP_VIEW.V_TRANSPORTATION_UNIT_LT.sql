CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_lt (mandant_id
OPTIONS(description='Mandant im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'), beleg_id
OPTIONS(description='Beleg-ID'), at_guid OPTIONS(description='Produkt'), menge_defekt_tortausch
OPTIONS(description='Number of defective load carriers from direct exchange'), menge_gesamt
OPTIONS(description='Gesamtmenge'), menge_gesamt_tortausch
OPTIONS(description='Total number of Loading Carriers from Direct Exchange'), menge_einh_id
OPTIONS(description='Mengeneinheit'), datzeit_erstelliung
OPTIONS(description='UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '))
OPTIONS(DESCRIPTION = `ERMITTELTE GREENFIELD TORE`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 beleg_id,
 at_guid,
 menge_defekt_tortausch,
 menge_gesamt,
 menge_gesamt_tortausch,
 menge_einh_id,
 datzeit_erstelliung
FROM kfl_production_dbp_data.transportation_unit_lt;