CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_FINANZ01_2
AS
  /* SELECT
   mandant_id, wup_id, fin_booking, buchungsart_id, buchungsschluessel_id, zahlungsmittel_id, beleg_lfd_nr, dat_booking, betrag, bemerkung2, ((fin_booking::DATE) *1000000000::BIGINT)
   + (EXTRACT (HOUR FROM fin_booking) * 10000000)
   + (EXTRACT (MINUTE FROM fin_booking) * 100000)
   + (EXTRACT (SECOND FROM fin_booking) * 1000)
   + beleg_lfd_nr::BIGINT  AS beleg_lfd_nr_id
   FROM dbp_v_ods.v_ods_finanz01_2;
   */
    SELECT
   mandant_id, wup_id, fin_booking, buchungsart_id, buchungsschluessel_id, zahlungsmittel_id, beleg_lfd_nr, dat_booking, betrag, bemerkung2  , (extract (year from fin_booking)* 10000000000000)
    +(extract (month from fin_booking)* 100000000000)
    +(extract (day from fin_booking)* 1000000000)
    +(EXTRACT (HOUR FROM fin_booking)* 10000000)
    +(EXTRACT (MINUTE FROM fin_booking)* 100000)
    +(EXTRACT (SECOND FROM fin_booking)* 1000)
   + beleg_lfd_nr::BIGINT  AS beleg_lfd_nr_id
    FROM dbp_v_ods.v_ods_finanz01_2;