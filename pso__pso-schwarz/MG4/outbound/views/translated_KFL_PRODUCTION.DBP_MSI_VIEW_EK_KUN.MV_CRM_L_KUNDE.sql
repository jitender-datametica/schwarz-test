CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kunde (crm_kunde_id, dat_registrierung, dat_abmeldung
, kundentyp_id, kundenherkunft_id, gender_id, geburtsjahr, age, kunde_statusgrund_id, strasse, wohnort, plz,
kunde_mandant_id, vorzugsfiliale_wup_id, akt_vorzugsfiliale_wup_id, vorzugsfiliale_mandant_id, nb_id, merge_fg,
registrierungsfiliale_wup_id, akt_registrierungsfiliale_wup_id, registrierungsfiliale_mandant_id,
registrierungsfiliale_nb_id, mandant_kbez) AS SELECT v01.crm_kunde_id,
 DATE(v01.zeit_registrierung) AS dat_registrierung,
 DATE(v01.zeit_abmeldung) AS dat_abmeldung,
 v01.kundentyp_id,
 v01.kundenherkunft_id,
 v01.gender_id,
 v01.geburtsjahr,
  EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - v01.geburtsjahr AS age,
 v01.kunde_statusgrund_id,
 v01.strasse,
 v01.wohnort,
 v01.plz,
 v01.kunde_mandant_id,
 v01.vorzugsfiliale_wup_id,
 v04.aktuell_wup_id AS akt_vorzugsfiliale_wup_id,
 v01.vorzugsfiliale_mandant_id,
 v01.nb_id,
 v01.merge_fg,
 v01.registrierungsfiliale_wup_id,
 v03.aktuell_wup_id AS akt_registrierungsfiliale_wup_id,
 v01.registrierungsfiliale_mandant_id,
 v01.registrierungsfiliale_nb_id,
 v02.mandant_kbez
FROM kfl_production_dbp_view.v_crm_l_kunde AS v01
 INNER JOIN kfl_production_dbp_view.v_mandant AS v02 ON v01.kunde_mandant_id = v02.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_ek_kun.mv_wup AS v03 ON v01.registrierungsfiliale_mandant_id = v03.mandant_id
   AND v01.registrierungsfiliale_wup_id = v03.wup_id AND v01.registrierungsfiliale_nb_id = v03.nb_id
 INNER JOIN kfl_production_dbp_msi_view_ek_kun.mv_wup AS v04 ON v01.vorzugsfiliale_mandant_id = v04.mandant_id AND v01.vorzugsfiliale_wup_id
     = v04.wup_id AND v01.nb_id = v04.nb_id;