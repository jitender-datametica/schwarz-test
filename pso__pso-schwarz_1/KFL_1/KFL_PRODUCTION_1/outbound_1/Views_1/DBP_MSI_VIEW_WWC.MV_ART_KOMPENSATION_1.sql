CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_kompensation_1 (mandant_id, art_id, meins, zcgrefart, zcgnr
, zcgadv, factor) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.komp_basismenge_einh_id AS meins,
 V01.art_id_ref AS zcgrefart,
 V02.komp_gruppe_id AS zcgnr,
 V02.komp_kriterium_fg AS zcgadv,
 V02.komp_faktor AS factor
FROM kfl_production_dbp_view.v_art_kompensation_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_kompensation_gruppe_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id
    = V02.art_id;