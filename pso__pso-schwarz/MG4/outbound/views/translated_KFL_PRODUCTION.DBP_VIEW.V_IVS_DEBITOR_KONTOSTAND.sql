CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_debitor_kontostand (debitor_id, abzug_id, mandant_id, kjmo,
mietvertrag_id, wup_id, buchungskreis_id, wrg_id, sonderhauptbuch_id, summe_soll, summe_haben, saldo_vortrag, saldo_soll
, saldo_haben, saldo_konto) AS SELECT debitor_id,
 abzug_id,
 mandant_id,
 kjmo,
 mietvertrag_id,
 wup_id,
 buchungskreis_id,
 wrg_id,
 sonderhauptbuch_id,
 summe_soll,
 summe_haben,
 saldo_vortrag,
 saldo_soll,
 saldo_haben,
 saldo_konto
FROM kfl_production_dbp_data.ivs_debitor_kontostand;