CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_wpufib_1 AS SELECT wup_id,
 mandant_id,
 dat_booking,
 zahlungsmittel_id,
 buchungsschluessel_id,
 aggr_nr,
 group_nr,
 record_nr,
 wrg_id,
 betrag
FROM kfl_production_dbp_ods.ods_wpufib_1;