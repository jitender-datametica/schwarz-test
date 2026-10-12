CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_kunde_auftrag_det_1 (mandant_id, verkaufs_beleg_id,
verkaufs_beleg_pos_id, in_art_id, werk_id, in_vw_id, verk_menge_einh_id, menge_auftrag_vme_kum, menge_bes_bme_kum,
menge_bes_bme_kum_kg, absagegrund_id, best_beleg_id_kunde, auftragsart_id, in_verkaufsorganisation_id, in_art_id_kunde,
wert_ek_netto, zwsum_2_betrag, zwsum_4_betrag, in_kunde_id, mandant_id_kunde) AS SELECT V01.mandant_id,
 V01.verkaufs_beleg_id,
 V01.verkaufs_beleg_pos_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 V02.flw_vw_id AS in_vw_id,
 V01.verk_menge_einh_id,
 V01.menge_auftrag_vme_kum,
 V01.menge_bes_bme_kum,
  CASE
  WHEN V05.basismenge_einh_id = 'KG'
  THEN V01.menge_bes_bme_kum
  WHEN V05.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V01.menge_bes_bme_kum * V06.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_bes_bme_kum_kg,
  CASE
  WHEN V01.absagegrund_id = ''
  THEN '-1'
  ELSE COALESCE(V01.absagegrund_id, '-1')
  END AS absagegrund_id,
 V02.best_beleg_id_kunde,
 V02.auftragsart_id,
 V02.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
 V01.sap_art_id_kunde AS in_art_id_kunde,
 V01.wert_ek_netto,
 V01.zwsum_2_betrag,
  V01.zwsum_4_betrag / (1 + V11.mwst / 100) AS zwsum_4_betrag,
 COALESCE(V03.flw_kunde_id, - 1) AS in_kunde_id,
 COALESCE(V03.mandant_id, V01.mandant_id) AS mandant_id_kunde
FROM kfl_production_dbp_view.v_flw_kunde_auftrag_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_auftrag_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.verkaufs_beleg_id
    = V02.verkaufs_beleg_id
 LEFT JOIN kfl_production_dbp_view.v_flw_besch_partner_1 AS V03 ON V01.verkaufs_beleg_id = V03.faktura_beleg_id AND V03.partner_verwendung_id
    = 'WE'
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.flw_art_id = V05.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.flw_art_id
     = V06.flw_art_id AND CASE
    WHEN V05.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V05.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V06.altnv_menge_einh_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V07 ON V05.art_id = V07.art_id AND V05.mandant_id = V07.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_mwst_per_1 AS V11 ON V07.mandant_id = V11.mandant_id AND V07.mwst_id = V11.mwst_id
  AND V02.dat_erstellung BETWEEN V11.dat_von AND V11.dat_bis;