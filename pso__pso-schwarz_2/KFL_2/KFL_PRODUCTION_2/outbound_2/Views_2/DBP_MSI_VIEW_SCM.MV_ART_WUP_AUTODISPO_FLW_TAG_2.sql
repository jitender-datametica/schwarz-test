CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_autodispo_flw_tag_2 (mandant_id, wup_id,
wup_id_fleischwerk, nb_id, nb_id_vz, art_id, dat, kjwo, we_bearbeitungszeit, planlieferzeit, kdis, verkaufslistung_fg,
sa_af_fg, udf_prognose_menge_gesteuert, udf_prognose_menge_ungesteuert, udf_prognose_menge_gesteuert_af,
udf_prognose_menge_gesteuert_sa, udf_prognose_menge_ungesteuert_af, udf_prognose_menge_ungesteuert_sa,
fur_prognose_menge_ungesteuert, fur_prognose_menge_gesteuert, fur_prognose_menge_max, menge_abverkauf,
menge_abverkauf_af, menge_abverkauf_sa, abs_diff_fur_ungesteuert, abs_diff_fur_ungesteuert_af,
abs_diff_fur_ungesteuert_sa, abs_diff_fur_gesteuert, abs_diff_fur_gesteuert_af, abs_diff_fur_gesteuert_sa, ret_bestand,
fur_bestand, menge_we_offen, menge_bv, menge_ofc, nullbestand_fg, menge_totalabschriften, menge_preisabschriften,
kollifaktor, egalisierungsfaktor, menge_einh_id, servicelevel, optik, menge_we, temperatur_min, temperatur_max,
dauer_sonnenschein_perc, regenrisiko_perc, nullbestand_exc_fg, menge_we_geplant, display_art_id, komponentenmenge) AS
SELECT *
FROM kfl_production_dbp_msi_view_scm.mv_dt_art_wup_autodispo_flw_tag_2;