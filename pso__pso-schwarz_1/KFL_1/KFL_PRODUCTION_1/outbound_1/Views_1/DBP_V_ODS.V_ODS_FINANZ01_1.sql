CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_finanz01_1 AS SELECT mandant_id,
 wup_id,
 fin_booking,
 buchungsart_id,
 buchungsschluessel_id,
 zahlungsmittel_id,
 beleg_lfd_nr,
 dat_booking,
 betrag,
 bemerkung2
FROM kfl_production_dbp_ods.ods_finanz01_1;