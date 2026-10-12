CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_fwws_wup_1 (mandant_id, nb_id, wup_id, kjmo, gj, mo_kj
, akt_mo, akt_gj, anz_buchung_masch, anz_vorgang_ohne, anz_wa_nicht_gemeldet, anz_buchung_gs, anz_we_nicht_gemeldet,
anz_buchung_rech, anz_rech_pos, sum_buchung_masch, sum_vorgang_ohne, sum_wa_nicht_gemeldet, sum_buchung_gs,
sum_we_nicht_gemeldet, sum_buchung_rech, anz_buchung_masch_kum, anz_vorgang_ohne_kum, anz_wa_nicht_gemeldet_kum,
anz_buchung_gs_kum, anz_we_nicht_gemeldet_kum, anz_buchung_rech_kum, anz_rech_pos_kum, sum_buchung_masch_kum,
sum_vorgang_ohne_kum, sum_wa_nicht_gemeldet_kum, sum_buchung_gs_kum, sum_we_nicht_gemeldet_kum, sum_buchung_rech_kum) AS
SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.kjmo,
 V01.gj,
 V01.mo_kj,
 V01.akt_mo,
 V01.akt_gj,
 SUM(V01.anz_buchung_masch) AS anz_buchung_masch,
 SUM(V01.anz_vorgang_ohne) AS anz_vorgang_ohne,
 SUM(V01.anz_wa_nicht_gemeldet) AS anz_wa_nicht_gemeldet,
 SUM(V01.anz_buchung_gs) AS anz_buchung_gs,
 SUM(V01.anz_we_nicht_gemeldet) AS anz_we_nicht_gemeldet,
 SUM(V01.anz_buchung_rech) AS anz_buchung_rech,
 SUM(V01.anz_rech_pos) AS anz_rech_pos,
 SUM(V01.sum_buchung_masch) AS sum_buchung_masch,
 SUM(V01.sum_vorgang_ohne) AS sum_vorgang_ohne,
 SUM(V01.sum_wa_nicht_gemeldet) AS sum_wa_nicht_gemeldet,
 SUM(V01.sum_buchung_gs) AS sum_buchung_gs,
 SUM(V01.sum_we_nicht_gemeldet) AS sum_we_nicht_gemeldet,
 SUM(V01.sum_buchung_rech) AS sum_buchung_rech,
 SUM(SUM(V01.anz_buchung_masch)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 anz_buchung_masch_kum,
 SUM(SUM(V01.anz_vorgang_ohne)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 anz_vorgang_ohne_kum,
 SUM(SUM(V01.anz_wa_nicht_gemeldet)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
    , CAST(V01.nb_id AS STRING), CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_wa_nicht_gemeldet_kum,
 SUM(SUM(V01.anz_buchung_gs)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 anz_buchung_gs_kum,
 SUM(SUM(V01.anz_we_nicht_gemeldet)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
    , CAST(V01.nb_id AS STRING), CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS anz_we_nicht_gemeldet_kum,
 SUM(SUM(V01.anz_buchung_rech)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 anz_buchung_rech_kum,
 SUM(SUM(V01.anz_rech_pos)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 anz_rech_pos_kum,
 SUM(SUM(V01.sum_buchung_masch)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 sum_buchung_masch_kum,
 SUM(SUM(V01.sum_vorgang_ohne)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 sum_vorgang_ohne_kum,
 SUM(SUM(V01.sum_wa_nicht_gemeldet)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
    , CAST(V01.nb_id AS STRING), CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_wa_nicht_gemeldet_kum,
 SUM(SUM(V01.sum_buchung_gs)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 sum_buchung_gs_kum,
 SUM(SUM(V01.sum_we_nicht_gemeldet)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
    , CAST(V01.nb_id AS STRING), CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_we_nicht_gemeldet_kum,
 SUM(SUM(V01.sum_buchung_rech)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , CAST(V01.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 sum_buchung_rech_kum
FROM kfl_production_dbp_msi_v_view.v_vis_monat_fwws_wup_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
GROUP BY V01.mandant_id,
 V01.nb_id,
 wup_id,
 V01.kjmo,
 V01.gj,
 V01.mo_kj,
 V01.akt_mo,
 V01.akt_gj;