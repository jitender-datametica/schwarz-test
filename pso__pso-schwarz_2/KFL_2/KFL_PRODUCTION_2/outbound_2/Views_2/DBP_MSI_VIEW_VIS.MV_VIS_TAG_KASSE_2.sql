CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse_2 (mandant_id, nb_id, wup_id, dat, kasse_nr,
anz_artikel, registrierzeit, kassiervorgangszeit, kassierzeit, anz_kunden, umsatz_netto, wrg_id, anz_zeilenstorno,
umsatz_netto_zeilenstorno, anz_bonstorno, umsatz_netto_bonstorno, anz_bonabbruch, umsatz_netto_bonabbruch,
anz_bon_zeilenstorno, anz_bonabbruch_suspended, umsatz_netto_bonabbruch_suspended, umsatz_netto_kscan, anz_bon_kscan,
anz_zeilen_kscan) AS SELECT VTK.mandant_id,
 VTK.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 VTK.dat,
 VTK.kasse_nr,
 VTK.anz_artikel,
 VTK.registrierzeit,
 VTK.kassiervorgangszeit,
 VTK.kassierzeit,
 VTK.anz_kunden,
  VTK.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
 krs.nach_wrg_id AS wrg_id,
 VTK.anz_zeilenstorno,
  VTK.umsatz_netto_zeilenstorno * krs.umrechnungskurs AS umsatz_netto_zeilenstorno,
 VTK.anz_bonstorno,
  VTK.umsatz_netto_bonstorno * krs.umrechnungskurs AS umsatz_netto_bonstorno,
 VTK.anz_bonabbruch,
  VTK.umsatz_netto_bonabbruch * krs.umrechnungskurs AS umsatz_netto_bonabbruch,
 VTK.anz_bon_zeilenstorno,
 VTK.anz_bonabbruch_suspended,
  VTK.umsatz_netto_bonabbruch_suspended * krs.umrechnungskurs AS umsatz_netto_bonabbruch_suspended,
  VTK.umsatz_netto_kscan * krs.umrechnungskurs AS umsatz_netto_kscan,
 VTK.anz_bon_kscan,
 VTK.anz_zeilen_kscan
FROM kfl_production_dbp_view.v_vis_tag_kasse_2 AS VTK
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON VTK.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON VTK.mandant_id = WUP.mandant_id AND VTK.wup_id = WUP.wup_id;