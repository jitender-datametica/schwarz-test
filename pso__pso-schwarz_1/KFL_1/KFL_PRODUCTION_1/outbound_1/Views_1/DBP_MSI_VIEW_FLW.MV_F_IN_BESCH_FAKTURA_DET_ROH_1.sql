CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_besch_faktura_det_roh_1 (faktura_beleg_id,
faktura_beleg_pos_id, mandant_id, dat_faktura, werk_id, lief_pos_typ_id, in_art_id, vorlage_beleg_id, wrg_id,
menge_faktura_vkme, menge_faktura_lme, verk_menge_faktura_einh_id, gewicht_netto_roh, wert_ek_netto_roh,
dat_preisfindung) AS SELECT V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.mandant_id,
 V01.dat_faktura,
 V01.werk_id,
 V01.lief_pos_typ_id,
 V01.in_art_id,
 V01.vorlage_beleg_id,
 V400.wrg_id,
 V01.menge_faktura_vkme,
 V01.menge_faktura_lme,
 V01.verk_menge_faktura_einh_id,
 V01.gewicht_netto_roh,
 MAX(CAST(CASE
     WHEN V01.wrg_id_v02 <> V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.wert_ek_netto_v02
     WHEN V01.wrg_id_v02 <> V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.wert_ek_netto_v02 / V500.umrechnungskurs
     WHEN V01.wrg_id_v02 = V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.wert_ek_netto_v02 * V500.umrechnungskurs
     WHEN V01.wrg_id_v02 = V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.wert_ek_netto_v02
     ELSE 0
     END AS NUMERIC) * V01.vorzeichen_preise) AS wert_ek_netto_roh,
 V01.dat_preisfindung
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_faktura_det_roh_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.default_wrg = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_preisfindung BETWEEN V500.dat_von AND V500.dat_bis
GROUP BY V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.mandant_id,
 V01.dat_faktura,
 V01.werk_id,
 V01.lief_pos_typ_id,
 V01.in_art_id,
 V01.vorlage_beleg_id,
 V400.wrg_id,
 V01.menge_faktura_vkme,
 V01.menge_faktura_lme,
 V01.verk_menge_faktura_einh_id,
 V01.gewicht_netto_roh,
 V01.dat_preisfindung;