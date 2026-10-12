CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_mitarbeiterbew_1 (mandant_id, mitarbeiter_id,
kostenstelle_id, kostenstelle_ebene4_id, wup_id, hr_objekt_id, hr_objekt_bez_kurz, hr_objekt_bereich_id_org,
hr_objekt_bereich_id, kjmo, akt_mo, kj, gj, shr_ma_funktion_id, shr_ma_funktion_id_2, mitarbeiter_gruppe_id,
mitarbeiter_kreis_id, shr_ma_funktion_gruppe_id, kopf_int, ma_status_id, langzeit_abwesend_fg, eintritt_fg,
wiedereintritt_monatlich, austritt_alles_fg, austritt_fluktuation_fg, untermonatlich_fg, ma_status_id_vm,
langzeit_abwesend_fg_vm, kein_lza, aktiv, flukt, flukt_austritt, eintrittsdatum, austrittsdatum, vzk, kopf,
betriebszugehoerigkeit_bereinigt, betriebszugehoerigkeit_cluster_sort_id, bzg_00, bzg_0003, bzg_0306, bzg_0612, bzg_1236
, bzg_36, filial, tzk, tzk2, austritt_ag_fg, austritt_an_fg, austritt_trw_fg, austritt_vtg_fg, austritt_ana_fg,
austritt_ugsi_fg, austritt_ugsw_fg, austritt_bu_fg, flukt_austritt_alt, urlaub_rest, urlaub_rest_min, urlaub_anspruch,
urlaub_genommen, urlaub_genommen_kum, std_krank, std_vertrag, std_soll, urlaub_abgelt, feiertag_zuschlag,
mehrstd_zuschlag, nacht_zuschlag, wochenend_zuschlag, mehrstd_ausbez, std_abr, std_soll_mbew) AS SELECT ma_bew.mandant_id
 ,
 ma_bew.mitarbeiter_id,
 ma_bew.kostenstelle_id,
 ma_bew.kostenstelle_ebene4_id,
 ROUND(CAST(SUBSTR(ma_bew.kostenstelle_id, 1, 4) AS BIGNUMERIC), 0) AS wup_id,
 ma_bew.hr_objekt_id,
 ORG_EH.hr_objekt_bez_kurz,
 ORG_EH.hr_objekt_bereich_id AS hr_objekt_bereich_id_org,
  CASE
  WHEN ORG_EH.hr_objekt_bereich_id = - 1
  THEN 60
  ELSE ORG_EH.hr_objekt_bereich_id
  END AS hr_objekt_bereich_id,
 ma_bew.kjmo,
 ma_bew.akt_mo,
 ma_bew.kj,
 ma_bew.gj,
 ma_bew.shr_ma_funktion_id,
 ma_bew.shr_ma_funktion_id_2,
 ma_bew.mitarbeiter_gruppe_id,
 ma_bew.mitarbeiter_kreis_id,
  CASE
  WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (22)
  THEN 10
  WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (21)
  THEN 20
  WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (14)
  THEN 30
  WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (15)
  THEN 40
  WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (16)
  THEN - 1
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.azubi_cz_sk_stunden
     <> 0
  THEN 60
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
     <> 0
  THEN 90
  WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
     <> 0
  THEN 90
  WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('12') AND ma_bew.shr_ma_funktion_id IN ('11-030-1') OR
     ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('C0', 'C1', 'C3')
  THEN 100
  WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id
               IN ('00', 'B3') AND ma_bew.shr_ma_funktion_id IN ('14-013-1', '14-017-1') OR ma_bew.mandant_id = 5 AND
            ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR
           ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('92') AND ma_bew.shr_ma_funktion_id IN ('11-009-1'
           , '11-011-1') OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 3 AND
        ma_bew.mitarbeiter_kreis_id IN ('09', '17', '18') OR ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN ('10'
        ) OR ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id
      IN ('10')
  THEN 60
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('11', '12', '91', '92')
  THEN 70
  WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('14-013-1', '14-017-1') OR ma_bew.mandant_id = 5 AND
                ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('14-017-1'
                ) OR ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 7 AND
             ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id IN ('14-017-1'
             ) OR ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 2 AND
          ma_bew.shr_ma_funktion_id IN ('11-009-1') OR ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1'
           ) AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id IN ('11-009-1'
         ) OR ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id IN ('11-009-1') OR ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id
       IN ('11-009-1') OR ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id IN ('11-016-1')
  THEN 60
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', 'B3', 'B4')
  THEN 50
  WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', '23', '24', '25', '29', '30', '31', '32')
  THEN 50
  WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', '1M', '3R', '4R', '7M', '5R')
  THEN 50
  WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', '05', '06', '12', '13', '14', '15', '16', '24', '25')
  THEN 50
  WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', '41', '48', '62', '65', '66', '67', '68', '69')
  THEN 50
  WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02')
  THEN 50
  WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('00', '01', '02', '41', '48', '62', '65', '66', '67', '68', '69')
  THEN 50
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
      IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 80
  WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('20', '21', '22')
  THEN 90
  WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('20', '21', '22')
  THEN 90
  WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('20', '21', '22')
  THEN 90
  WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('20', '21', '22')
  THEN 90
  WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
     IN ('20', '21', '22')
  THEN 90
  ELSE - 1
  END AS shr_ma_funktion_gruppe_id,
 1.00 AS kopf_int,
 ma_bew.ma_status_id,
 ma_bew.langzeit_abwesend_fg,
 ma_bew.eintritt_fg,
 ma_bew.wiedereintritt_monatlich,
 ma_bew.austritt_alles_fg,
 COALESCE(massn_austritt.austritt_fluktuation_fg, 0) AS austritt_fluktuation_fg,
 ma_bew.untermonatlich_fg,
 MA_BEW_VM.ma_status_id AS ma_status_id_vm,
 MA_BEW_VM.langzeit_abwesend_fg AS langzeit_abwesend_fg_vm,
  CASE
  WHEN ma_bew.langzeit_abwesend_fg NOT IN (1)
  THEN 1
  ELSE 0
  END AS kein_lza,
  CASE
  WHEN ma_bew.wiedereintritt_monatlich = 0 AND ma_bew.untermonatlich_fg = 1
  THEN 0
  WHEN ma_bew.wiedereintritt_monatlich = 1 AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1'
      ) OR ma_bew.austritt_alles_fg NOT IN (1) AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN
      ('1')
  THEN 1
  ELSE 0
  END AS aktiv,
  CASE
  WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id
     IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN
      ('12')
  THEN 0
  WHEN massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.langzeit_abwesend_fg IN (1) OR massn_austritt.austritt_fluktuation_fg
        = 1 AND ma_bew.langzeit_abwesend_fg IN (0) AND MA_BEW_VM.langzeit_abwesend_fg IN (1) OR massn_austritt.austritt_fluktuation_fg
      = 1 AND ma_bew.ma_status_id IN ('1')
  THEN 1
  WHEN ma_bew.untermonatlich_fg = 1
  THEN 0
  WHEN ma_bew.wiedereintritt_monatlich = 1 AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1'
       ) OR ma_bew.austritt_alles_fg NOT IN (1) AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id
      NOT IN ('1') OR massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.eintritt_fg <> 1 AND ma_bew.ma_status_id
     NOT IN ('0')
  THEN 1
  ELSE 0
  END AS flukt,
  CASE
  WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id
     IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN
      ('12')
  THEN 0
  WHEN massn_austritt.austritt_fluktuation_fg = 1
  THEN 1
  ELSE 0
  END AS flukt_austritt,
 ma_bew.eintrittsdatum,
 ma_bew.austrittsdatum,
  CASE
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.azubi_cz_sk_stunden
     <> 0
  THEN ma_bew.azubi_cz_sk_stunden / 174.00
  WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
     <> 0
  THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
  WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
     <> 0
  THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
  WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12')
  THEN ma_bew.ext_studi_hr_stunden / 173.00
  WHEN ma_bew.mandant_id = 6
  THEN ma_bew.arbeitszeit_anteil_hr / 100.00
  ELSE ma_bew.arbeitszeit_anteil / 100.00
  END AS vzk,
  CASE
  WHEN CASE
    WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (22)
    THEN 10
    WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (21)
    THEN 20
    WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (14)
    THEN 30
    WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (15)
    THEN 40
    WHEN CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (16)
    THEN - 1
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.azubi_cz_sk_stunden
       <> 0
    THEN 60
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
       <> 0
    THEN 90
    WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
       <> 0
    THEN 90
    WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('12') AND ma_bew.shr_ma_funktion_id IN ('11-030-1')
     OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('C0', 'C1', 'C3')
    THEN 100
    WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id
                 IN ('00', 'B3') AND ma_bew.shr_ma_funktion_id IN ('14-013-1', '14-017-1') OR ma_bew.mandant_id = 5 AND
              ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('10')
          OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('92') AND ma_bew.shr_ma_funktion_id IN ('11-009-1'
             , '11-011-1') OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 3
         AND ma_bew.mitarbeiter_kreis_id IN ('09', '17', '18') OR ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id
         IN ('10') OR ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 4 AND
       ma_bew.mitarbeiter_kreis_id IN ('10')
    THEN 60
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('11', '12', '91', '92')
    THEN 70
    WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('14-013-1', '14-017-1') OR ma_bew.mandant_id = 5 AND
                  ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('14-017-1'
                  ) OR ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 7 AND
               ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id IN ('14-017-1'
               ) OR ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id IN ('14-017-1') OR ma_bew.mandant_id = 2 AND
            ma_bew.shr_ma_funktion_id IN ('11-009-1') OR ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1'
             ) AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id IN ('11-009-1'
           ) OR ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id IN ('11-009-1') OR ma_bew.mandant_id = 7 AND ma_bew
        .shr_ma_funktion_id IN ('11-009-1') OR ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id IN ('11-016-1')
    THEN 60
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', 'B3', 'B4')
    THEN 50
    WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', '23', '24', '25', '29', '30', '31', '32')
    THEN 50
    WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', '1M', '3R', '4R', '7M', '5R')
    THEN 50
    WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', '05', '06', '12', '13', '14', '15', '16', '24', '25')
    THEN 50
    WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', '41', '48', '62', '65', '66', '67', '68', '69')
    THEN 50
    WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02')
    THEN 50
    WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('00', '01', '02', '41', '48', '62', '65', '66', '67', '68', '69')
    THEN 50
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
        IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7')
    THEN 80
    WHEN ma_bew.mandant_id = 6 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('20', '21', '22')
    THEN 90
    WHEN ma_bew.mandant_id = 3 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('20', '21', '22')
    THEN 90
    WHEN ma_bew.mandant_id = 7 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('20', '21', '22')
    THEN 90
    WHEN ma_bew.mandant_id = 8 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('20', '21', '22')
    THEN 90
    WHEN ma_bew.mandant_id = 4 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.mitarbeiter_kreis_id
       IN ('20', '21', '22')
    THEN 90
    ELSE - 1
    END = 100
  THEN CASE
   WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.azubi_cz_sk_stunden
      <> 0
   THEN ma_bew.azubi_cz_sk_stunden / 174.00
   WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
      <> 0
   THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
   WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
      <> 0
   THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12')
   THEN ma_bew.ext_studi_hr_stunden / 173.00
   WHEN ma_bew.mandant_id = 6
   THEN ma_bew.arbeitszeit_anteil_hr / 100.00
   ELSE ma_bew.arbeitszeit_anteil / 100.00
   END
  ELSE 1.00
  END AS kopf,
 ma_bew.betriebszugehoerigkeit_bereinigt,
 ma_bew.betriebszugehoerigkeit_cluster_sort_id,
 ma_bew.bzg_00,
 ma_bew.bzg_0003,
 ma_bew.bzg_0306,
 ma_bew.bzg_0612,
 ma_bew.bzg_1236,
 ma_bew.bzg_36,
  CASE
  WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('00', 'B3') AND ma_bew.shr_ma_funktion_id IN ('14-017-1'
                   , '14-013-1') OR ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('00', '01', '02', 'B3',
                   'B4') OR ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('00', '01', '02', '23', '24', '25'
                  , '29', '30', '31', '32') OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('00', '01',
                 '02', '1M', '3R', '4R', '7M', '5R') OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('00',
                '01', '02', '05', '06', '12', '13', '14', '15', '16', '24', '25') OR ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id
               IN ('00', '01', '02', '41', '48', '62', '65', '66', '67', '68', '69') OR ma_bew.mandant_id = 8 AND ma_bew
             .mitarbeiter_kreis_id IN ('00', '01', '02') OR ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('00'
             , '01', '02', '41', '48', '62', '65', '66', '67', '68', '69') OR ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id
             IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id
            IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id
           IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id
         IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN
         ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('90'
        ) AND ma_bew.mitarbeiter_gruppe_id IN ('7') OR ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('90')
    AND ma_bew.mitarbeiter_gruppe_id IN ('7')
  THEN 1
  WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('10') AND ma_bew.shr_ma_funktion_id IN ('11-000-1',
     '11-009-1')
  THEN 0
  WHEN ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id
          IN ('10', '09', '17', '18') OR ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id
        = 7 AND ma_bew.mitarbeiter_kreis_id IN ('10') OR ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('10'
       ) OR ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('10')
  THEN 1
  ELSE 0
  END AS filial,
  CASE
  WHEN CASE
    WHEN ma_bew.mandant_id = 6
    THEN ma_bew.arbeitszeit_anteil_hr
    ELSE ma_bew.arbeitszeit_anteil
    END <= 80
  THEN 1.00
  ELSE 0.00
  END AS tzk,
  CASE
  WHEN CASE
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.azubi_cz_sk_stunden
       <> 0
    THEN ma_bew.azubi_cz_sk_stunden / 174.00
    WHEN ma_bew.mandant_id = 2 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
       <> 0
    THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
    WHEN ma_bew.mandant_id = 5 AND CAST(ma_bew.shr_ma_funktion_id_2 AS INTEGER) IN (11, 12, 13) AND ma_bew.aushilfe_cz_sk_stunden
       <> 0
    THEN ma_bew.aushilfe_cz_sk_stunden / 174.00
    WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12')
    THEN ma_bew.ext_studi_hr_stunden / 173.00
    WHEN ma_bew.mandant_id = 6
    THEN ma_bew.arbeitszeit_anteil_hr / 100.00
    ELSE ma_bew.arbeitszeit_anteil / 100.00
    END <= 80
  THEN 1
  ELSE 0
  END AS tzk2,
 COALESCE(massn_austritt.austritt_ag_fg, 0) AS austritt_ag_fg,
 COALESCE(massn_austritt.austritt_an_fg, 0) AS austritt_an_fg,
 COALESCE(massn_austritt.austritt_trw_fg, 0) AS austritt_trw_fg,
 COALESCE(massn_austritt.austritt_vtg_fg, 0) AS austritt_vtg_fg,
 COALESCE(massn_austritt.austritt_ana_fg, 0) AS austritt_ana_fg,
 COALESCE(massn_austritt.austritt_ugsi_fg, 0) AS austritt_ugsi_fg,
 COALESCE(massn_austritt.austritt_ugsw_fg, 0) AS austritt_ugsw_fg,
 COALESCE(massn_austritt.austritt_bu_fg, 0) AS austritt_bu_fg,
  CASE
  WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id
     IN ('10') OR ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN
      ('12')
  THEN 0
  ELSE ma_bew.austritt_alles_fg
  END AS flukt_austritt_alt,
 ma_bew.resturlaub_vj AS urlaub_rest,
 FIRST_VALUE(ma_bew.resturlaub_vj) OVER (PARTITION BY CAST(ma_bew.mandant_id AS STRING), ma_bew.mitarbeiter_id, CAST(ma_bew.kj AS STRING)
    ORDER BY ma_bew.mandant_id IS NULL, ma_bew.mandant_id, ma_bew.mitarbeiter_id IS NULL, ma_bew.mitarbeiter_id, ma_bew
    .kj IS NULL, ma_bew.kj, ma_bew.kjmo IS NULL, ma_bew.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 urlaub_rest_min,
 ma_bew.anspruch_urlaub_akt_kj AS urlaub_anspruch,
 ma_bew.genommen_urlaub AS urlaub_genommen,
 SUM(ma_bew.genommen_urlaub) OVER (PARTITION BY CAST(ma_bew.mandant_id AS STRING), ma_bew.mitarbeiter_id, CAST(ma_bew.kj AS STRING)
    ORDER BY ma_bew.mandant_id IS NULL, ma_bew.mandant_id, ma_bew.mitarbeiter_id IS NULL, ma_bew.mitarbeiter_id, ma_bew
    .kj IS NULL, ma_bew.kj, ma_bew.kjmo IS NULL, ma_bew.kjmo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
 urlaub_genommen_kum,
  CASE
  WHEN ma_bew.mandant_id = 6
  THEN COALESCE(kost_lohn.std_abwesenheit_lohnart, 0)
  ELSE COALESCE(abwesenh_krank.std_abwesenheit, 0)
  END AS std_krank,
 lohn_mvst.std_lohnart AS std_vertrag,
 COALESCE(kost_lohn.std_soll, 0) AS std_soll,
 COALESCE(kost_lohn.std_urlaub_abgeltung, 0) AS urlaub_abgelt,
 COALESCE(kost_lohn.std_feiertag_zuschlag, 0) AS feiertag_zuschlag,
 COALESCE(kost_lohn.std_mehr_zuschlag, 0) AS mehrstd_zuschlag,
 COALESCE(kost_lohn.std_nacht_zuschlag, 0) AS nacht_zuschlag,
 COALESCE(kost_lohn.std_wochenend_zuschlag, 0) AS wochenend_zuschlag,
 COALESCE(kost_lohn.std_mehr_ausbezahlt, 0) AS mehrstd_ausbez,
 ma_bew.abr_stunden_monat AS std_abr,
 ma_bew.soll_stunden_monat AS std_soll_mbew
FROM (SELECT MABEW.mandant_id,
   MABEW.mitarbeiter_id,
   MABEW.shr_ma_funktion_id,
   MABEW.hr_objekt_id,
    CASE
    WHEN MABEW.shr_ma_funktion_id LIKE '14-009-1%' OR MABEW.shr_ma_funktion_id LIKE '14-017-1%' OR MABEW.shr_ma_funktion_id
         LIKE '14-013-1%' AND MABEW.mandant_id = 2 OR MABEW.shr_ma_funktion_id LIKE '14-001-2%' AND MABEW.mandant_id = 6
         OR MABEW.shr_ma_funktion_id LIKE '14-016-1%' AND MABEW.mandant_id = 6
    THEN '13'
    WHEN MABEW.shr_ma_funktion_id LIKE '23-003-3%'
    THEN '22'
    ELSE CASE
     WHEN SUBSTR(MABEW.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(MABEW.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END
    END AS shr_ma_funktion_id_2,
   v101.mitarbeiter_gruppe_id,
   v102.mitarbeiter_kreis_id,
   v103.kostenstelle_id,
   v200.kostenstelle_ebene4_id,
   MABEW.kjmo,
   v100.akt_mo,
   v100.kj,
   v100.gj,
   MABEW.ma_status_id,
   MABEW.langzeit_abwesend_fg,
   MABEW.untermonatlich_fg,
   COALESCE(v033.dat_von, v035.dat_von, v036.dat_von, DATE('1900-01-01')) AS eintrittsdatum,
    CASE
    WHEN v033.mitarbeiter_id IS NOT NULL OR v035.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS eintritt_fg,
   COALESCE(DATE_SUB(v094.dat_von, INTERVAL 1 DAY), DATE('9999-12-31')) AS austrittsdatum,
    CASE
    WHEN v094.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS austritt_alles_fg,
    CASE
    WHEN v094.mitarbeiter_id IS NOT NULL AND DATE_SUB(v094.dat_von_wiedereintritt, INTERVAL 1 DAY) < v035.dat_von_wiedereintritt
         AND CAST(EXTRACT(MONTH FROM v094.dat_von_wiedereintritt) AS BIGNUMERIC) = CAST(EXTRACT(MONTH FROM v035.dat_von_wiedereintritt) AS BIGNUMERIC)
        AND v035.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS wiedereintritt_monatlich,
    CASE
    WHEN v096.mitarbeiter_id IS NOT NULL
    THEN v096.anzahl_lohnart
    ELSE 0
    END AS aushilfe_cz_sk_stunden,
    CASE
    WHEN v097.mitarbeiter_id IS NOT NULL
    THEN v097.anzahl_lohnart
    ELSE 0
    END AS azubi_cz_sk_stunden,
    CASE
    WHEN ext_studi.mitarbeiter_id IS NOT NULL
    THEN ext_studi.anzahl_lohnart
    ELSE 0
    END AS ext_studi_hr_stunden,
   MABEW.arbeitszeit_anteil,
   COALESCE(v099.arbeitszeit_anteil_hr, 0.00) AS arbeitszeit_anteil_hr,
   COALESCE(CASE
     WHEN v094.dat_von IS NULL
     THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
      , 1)
     ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1)
     END, - 1) AS betriebszugehoerigkeit_bereinigt,
    CASE
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
        , 1)
       ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1)
       END, - 1) < - 1
    THEN 0
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
        , 1)
       ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1)
       END, - 1) = - 1
    THEN 1
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
        , 1)
       ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1)
       END, - 1) <= 3
    THEN 2
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) > 3 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) <= 6
    THEN 3
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) > 6 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) <= 12
    THEN 4
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) > 12 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
         , 1)
        ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
         )
        END, - 1) <= 36
    THEN 5
    ELSE 6
    END AS betriebszugehoerigkeit_cluster_sort_id,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END <= 1
    THEN 1
    ELSE 0
    END AS bzg_00,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END = 2
    THEN 1
    ELSE 0
    END AS bzg_0003,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END = 3
    THEN 1
    ELSE 0
    END AS bzg_0306,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END = 4
    THEN 1
    ELSE 0
    END AS bzg_0612,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END = 5
    THEN 1
    ELSE 0
    END AS bzg_1236,
    CASE
    WHEN CASE
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) < - 1
      THEN 0
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) = - 1
      THEN 1
      WHEN COALESCE(CASE
         WHEN v094.dat_von IS NULL
         THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
          , 1)
         ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC), 1
          )
         END, - 1) <= 3
      THEN 2
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 3 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 6
      THEN 3
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 6 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 12
      THEN 4
      WHEN COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) > 12 AND COALESCE(CASE
          WHEN v094.dat_von IS NULL
          THEN ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v100.stichtag, DATE_ADD(COALESCE(v033.dat_von, v035.dat_von, v036.dat_von), INTERVAL 1 DAY)) AS NUMERIC)
           , 1)
          ELSE ROUND(CAST(UDF_SCHEMA.MONTHS_BETWEEN(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC),
           1)
          END, - 1) <= 36
      THEN 5
      ELSE 6
      END >= 6
    THEN 1
    ELSE 0
    END AS bzg_36,
   MABEW.abr_stunden_monat,
   MABEW.soll_stunden_monat,
   MABEW.resturlaub_vj,
   MABEW.anspruch_urlaub_akt_kj,
   MABEW.genommen_urlaub
  FROM kfl_production_dbp_view.v_mitarbeiterbew_1 AS MABEW
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von,
     MAX(dat_von) AS dat_von_wiedereintritt
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_1
    WHERE hr_massnahme_id = '01'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v033 ON MABEW.mitarbeiter_id = v033.mitarbeiter_id AND MABEW.mandant_id = v033.mandant_id AND MABEW.kjmo =
     v033.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von,
     MAX(dat_von) AS dat_von_wiedereintritt
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_1
    WHERE hr_massnahme_id = '02'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v035 ON MABEW.mitarbeiter_id = v035.mitarbeiter_id AND MABEW.mandant_id = v035.mandant_id AND MABEW.kjmo =
     v035.kjmo
   LEFT JOIN (SELECT DISTINCT mandant_id,
     datumsart_id,
     mitarbeiter_id,
     kjmo,
     dat_von
    FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_1 AS V036
    WHERE datumsart_id = '02') AS v036 ON MABEW.mitarbeiter_id = v036.mitarbeiter_id AND MABEW.mandant_id = v036.mandant_id
       AND MABEW.kjmo = v036.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von,
     MAX(dat_von) AS dat_von_wiedereintritt
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_1
    WHERE hr_massnahme_id = '04'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v094 ON MABEW.mitarbeiter_id = v094.mitarbeiter_id AND MABEW.mandant_id = v094.mandant_id AND MABEW.kjmo =
     v094.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     SUM(anzahl_lohnart) AS anzahl_lohnart
    FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_1
    WHERE mandant_id = 2 AND lohnart_id IN ('3001', '3004')
     OR mandant_id = 5 AND lohnart_id IN ('3001')
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v096 ON MABEW.mitarbeiter_id = v096.mitarbeiter_id AND MABEW.mandant_id = v096.mandant_id AND MABEW.kjmo =
     v096.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     SUM(anzahl_lohnart) AS anzahl_lohnart
    FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_1
    WHERE mandant_id = 2
     AND lohnart_id IN ('1072')
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v097 ON MABEW.mitarbeiter_id = v097.mitarbeiter_id AND MABEW.mandant_id = v097.mandant_id AND MABEW.kjmo =
     v097.kjmo
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     SUM(anzahl_lohnart) AS anzahl_lohnart
    FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_1
    WHERE mandant_id = 6
     AND lohnart_id IN ('1035')
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS ext_studi ON MABEW.mitarbeiter_id = ext_studi.mitarbeiter_id AND MABEW.mandant_id = ext_studi.mandant_id
    AND MABEW.kjmo = ext_studi.kjmo
   LEFT JOIN (SELECT mandant_id,
     kjmo_von,
     kjmo_bis,
     anz_stunden_von,
     anz_stunden_bis,
     SUM(arbeitszeit_anteil) AS arbeitszeit_anteil_hr
    FROM kfl_production_dbp_view.v_shr_arbeitszeit_anteil_mapping_1 AS V099
    GROUP BY mandant_id,
     kjmo_bis,
     anz_stunden_bis,
     kjmo_von,
     anz_stunden_von) AS v099 ON MABEW.mandant_id = v099.mandant_id AND MABEW.kjmo BETWEEN v099.kjmo_von AND v099.kjmo_bis
       AND MABEW.soll_stunden_monat BETWEEN v099.anz_stunden_von AND v099.anz_stunden_bis
   LEFT JOIN (SELECT kjmo,
     akt_mo,
     kj,
     gj,
     max_dat AS stichtag
    FROM kfl_production_dbp_view.v_monat_1) AS v100 ON MABEW.kjmo = v100.kjmo
   LEFT JOIN (SELECT DISTINCT mandant_id,
     mitarbeiter_id,
     kjmo,
     mitarbeiter_gruppe_id
    FROM kfl_production_dbp_view.v_ma_gruppe_zu_per_1) AS v101 ON MABEW.mitarbeiter_id = v101.mitarbeiter_id AND MABEW.mandant_id
       = v101.mandant_id AND MABEW.kjmo = v101.kjmo
   LEFT JOIN (SELECT DISTINCT mandant_id,
     mitarbeiter_id,
     kjmo,
     mitarbeiter_kreis_id
    FROM kfl_production_dbp_view.v_ma_kreis_zu_per_1) AS v102 ON MABEW.mitarbeiter_id = v102.mitarbeiter_id AND MABEW.mandant_id
       = v102.mandant_id AND MABEW.kjmo = v102.kjmo
   LEFT JOIN (SELECT DISTINCT mandant_id,
     mitarbeiter_id,
     kjmo,
     kostenstelle_id
    FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1) AS v103 ON MABEW.mitarbeiter_id = v103.mitarbeiter_id AND
      MABEW.mandant_id = v103.mandant_id AND MABEW.kjmo = v103.kjmo
   LEFT JOIN (SELECT DISTINCT mandant_id,
     kjmo,
     kostenstelle_ebene4_id,
     kostenstelle_ebene15_id
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_1
    WHERE kostenstelle_ebene1_id IN ('KCZ01', 'KSK01', 'KHR01', 'KPL01', 'KRO01', 'KBG01', 'KMD01')) AS v200 ON v103.kostenstelle_id
       = v200.kostenstelle_ebene15_id AND MABEW.mandant_id = v200.mandant_id AND MABEW.kjmo = v200.kjmo) AS ma_bew
 LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_1 AS MA_BEW_VM ON ma_bew.mitarbeiter_id = MA_BEW_VM.mitarbeiter_id AND
    ma_bew.mandant_id = MA_BEW_VM.mandant_id AND MA_BEW_VM.kjmo = ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(ma_bew.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(ma_bew.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(ma_bew.kjmo as STRING)), INTERVAL
         - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(ma_bew.kjmo as STRING)), INTERVAL - 1 MONTH))) AS BIGNUMERIC)
    , 0)
 LEFT JOIN (SELECT mandant_id,
   mitarbeiter_id,
   kjmo,
   SUM(stunden_lohnart) AS std_lohnart
  FROM kfl_production_dbp_view.v_ma_lohnart_zu_per_1
  WHERE lohnart_id = 'MVST'
  GROUP BY mandant_id,
   mitarbeiter_id,
   kjmo) AS lohn_mvst ON ma_bew.mitarbeiter_id = lohn_mvst.mitarbeiter_id AND ma_bew.mandant_id = lohn_mvst.mandant_id
  AND ma_bew.kjmo = lohn_mvst.kjmo
 LEFT JOIN (SELECT DISTINCT mandant_id,
   mitarbeiter_id,
   kjmo,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30', '31', '40', '53', 'BC', 'BM',
             'BR', 'BS', 'BY') OR mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30', '31'
             , '40', '53', '72') OR mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30',
            '31', '40', '53', 'D1') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30',
           '31', '40', '50', '53', 'C2', 'C3', 'CH') OR mandant_id = 7 AND hr_massnahme_id IN ('04') AND
         hr_massnahme_grund_id IN ('20', '30', '31', '40', '53', 'F0', 'F2', 'F9', 'FA', 'FC') OR mandant_id = 8 AND
         hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30', '31', '40', '53') OR mandant_id = 4 AND
        hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('53', 'I3', 'I6', 'I8', 'IG', 'IR', 'IS', 'IT', 'IU',
        'IX', 'IY')
    THEN 1
    ELSE 0
    END AS austritt_an_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '12', '13', '20', '21',
             '50', '51', '52', '54', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI'
             , 'BJ', 'BK', 'BL', 'BN', 'BO', 'BP', 'BQ') OR mandant_id = 5 AND hr_massnahme_id IN ('04') AND
            hr_massnahme_grund_id IN ('10', '11', '20', '50', '52', '54', 'B1', 'B2', 'B4', 'B5', 'E3') OR mandant_id =
            6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '12', '13', '20', '21', '50', '51'
            , '52', '54') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '12', '54'
           , 'C1', 'C5', 'C6', 'C9', 'CA', 'CB', 'CC', 'CD', 'CE') OR mandant_id = 7 AND hr_massnahme_id IN ('04') AND
         hr_massnahme_grund_id IN ('10', '11', '50', '54', 'F0', 'F1', 'F3', 'F4', 'F5', 'F7', 'F8', 'F9', 'FB', 'FC')
      OR mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '20', '21', '50', '52',
         '54', 'G3') OR mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('54', 'I0', 'I1',
        'I2', 'I5', 'I9', 'IA', 'IB', 'ID', 'IE', 'IF', 'IH', 'II', 'IJ', 'IK', 'IL', 'IM', 'IN', 'IO', 'IP', 'IQ', 'IV'
        , 'IY', 'IZ')
    THEN 1
    ELSE 0
    END AS austritt_ag_fg,
     CASE
     WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30', '31', '40', '53', 'BC', 'BM'
              , 'BR', 'BS', 'BY') OR mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30',
              '31', '40', '53', '72') OR mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30'
             , '31', '40', '53', 'D1') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30'
            , '31', '40', '50', '53', 'C2', 'C3', 'CH') OR mandant_id = 7 AND hr_massnahme_id IN ('04') AND
          hr_massnahme_grund_id IN ('20', '30', '31', '40', '53', 'F0', 'F2', 'F9', 'FA', 'FC') OR mandant_id = 8 AND
          hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30', '31', '40', '53') OR mandant_id = 4 AND
         hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('53', 'I3', 'I6', 'I8', 'IG', 'IR', 'IS', 'IT', 'IU',
         'IX', 'IY')
     THEN 1
     ELSE 0
     END + CASE
     WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '12', '13', '20', '21'
              , '50', '51', '52', '54', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH',
              'BI', 'BJ', 'BK', 'BL', 'BN', 'BO', 'BP', 'BQ') OR mandant_id = 5 AND hr_massnahme_id IN ('04') AND
             hr_massnahme_grund_id IN ('10', '11', '20', '50', '52', '54', 'B1', 'B2', 'B4', 'B5', 'E3') OR mandant_id =
             6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '12', '13', '20', '21', '50',
             '51', '52', '54') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '12'
            , '54', 'C1', 'C5', 'C6', 'C9', 'CA', 'CB', 'CC', 'CD', 'CE') OR mandant_id = 7 AND hr_massnahme_id IN ('04'
            ) AND hr_massnahme_grund_id IN ('10', '11', '50', '54', 'F0', 'F1', 'F3', 'F4', 'F5', 'F7', 'F8', 'F9', 'FB'
           , 'FC') OR mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10', '11', '20', '21'
          , '50', '52', '54', 'G3') OR mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('54',
         'I0', 'I1', 'I2', 'I5', 'I9', 'IA', 'IB', 'ID', 'IE', 'IF', 'IH', 'II', 'IJ', 'IK', 'IL', 'IM', 'IN', 'IO',
         'IP', 'IQ', 'IV', 'IY', 'IZ')
     THEN 1
     ELSE 0
     END AS austritt_fluktuation_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73', '98', '99') OR mandant_id = 5
            AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73', '98', '99') OR mandant_id = 6 AND
            hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73', '98', '99') OR mandant_id = 3 AND
           hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73', '98', '99', 'C0', 'C7', 'C8') OR mandant_id = 7
           AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73', '98', '99', 'F6', 'I4') OR mandant_id = 8
        AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '91', '98', '99') OR mandant_id = 4 AND
        hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('I4', 'I7', 'IZ')
    THEN 1
    ELSE 0
    END AS austritt_trw_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '71', '73', 'B1', 'B2') OR
             mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '71', 'E0', 'E1', 'E2') OR
            mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '71', '73') OR mandant_id =
           3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '73', 'C4', 'CF', 'CI') OR mandant_id = 7
           AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', '73', 'FD') OR mandant_id = 8 AND
         hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70', 'G2') OR mandant_id = 4 AND hr_massnahme_id IN ('04'
         ) AND hr_massnahme_grund_id IN ('73', 'I4', 'IC')
    THEN 1
    ELSE 0
    END AS austritt_vtg_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') OR mandant_id = 5 AND
           hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') OR mandant_id = 6 AND hr_massnahme_id IN ('04'
           ) AND hr_massnahme_grund_id IN ('90') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND
        hr_massnahme_grund_id IN ('90') OR mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('G1'
        )
    THEN 1
    ELSE 0
    END AS austritt_ana_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92') OR mandant_id = 5 AND
             hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92', 'B6') OR mandant_id = 6 AND hr_massnahme_id
            IN ('04') AND hr_massnahme_grund_id IN ('92') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND
          hr_massnahme_grund_id IN ('92') OR mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92'
          ) OR mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92') OR mandant_id = 4 AND
        hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')
    THEN 1
    ELSE 0
    END AS austritt_ugsi_fg,
    CASE
    WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91') OR mandant_id = 5 AND
             hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91') OR mandant_id = 6 AND hr_massnahme_id IN ('04'
             ) AND hr_massnahme_grund_id IN ('91') OR mandant_id = 3 AND hr_massnahme_id IN ('04') AND
          hr_massnahme_grund_id IN ('91', 'CG') OR mandant_id = 7 AND hr_massnahme_id IN ('04') AND
         hr_massnahme_grund_id IN ('91') OR mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91'
         ) OR mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')
    THEN 1
    ELSE 0
    END AS austritt_ugsw_fg,
    CASE
    WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('D0') OR mandant_id = 3 AND
        hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('C0')
    THEN 1
    ELSE 0
    END AS austritt_bu_fg
  FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_1 AS V095
  WHERE hr_massnahme_id = '04') AS massn_austritt ON ma_bew.mitarbeiter_id = massn_austritt.mitarbeiter_id AND ma_bew.mandant_id
     = massn_austritt.mandant_id AND ma_bew.kjmo = massn_austritt.kjmo
 LEFT JOIN (SELECT mandant_id,
   mitarbeiter_id,
   kjmo,
   SUM(CASE
     WHEN mandant_id = 2 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200', '0201', '0204', '0205', '0209',
             '0210', '0211', '0215', '0220', '0221', '0225', '0260', '0261', '0265') OR mandant_id = 5 AND
             abwesenheit_stunden > 0 AND abwesenheit_id IN ('0112', '0114', '0400', '0401', '0403', '0405', '0406',
             '0407', '0410', '0411', '0415', '0420', '0421', '0425') OR mandant_id = 3 AND abwesenheit_stunden > 0 AND
           abwesenheit_id IN ('0200', '0210', '0211', '0212', '0220', '0290', '0291', '9019', '9420', '9450') OR
           mandant_id = 7 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200', '0206', '0218', '0240', '0241',
           '0242', '0251', '0252', '0253', '0254', '0260', '0250', '9001', '9017', '9251', '9429', '9432', '9434') OR
          mandant_id = 8 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200', '0201', '0207', '0210', '0270',
          '0271', '0272', '0273', '0274', '0276', '0277', '0296', '0297') OR mandant_id = 4 AND abwesenheit_stunden > 0
       AND abwesenheit_id IN ('0200', '0240', '0241', '0250', '0254', '0260', '0296', '0297', '9001', '9010', '9017',
         '9432', '9610', '9611')
     THEN abwesenheit_stunden
     ELSE 0.00
     END) AS std_abwesenheit
  FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_1
  GROUP BY mandant_id,
   mitarbeiter_id,
   kjmo) AS abwesenh_krank ON ma_bew.mitarbeiter_id = abwesenh_krank.mitarbeiter_id AND ma_bew.mandant_id =
    abwesenh_krank.mandant_id AND ma_bew.kjmo = abwesenh_krank.kjmo
 LEFT JOIN (SELECT mandant_id,
   mitarbeiter_id,
   kjmo,
   SUM(CASE
     WHEN mandant_id = 6 AND lohnart_id IN ('6866', '6866R', '6877', '6877R', '6878', '6878R', '6734', '6734R', '6735',
        '6735R', '6853', '6853R', '6854', '6854R', '6810', '6810R')
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_abwesenheit_lohnart,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 OR
               mandant_id = 5 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0
          OR mandant_id = 6 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 OR
             mandant_id = 3 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 OR
            mandant_id = 7 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 OR
           mandant_id = 8 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 OR
          mandant_id = 4 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_soll,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('2170')
            AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 OR mandant_id = 3
             AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 7 AND lohnart_id IN ('1010') AND
          anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 4 AND
         lohnart_id IN ('1010', '2170') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_urlaub_abgeltung,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('3200',
              '3222') AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('3200', '3453') AND anzahl_lohnart > 0
            OR mandant_id = 7 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('3200'
           ) AND anzahl_lohnart > 0 OR mandant_id = 4 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_feiertag_zuschlag,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('2170')
            AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 OR mandant_id = 3
             AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 7 AND lohnart_id IN ('1010') AND
          anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 4 AND
         lohnart_id IN ('1010', '2170') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_mehr_zuschlag,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('2170')
            AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 OR mandant_id = 3
             AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 7 AND lohnart_id IN ('1010') AND
          anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 4 AND
         lohnart_id IN ('1010', '2170') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_nacht_zuschlag,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('2170')
            AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 OR mandant_id = 3
             AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 7 AND lohnart_id IN ('1010') AND
          anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 4 AND
         lohnart_id IN ('1010', '2170') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_wochenend_zuschlag,
   SUM(CASE
     WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 5 AND lohnart_id IN ('2170')
            AND anzahl_lohnart > 0 OR mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 OR mandant_id = 3
             AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 7 AND lohnart_id IN ('1010') AND
          anzahl_lohnart > 0 OR mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 OR mandant_id = 4 AND
         lohnart_id IN ('1010', '2170') AND anzahl_lohnart > 0
     THEN anzahl_lohnart
     ELSE 0.00
     END) AS std_mehr_ausbezahlt
  FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_1
  GROUP BY mandant_id,
   mitarbeiter_id,
   kjmo) AS kost_lohn ON ma_bew.mitarbeiter_id = kost_lohn.mitarbeiter_id AND ma_bew.mandant_id = kost_lohn.mandant_id
  AND ma_bew.kjmo = kost_lohn.kjmo
 LEFT JOIN kfl_production_dbp_view.v_l_org_einheit_1 AS ORG_EH ON ma_bew.hr_objekt_id = ORG_EH.hr_objekt_id AND ma_bew.mandant_id
    = ORG_EH.mandant_id
WHERE ma_bew.mandant_id > 1;