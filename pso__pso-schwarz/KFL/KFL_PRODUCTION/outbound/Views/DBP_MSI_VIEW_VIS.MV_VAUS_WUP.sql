CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vaus_wup (mandant_id, nb_id, land_id, wup_id, buchungskreis_id
, telefon, telefax, betriebsrat_fg, auflage_wup_verteilgebiet, auflage_wup_auslage, vaus_wup_plz, vaus_wup_strasse,
vaus_wup_stadt, vaus_wup_name) AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.land_id,
 V01.wup_id,
 COALESCE(V02.buchungskreis_id, - 1) AS buchungskreis_id,
 V02.wup_telefon AS telefon,
 V02.wup_fax AS telefax,
 COALESCE(V02.betriebsrat_fg, - 1) AS betriebsrat_fg,
 V02.auflage_wup_verteilgebiet,
 V02.auflage_wup_auslage,
 V02.wup_plz AS vaus_wup_plz,
 V02.wup_str AS vaus_wup_strasse,
 V02.wup_stadt_1 AS vaus_wup_stadt,
 COALESCE(V02.wup_name_1, '') AS vaus_wup_name
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
WHERE V01.nb_id IN (- 2, - 1, 0, 2, 7)
 AND V01.dat_eroeffnung > DATE('1900-01-01');