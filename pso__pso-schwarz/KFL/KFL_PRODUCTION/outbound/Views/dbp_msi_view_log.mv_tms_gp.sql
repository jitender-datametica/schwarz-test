CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tms_gp (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd,
tms_gp_lfd_nr, tms_gp_name_chg_fg, tms_gp_name, tms_gp_altnv_name, tms_gp_strasse, tms_gp_ort_name, tms_gp_plz,
tms_land_cd, sperr_fg, sammelbeleg_id, tms_standorttyp_id) AS SELECT T1.mandant_id,
 T1.system_id,
 T1.tms_gp_id,
 T1.tms_gp_typ_cd,
 T1.tms_gp_lfd_nr,
  CASE
  WHEN T1.tms_gp_name = '' AND t2.tms_gp_name IS NOT NULL
  THEN 1
  ELSE 0
  END AS tms_gp_name_chg_fg,
  CASE
  WHEN CASE
    WHEN T1.tms_gp_name = '' AND t2.tms_gp_name IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN t2.tms_gp_name
  ELSE T1.tms_gp_name
  END AS tms_gp_name,
 T1.tms_gp_altnv_name,
 T1.tms_gp_strasse,
 T1.tms_gp_ort_name,
 T1.tms_gp_plz,
 T1.tms_land_cd,
 T1.sperr_fg,
 T1.sammelbeleg_id,
 T1.tms_standorttyp_id
FROM kfl_production_dbp_view.v_tms_gp AS T1
 LEFT JOIN (SELECT mandant_id,
   system_id,
   tms_gp_id,
   MAX(tms_gp_name) AS tms_gp_name
  FROM kfl_production_dbp_view.v_tms_gp
  WHERE tms_gp_name <> ''
  GROUP BY mandant_id,
   system_id,
   tms_gp_id) AS t2 ON T1.mandant_id = t2.mandant_id AND T1.system_id = t2.system_id AND T1.tms_gp_id = t2.tms_gp_id;