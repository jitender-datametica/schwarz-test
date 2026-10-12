CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_art_wup_autodispo_flw_tag_unfiltered_1
AS
-- 2021-02-01, AP0068964, nwag2310, additional view for status_1 dossier which could also be used in schema for future requirements
SELECT
v1.mandant_id,
v1.kunde_id AS wup_id,
--v1.wup_id AS fleischwerk_wup_id, 
v1.wup_id AS wup_id_fleischwerk,
v1.nb_id_kunde AS nb_id,
--v1.nb_id_lieferant AS vz_nb_id,
v1.nb_id_lieferant AS nb_id_vz,
v1.art_id,
v1.dat,
Coalesce(v1.we_bearbeitungszeit,-1) AS we_bearbeitungszeit,
Coalesce(v1.planlieferzeit,-1) AS planlieferzeit,
v1.kdis,
v1.verkaufslistung_fg,
v1.sa_af_fg AS sa_af_fg_id,
CASE
WHEN v1.sa_af_fg=0 THEN 'AF'
WHEN v1.sa_af_fg=1 THEN 'SA'
ELSE '--' END AS sa_af_fg,
udf_prognose_menge_gesteuert,
udf_prognose_menge_ungesteuert,
CASE
WHEN v1.sa_af_fg=0 THEN v1.udf_prognose_menge_gesteuert
ELSE 0 END AS udf_prognose_menge_gesteuert_af,
CASE
WHEN v1.sa_af_fg=1 THEN v1.udf_prognose_menge_gesteuert
ELSE 0 END AS udf_prognose_menge_gesteuert_sa,
CASE
WHEN v1.sa_af_fg=0 THEN v1.udf_prognose_menge_ungesteuert
ELSE 0 END AS udf_prognose_menge_ungesteuert_af,
CASE
WHEN v1.sa_af_fg=1 THEN v1.udf_prognose_menge_ungesteuert
ELSE 0 END AS udf_prognose_menge_ungesteuert_sa,
v1.fur_prognose_menge_ungesteuert,
v1.fur_prognose_menge_gesteuert,
v1.fur_prognose_menge_max,
--Abverkauf subject to change:
v1.menge_abverkauf,
CASE
WHEN v1.sa_af_fg=0 THEN v1.menge_abverkauf
ELSE 0 END AS menge_abverkauf_af,
CASE
WHEN v1.sa_af_fg=1 THEN v1.menge_abverkauf
ELSE 0 END AS menge_abverkauf_sa,
--Abverkauf
--Absolute Difference (for wMape calculation)
Abs(v1.menge_abverkauf - v1.fur_prognose_menge_ungesteuert) AS abs_diff_fur_ungesteuert,
CASE
WHEN v1.sa_af_fg=0 THEN Abs(v1.menge_abverkauf - v1.fur_prognose_menge_ungesteuert)
ELSE NULL END AS abs_diff_fur_ungesteuert_af,
CASE
WHEN v1.sa_af_fg=1 THEN Abs(v1.menge_abverkauf - v1.fur_prognose_menge_ungesteuert)
ELSE NULL END AS abs_diff_fur_ungesteuert_sa,
Abs(v1.menge_abverkauf - v1.fur_prognose_menge_gesteuert) AS abs_diff_fur_gesteuert,
CASE
WHEN v1.sa_af_fg=0 THEN Abs(v1.menge_abverkauf - v1.fur_prognose_menge_gesteuert)
ELSE NULL END AS abs_diff_fur_gesteuert_af,
CASE
WHEN v1.sa_af_fg=1 THEN Abs(v1.menge_abverkauf - v1.fur_prognose_menge_gesteuert)
ELSE NULL END AS abs_diff_fur_gesteuert_sa,
--Absolute Diff.
v1.ret_bestand,
v1.fur_bestand,
v1.menge_we_offen,
v1.menge_bv,
v1.menge_ofc,
Coalesce(v1.nullbestand_fg,-1) AS nullbestand_fg,
v1.menge_totalabschriften,
v1.menge_preisabschriften,
v1.kollifaktor,
v1.egalisierungsfaktor,
v1.menge_einh_id,
v1.servicelevel,
v1.optik,
v1.menge_we,
v1.nullbestand_exc_fg
FROM dbp_view.v_art_wup_autodispo_flw_tag_1 v1
;
