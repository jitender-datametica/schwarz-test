CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_rpm_fin_planung_2 AS SELECT V01.dat_von,
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
   END AS NUMERIC) AS betrag
FROM kfl_production_dbp_msi_view_ims.tbl_mv_rpm_fin_planung_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE;