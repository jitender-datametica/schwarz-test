CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_branche_vorgabe_1 AS SELECT BV.mandant_id,
 BV.miet_region_id,
 BV.bl_id,
 BV.branche_id,
 BV.konzessionaer_id,
 BV.kaufland_baecker_fg,
 BV.flaeche_groesse_von,
 BV.flaeche_groesse_bis,
 BV.kunden_anzahl_von,
 BV.kunden_anzahl_bis,
 BV.branche_mix,
 BV.vorgabe_prozent,
  BV.vorgabe_betrag * KURS.kurs_1 AS vorgabe_betrag,
  BV.vorgabe_prodvt * KURS.kurs_1 AS vorgabe_prodvt,
  BV.vorgabe_miete * KURS.kurs_1 AS vorgabe_miete,
 BV.vorgabe_achsen_abschnitt,
 BV.vorgabe_steigung,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_branche_vorgabe_1 AS BV
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1 AS KURS_1 ON BV.mandant_id = KURS.mandant_id AND
   KURS.kurs_dat_bis = DATE '9999-12-31';