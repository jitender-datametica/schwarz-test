CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_art_bwrtngskrs_periode_2 (gjmo, mandant_id,
bewertungskreis_id, in_art_id, dat_aenderung, gjmo_bis, mbew_fg, menge_bestand_bme, kjmo) AS SELECT V01.gjmo,
 V01.mandant_id,
 V01.bewertungskreis_id,
 V01.in_art_id,
 V01.dat_aenderung,
 V01.gjmo_bis,
 V01.mbew_fg,
 V01.menge_bestand_bme,
 V02.kjmo
FROM kfl_production_dbp_view.v_in_art_bwrtngskrs_periode_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_sap_periode_kalender_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND (V02.sap_buchungs_jahr
       * 100 + V02.buchungsperiode_id) BETWEEN V01.gjmo AND V01.gjmo_bis
WHERE V02.krk_id <> 'DE02'
 AND V02.buchungsperiode_id <= 12;