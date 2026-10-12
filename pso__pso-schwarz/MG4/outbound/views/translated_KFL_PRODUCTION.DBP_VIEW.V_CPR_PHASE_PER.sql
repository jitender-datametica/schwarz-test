CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_phase_per (projekt_phase_id, dat_von, dat_bis, projekt_id,
cpr_ext_id, dat_freigabe, einzel_massnahme, teil_massnahme_id, teil_massn_kz, cpr_systemstatus1_id, cpr_systemstatus2_id
, cpr_systemstatus3_id, phasenart_id, cpr_suchfeld_id, cpr_phase_version_id, cpr_phase_version_dat, td_update, td_insert
) AS SELECT projekt_phase_id,
 dat_von,
 dat_bis,
 projekt_id,
 cpr_ext_id,
 dat_freigabe,
 einzel_massnahme,
 teil_massnahme_id,
 teil_massn_kz,
 cpr_systemstatus1_id,
 cpr_systemstatus2_id,
 cpr_systemstatus3_id,
 phasenart_id,
 cpr_suchfeld_id,
 cpr_phase_version_id,
 cpr_phase_version_dat,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_phase_per;