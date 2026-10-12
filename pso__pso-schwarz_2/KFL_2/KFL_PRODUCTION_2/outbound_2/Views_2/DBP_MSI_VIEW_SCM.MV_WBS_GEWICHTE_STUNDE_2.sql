CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_gewichte_stunde_2 (mandant_id, wup_id, nb_id, art_id,
aktion_id, dat_von, dat_bis, anzahl_faelle, anzahl_faelle_im_korridor, korridor_level, kategorie, menge_max, menge_min,
menge_avg_21tage, anteil_zeitfenster1, anteil_zeitfenster2, referenziert_fg, wbs_level, wbs_level_id) AS SELECT V01.mandant_id
 ,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.aktion_id,
 V01.dat_von,
 V01.dat_bis,
 V01.anzahl_faelle,
 V01.anzahl_faelle_im_korridor,
 V01.korridor_level,
 V01.kategorie,
 V01.menge_max,
 V01.menge_min,
 V01.menge_avg_21tage,
 V01.anteil_zeitfenster1,
 V01.anteil_zeitfenster2,
 V01.referenziert_fg,
 V01.wbs_level,
 V01.wbs_level_id
FROM kfl_production_dbp_view.v_wbs_gewichte_stunde_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0);