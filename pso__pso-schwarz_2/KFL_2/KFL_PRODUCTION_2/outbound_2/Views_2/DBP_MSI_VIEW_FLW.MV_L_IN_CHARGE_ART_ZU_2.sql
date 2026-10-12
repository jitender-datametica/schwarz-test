CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_charge_art_zu_2 (mandant_id, in_art_id, charge_id,
objekt_nummer_id) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.charge_id,
 V02.objekt_nummer_id
FROM kfl_production_dbp_view.v_flw_charge_art_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_charge_art_objekt_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.objekt_schluessel_id
    = V02.objekt_schluessel_id;