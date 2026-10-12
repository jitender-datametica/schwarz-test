CREATE OR REPLACE VIEW dbp_msi_view_log.mv_art_wup_status_per -- 16.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage

AS
SELECT
v01.art_id,
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.dat_von,
v01.system_id,
v01.loesch_id,
v01.dat_bis,
v01.wg_verkett_id,
v01.fremd_lagerort_id,
v01.disponent_id,
v01.pps_plan_kalender_id,
v01.disposition_rhythmus_id,
v01.planlieferzeit,
v01.dispomerkmal,
v01.we_bearbeitungszeit,
v01.min_sicherh_bestand,
v01.anliefer_kalender,
v01.kdis,
v01.bezugsweg_id,
v01.terminierungsgruppe_1_id,
v01.terminierungsgruppe_2_id,
v01.terminierungsgruppe_3_id,
v01.sollbestand,
v01.dat_loesch_id,
v01.selbstabholung_fg,
v01.min_restlaufzeit,
v02.lagernummer_id
FROM dbp_view.v_art_wup_status_per v01
LEFT JOIN (SELECT
mandant_id,
wup_id,
nb_id,
lagernummer_id
FROM dbp_view.v_l_lagernummer
           WHERE Left(lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
            AND Length(Trim(lagernummer_id)) = 4
          ) v02
  ON v01.mandant_id = v02.mandant_id
 AND v01.wup_id = v02.wup_id
 AND v01.nb_id = v02.nb_id
WHERE v01.dat_bis = DATE '9999-12-31' AND v01.nb_id = -111;
