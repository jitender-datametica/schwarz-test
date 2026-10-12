CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_standzeiten_wa_pal_2 (wup_id, nb_id, lagernummer_id,
mandant_id, lief_pal_typ_id, transport_beleg_id, referenznummer, werbeware_id, dat_erstellung, zeit_erstellung,
erstellung_dt, dat_quittierung, dat_lief_soll, dat_bereitstellung, datzeit_bereitstellung, datzeit_start_ta,
datzeit_end_ta, kj_lief_beleg, lief_beleg_id, handling_unit_id_ext, datzeit_scan, dat_aktion, lief_typ_id, kunde_id,
mandant_id_kunde, hu_status_id, distribution_abr_fg, wg_verkett_lief) AS SELECT TRANS.wup_id,
 TRANS.nb_id,
 TRANS.lagernummer_id,
 TRANS.mandant_id,
 TRANS.lief_pal_typ_id,
 TRANS.transport_beleg_id,
 TRANS.referenznummer,
 TRANS.werbeware_id,
 TRANS.dat_erstellung,
 TRANS.zeit_erstellung,
 DATETIME(TRANS.dat_erstellung, COALESCE(TRANS.zeit_erstellung, TIME '00:00:00')) AS erstellung_dt,
 TRANS.dat_quittierung,
 TRANS.dat_lief_soll,
 TRANS.dat_bereitstellung,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(TRANS.datzeit_bereitstellung AS STRING), 1, 6)) AS datzeit_bereitstellung,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(TRANS.datzeit_start_ta AS STRING), 1, 6)) AS datzeit_start_ta,
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(TRANS.datzeit_end_ta AS STRING), 1, 6)) AS datzeit_end_ta,
 TRANS.kj_lief_beleg,
 TRANS.lief_beleg_id,
 trans_det.handling_unit_id_ext,
 prot_ver.datzeit_scan,
 BL.dat_aktion,
 BL.lief_typ_id,
 W.aktuell_wup_id AS kunde_id,
 BL.mandant_id_kunde,
 HU.hu_status_id,
 COALESCE(T.distribution_abr_fg, -1) AS distribution_abr_fg,
 COALESCE(BL.wg_verkett_lief, -1) AS wg_verkett_lief
FROM kfl_production_dbp_view.v_transportauftrag_2 AS TRANS
 INNER JOIN (SELECT mandant_id,
   wup_id,
   transport_beleg_id,
   MAX(handling_unit_id_ext) AS handling_unit_id_ext
  FROM kfl_production_dbp_view.v_transportauftrag_det_2
  WHERE TRIM(COALESCE(handling_unit_id_ext, '')) <> ''
  GROUP BY mandant_id,
   transport_beleg_id,
   wup_id) AS trans_det ON TRANS.mandant_id = trans_det.mandant_id AND TRANS.wup_id = trans_det.wup_id AND TRANS.transport_beleg_id
    = trans_det.transport_beleg_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   dat_lief_soll,
   handling_unit_id_ext,
   MAX(DATETIME(DATE(dat_scan), CAST(zeit_scan AS TIME))) AS datzeit_scan
  FROM kfl_production_dbp_view.v_protokoll_verladung_2
  WHERE pruef_id = '334'
  GROUP BY mandant_id,
   dat_lief_soll,
   handling_unit_id_ext,
   wup_id) AS prot_ver ON TRANS.mandant_id = prot_ver.mandant_id AND trans_det.handling_unit_id_ext = prot_ver.handling_unit_id_ext
      AND TRANS.kj_lief_beleg = EXTRACT(YEAR FROM prot_ver.dat_lief_soll) AND TRANS.wup_id = prot_ver.wup_id
 INNER JOIN kfl_production_dbp_view.v_handling_unit_2 AS HU ON trans_det.handling_unit_id_ext = HU.handling_unit_id_ext
   AND trans_det.mandant_id = HU.mandant_id AND trans_det.wup_id = HU.wup_id
 LEFT JOIN kfl_production_dbp_view.v_besch_lief_2 AS BL ON TRANS.lief_beleg_id = BL.lief_beleg_id AND TRANS.mandant_id =
    BL.mandant_id AND TRANS.kj_lief_beleg = BL.kj
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS W ON W.mandant_id = CASE
     WHEN BL.mandant_id_kunde IS NULL OR BL.mandant_id_kunde = 0
     THEN BL.mandant_id
     ELSE BL.mandant_id_kunde
     END AND W.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(BL.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(BL.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (W.nb_id IN (2, 0, -111) AND W.wup_id > 0 OR W.nb_id = -1 AND W.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_tour_2 AS T ON TRANS.mandant_id = T.mandant_id AND TRANS.wup_id = T.wup_id AND TRANS
    .nb_id = T.nb_id AND TRANS.referenznummer = T.tour_id;