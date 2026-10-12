CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_bericht_1 AS SELECT V01.fipo_bericht_id,
 V01.fipo_pruef_modul_id,
  CASE
  WHEN V02.mandant_id = 1 AND V01.fipo_pruef_modul_id = 21300
  THEN 1
  ELSE 0
  END AS gfk_flag,
  CASE
  WHEN CASE
    WHEN V02.mandant_id = 1 AND V01.fipo_pruef_modul_id = 21300
    THEN 1
    ELSE 0
    END = 1
  THEN DATE_ADD(DATE_SUB(V01.dat_fipo_bericht, INTERVAL EXTRACT(DAYOFWEEK FROM V01.dat_fipo_bericht) - 1 DAY),
   INTERVAL 9 DAY)
  ELSE V01.dat_fipo_bericht
  END AS dat_fipo_bericht,
  CASE
  WHEN CASE
    WHEN V02.mandant_id = 1 AND V01.fipo_pruef_modul_id = 21300
    THEN 1
    ELSE 0
    END = 1
  THEN CAST(TRIM(SUBSTR('00:00:00', 1, 8)) AS TIME)
  ELSE CAST(TRIM(FORMAT_TIME('%H:%M:%S', V01.zeit_fipo_bericht)) AS TIME)
  END AS zeit_fipo_bericht,
 V01.mobil_erfasst_fg,
 V01.nicht_auswerten_fg,
 V01.fipo_person_id,
 V01.dat_bis,
 V02.mandant_id,
  CASE
  WHEN CASE
    WHEN V02.mandant_id = 1 AND V01.fipo_pruef_modul_id = 21300
    THEN 1
    ELSE 0
    END = 1
  THEN V04.wup_id
  ELSE V02.wup_id
  END AS wup_id,
 COALESCE(V03.hausleiter_sperr_fg, 0) AS hausleiter_sperr_fg,
 COALESCE(V03.vkl_sperr_fg, 0) AS vkl_sperr_fg,
 COALESCE(V03.gf_gbl_vertrieb_sperr_fg, 0) AS gf_gbl_vertrieb_sperr_fg,
  CASE
  WHEN CASE
    WHEN V02.mandant_id = 1 AND V01.fipo_pruef_modul_id = 21300
    THEN 1
    ELSE 0
    END = 1
  THEN DATE_ADD(DATE_SUB(V01.dat_versorgung, INTERVAL EXTRACT(DAYOFWEEK FROM V01.dat_versorgung) - 1 DAY), INTERVAL 8
   DAY)
  ELSE V01.dat_versorgung
  END AS dat_versorgung
FROM kfl_production_dbp_view.v_fipo_bericht_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.fipo_pruef_objekt_id = V02.fipo_pruef_objekt_id
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_1 AS V03 ON V02.wup_id = V03.wup_id AND V02.mandant_id = V03.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V04 ON V02.vs_id = V04.vs_id AND V02.mandant_id = V04.mandant_id AND V04.wup_id
     IN (2, 22, 28, 43, 46, 124) AND V04.mandant_id = 1
WHERE V01.nicht_auswerten_fg = 0
 AND V01.dat_bis >= CURRENT_DATE;