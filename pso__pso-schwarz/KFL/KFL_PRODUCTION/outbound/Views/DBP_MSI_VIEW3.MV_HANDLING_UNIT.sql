CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_handling_unit (mandant_id, system_id, nb_id, wup_id,
handling_unit_id, packmittel_typ, hu_gew_einh_id, hu_vol_einh_id, lagernummer_id, packmittelart_id, mat_gru_packmittel,
versandstelle_id, gewicht_ladung, gewicht_eigen, netto_vol_ladung, vol_eigen, versandeinheit_id, handling_unit_id_ext,
lief_beleg_id, anzahl_stellplatz, menge_gefahrgut, brtvol_ladung, brtgew_ladung, menge_handling_kolli_orig, hu_status_id
, hu_stellplatz_faktor, brtvol_ladung_gedeckelt, traegertyp_bez, kj_lief_beleg) AS SELECT mandant_id,
 system_id,
 nb_id,
 wup_id,
 handling_unit_id,
 packmittel_typ,
 hu_gew_einh_id,
 hu_vol_einh_id,
 lagernummer_id,
 packmittelart_id,
 mat_gru_packmittel,
 versandstelle_id,
 gewicht_ladung,
 gewicht_eigen,
 vol_ladung AS netto_vol_ladung,
 vol_eigen,
 versandeinheit_id,
 handling_unit_id_ext,
 lief_beleg_id,
  CASE
  WHEN versandeinheit_id IN (- 1, 1)
  THEN anzahl_stellplatz
  ELSE 0
  END AS anzahl_stellplatz,
 menge_gefahrgut,
 brtvol_ladung,
 brtgew_ladung,
 menge_handling_kolli_orig,
 hu_status_id,
 hu_stellplatz_faktor,
 brtvol_ladung_gedeckelt,
  CASE
  WHEN versandeinheit_id NOT IN (1, - 1)
  THEN 'AUFGEPACKT'
  WHEN versandeinheit_id = - 1
  THEN 'NORMAL'
  WHEN versandeinheit_id = 1
  THEN 'TRÄGER'
  ELSE NULL
  END AS traegertyp_bez,
 kj_lief_beleg
FROM kfl_production_dbp_view.v_handling_unit AS V01
WHERE kj_lief_beleg = - 1
 OR kj_lief_beleg >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;