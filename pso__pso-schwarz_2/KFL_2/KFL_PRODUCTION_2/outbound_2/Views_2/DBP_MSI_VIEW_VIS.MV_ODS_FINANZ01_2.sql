CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_finanz01_2 AS SELECT mandant_id,
 wup_id,
 fin_booking,
 buchungsart_id,
 buchungsschluessel_id,
 zahlungsmittel_id,
 beleg_lfd_nr,
 dat_booking,
 betrag,
 bemerkung2,
        EXTRACT(YEAR FROM fin_booking) * 10000000000000 + EXTRACT(MONTH FROM fin_booking) * 100000000000 + EXTRACT(DAY
        FROM fin_booking) * 1000000000 + EXTRACT(HOUR FROM fin_booking) * 10000000 + EXTRACT(MINUTE FROM fin_booking) *
     100000 + EXTRACT(SECOND FROM fin_booking) * 1000 + CAST(beleg_lfd_nr AS BIGNUMERIC) AS beleg_lfd_nr_id
FROM kfl_production_dbp_v_ods.v_ods_finanz01_2;