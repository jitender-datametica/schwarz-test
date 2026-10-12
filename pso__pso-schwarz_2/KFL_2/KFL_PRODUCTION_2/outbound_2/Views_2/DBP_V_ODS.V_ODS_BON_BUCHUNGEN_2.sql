CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_buchungen_2 AS SELECT bon_id,
 bon_zeile,
 buchungsschluessel_id,
 wup_id,
 mandant_id,
 kpos_zahlung_typ_id,
 dat_booking,
 bon_dat,
 start_bon_zeile,
 kasse_nr,
 bon_nr,
 betrag_buchung,
 kommentar_buchung
FROM kfl_production_dbp_ods.ods_bon_buchungen_2;