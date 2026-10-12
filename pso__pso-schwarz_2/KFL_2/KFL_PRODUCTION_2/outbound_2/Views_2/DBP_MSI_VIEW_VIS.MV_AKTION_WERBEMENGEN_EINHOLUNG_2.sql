CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_werbemengen_einholung_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 aktion_id,
 wg_id,
 arthiertyp_id,
 schlagwort,
 dat_von,
 dat_bis,
 dat_rueckmeldung,
 dat_bis_rueckmeldung,
 dat_aktionsbekanntmachung,
 anzahl_artikel_offen,
 anzahl_artikel_gesamt,
  CASE
  WHEN aktion_typ_id = 'ZAME'
  THEN 'AME'
  ELSE 'WME'
  END AS aktion_typ_id,
  CASE
  WHEN status_einholung_id = 2 OR status_einholung_id = 6 AND dat_rueckmeldung < CURRENT_DATE OR status_einholung_id = 9
        AND dat_rueckmeldung < CURRENT_DATE AND status_einholung_markt_kz = '' AND dat_bis >= CURRENT_DATE
  THEN 'Mengeneinholung'
  WHEN status_einholung_id = 9 AND status_einholung_markt_kz IN ('B', 'G')
  THEN 'Bekanntmachung'
  ELSE NULL
  END AS status_einholung
FROM kfl_production_dbp_data.aktion_werbemengen_einholung_2;