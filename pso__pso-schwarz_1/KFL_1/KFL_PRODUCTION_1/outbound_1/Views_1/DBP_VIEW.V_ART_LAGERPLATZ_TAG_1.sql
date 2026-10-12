CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_lagerplatz_tag_1 AS SELECT art_id,
 mandant_id,
 dat,
 lagerplatz_id,
 lagernummer_id,
 lagertyp_id,
 wup_id,
 nb_id,
 mlgt_fg,
 bestand_kz,
 lagerplatz_loesch_kz,
 system_id,
 anzahl_quant
FROM kfl_production_dbp_data.art_lagerplatz_tag_1;