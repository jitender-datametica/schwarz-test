CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_rpm_fin_planung (dat_von, rpm_hierarchie_id,
fin_kat_hierarchie_id, fin_kategorie_id, fin_kat_version_id, fin_kat_version_dat, fin_gruppe_hierarchie_id,
fin_gruppe_id, rpm_plantyp_id, fin_gruppe_version_id, fin_gruppe_version_dat, dat_start, maxkp_fg, betrag, projekt_nr,
projekt_id) AS SELECT V01.dat_von,
 V01.rpm_hierarchie_id,
 V01.fin_kat_hierarchie_id,
 V01.fin_kategorie_id,
 V01.fin_kat_version_id,
 V01.fin_kat_version_dat,
 V01.fin_gruppe_hierarchie_id,
 V01.fin_gruppe_id,
 V01.rpm_plantyp_id,
 V01.fin_gruppe_version_id,
 V01.fin_gruppe_version_dat,
 V01.dat_start,
 V01.maxkp_fg,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.betrag, 0)
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.betrag, 0) * V01.umrechnungskurs
   ELSE NULL
   END AS NUMERIC) AS betrag,
 V01.projekt_nr,
 V01.projekt_id
FROM dbp_msi_view_ios_materialized.tbl_mv_rpm_fin_planung AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE;