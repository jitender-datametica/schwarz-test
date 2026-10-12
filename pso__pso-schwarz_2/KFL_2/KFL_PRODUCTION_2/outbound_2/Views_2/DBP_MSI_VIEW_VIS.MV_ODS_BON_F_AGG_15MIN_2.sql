CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_agg_15min_2 (dat, zeit_stunde, zeit_15min, wup_id,
mandant_id, kasse_nr, wrg_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, bonanzahl_sug_okf, kassierzeit,
registrierzeit, zahlzeit, anz_zeilenstorno, umsatz_brutto_zeilenstorno, umsatz_netto_zeilenstorno, anz_bonstorno,
umsatz_brutto_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_brutto_bonabbruch, umsatz_netto_bonabbruch,
anz_bon_zeilenstorno, anz_bonabbruch_suspended, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan, anz_bon_kscan,
anz_zeilen_kscan) AS SELECT V01.dat,
 V01.zeit_stunde,
 V01.zeit_15min,
 WUP.aktuell_wup_id AS wup_id,
 V01.mandant_id,
 V01.kasse_nr,
 krs.nach_wrg_id AS wrg_id,
  V01.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
  V01.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
 V01.anz_artikel,
 V01.anz_kunden,
 V01.bonanzahl_sug_okf,
 V01.kassierzeit,
 V01.registrierzeit,
 V01.zahlzeit,
 V01.anz_zeilenstorno,
  V01.umsatz_brutto_zeilenstorno * krs.umrechnungskurs AS umsatz_brutto_zeilenstorno,
  V01.umsatz_netto_zeilenstorno * krs.umrechnungskurs AS umsatz_netto_zeilenstorno,
 V01.anz_bonstorno,
  V01.umsatz_brutto_bonstorno * krs.umrechnungskurs AS umsatz_brutto_bonstorno,
  V01.umsatz_netto_bonstorno * krs.umrechnungskurs AS umsatz_netto_bonstorno,
 V01.anz_bonabbruch,
  V01.umsatz_brutto_bonabbruch * krs.umrechnungskurs AS umsatz_brutto_bonabbruch,
  V01.umsatz_netto_bonabbruch * krs.umrechnungskurs AS umsatz_netto_bonabbruch,
 V01.anz_bon_zeilenstorno,
 V01.anz_bonabbruch_suspended,
  V01.umsatz_netto_bonabbruch_suspended * krs.umrechnungskurs AS umsatz_netto_bonabbruch_suspended,
  V01.umsatz_netto_kscan * krs.umrechnungskurs AS umsatz_netto_kscan,
 V01.anz_bon_kscan,
 V01.anz_zeilen_kscan
FROM kfl_production_dbp_v_ods.v_ods_bon_agg_15min_2 AS V01
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;