CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_IST_SOLL
 AS
    --MC: 17.10.2013: Inital - Basis für einen temporäre Sonderanfrage
    --MC: 21.10.2013: Einbau der COALESCE-Statement bei plan_zeit_pep und fehl_zeit inkl. Umbau auf LEFT OUTER JOIN
    --MC: 08.11.2013: Abbildung Planumsätze in der Zukunft (Right Outer Join auf v05)
    --MC: 18.11.2013: Abbildung Planumsätze in der Zukunft  (Left Outer Join auf v03)

    SELECT
      v05.mandant_id, v01.idcompany, v05.wup_id, v05.dat, v01.anz_pzw_ma, v01.anz_nzw_ma, v03.umsatz_brutto, v05.ums_brutto_plan_dwh, v05.ums_brutto_plan_hl, v02.ist_zeit_stupf, COALESCE(v01.plan_zeit_pep,0) AS plan_zeit_pep, COALESCE(v04.fehl_zeit,0) AS fehl_zeit

    FROM
    --fortschreiben anzahl mitarbeiter und planzeiten
    (
    SELECT
      1 AS mandant_id, p.idcompany AS idcompany, w.wup_id AS wup_id, p.dat AS dat, SUM(CASE WHEN p.pzw_fg = 1 THEN 1 ELSE 0 END) AS anz_pzw_ma, SUM(CASE WHEN p.pzw_fg <> 1 THEN 1 ELSE 0 END) AS anz_nzw_ma, SUM(p.nettozeit) AS plan_zeit_pep

    FROM dbp_view.v_pep_planung p
    INNER JOIN dbp_view.v_pep_filiale w
    ON p.idcompany = w.idcompany
    INNER JOIN dbp_view.v_pep_personal pers
    ON p.idpersonal = pers.idpersonal

    WHERE (pers.dat_austritt IS NULL OR pers.dat_austritt > p.dat)
    --AND p.dat BETWEEN 1131009 AND 1131031

    GROUP BY 1,2,3,4
    ) v01
    LEFT OUTER JOIN
    (
    SELECT
      1 AS mandant_id, dt1.idcompany AS idcompany, dt1.buchungsdatum AS dat,
      --  SUM ( EXTRACT (HOUR FROM (dt2.zeit_kom_geh - dt1.zeit_kom_geh HOUR(2) TO SECOND)) * 3600 + EXTRACT (MINUTE FROM (dt2.zeit_kom_geh - dt1.zeit_kom_geh HOUR(2) TO SECOND)) * 60 + EXTRACT (SECOND FROM (dt2.zeit_kom_geh - dt1.zeit_kom_geh HOUR(2) TO SECOND)) ) / 3600
   -- AS ist_zeit_stupf
      timediff('second',dt1.zeit_kom_geh,dt2.zeit_kom_geh)/3600 AS ist_zeit_stupf
  FROM
  (
  SELECT
    t01.*, CAST((zeit_kom_geh - (INTERVAL '3 hour' ) ) AS DATE) buchungsdatum, SUM(1) OVER (PARTITION BY idpersonal, idcompany, buchungsdatum ORDER BY zeit_kom_geh ROWS UNBOUNDED PRECEDING) AS order_num
    FROM dbp_view.v_pep_personal_bew t01
    ) dt1
    INNER JOIN
    (
    SELECT
      t02.*, CAST((zeit_kom_geh - (INTERVAL '3 hour' ) ) AS DATE) AS buchungsdatum, SUM(1) OVER (PARTITION BY idpersonal , idcompany,buchungsdatum ORDER BY zeit_kom_geh ROWS UNBOUNDED PRECEDING)-1 AS order_num
    FROM dbp_view.v_pep_personal_bew t02
    ) dt2
    ON dt1.idpersonal = dt2.idpersonal
    AND dt1.idcompany = dt2.idcompany
    AND dt1.order_num = dt2.order_num
    AND dt1.buchungsdatum = dt2.buchungsdatum
    INNER JOIN dbp_view.v_pep_personal_per pp
    ON  dt1.idpersonal = pp.idpersonal
    AND dt1.buchungsdatum BETWEEN pp.dat_von AND pp.dat_bis

    WHERE dt1.kom_geh_fg = 0
    AND dt2.kom_geh_fg = 1
    --AND dt1.idcompany IN (2450)
    --AND dt1.buchungsdatum BETWEEN 1131009 AND 1131031
   -- GROUP BY 1,2,3
    ) v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.dat = v02.dat
    AND v01.idcompany = v02.idcompany
    LEFT OUTER JOIN
    (
    SELECT
      o.mandant_id AS mandant_id, o.wup_id AS wup_id, o.dat AS dat, SUM(o.umsatz_brutto) AS umsatz_brutto
    FROM dbp_v_ods.v_ods_bon_agg_15min o
    WHERE o.mandant_id = 1
    --AND wup_id IN (3070,3180,4400,3940)
    --AND o.dat BETWEEN 1131015 AND 1131031
    AND o.kasse_nr BETWEEN 1 AND 49
    GROUP BY 1,2,3
    ) v03
    ON v01.mandant_id = v03.mandant_id
    AND v01.dat = v03.dat
    AND v01.wup_id = v03.wup_id
    LEFT OUTER JOIN
    (
    SELECT
    1 AS mandant_id, p.idcompany AS idcompany, p.dat AS dat, SUM(nettozeit) AS fehl_zeit
    FROM dbp_view.v_pep_planung p
    INNER JOIN dbp_view.v_pep_planung_fehlgrund f
    ON p.idpersonal = f.idpersonal
    AND p.idcompany = f.idcompany
    AND p.dat = f.dat
    --WHERE p.dat BETWEEN 1131009 AND 1131031
    GROUP BY 1,2,3
    ) v04
    ON v01.mandant_id = v04.mandant_id
    AND v01.dat = v04.dat
    AND v01.idcompany = v04.idcompany
    RIGHT OUTER JOIN
    (
    SELECT
    pep.mandant_id AS mandant_id, pep.wup_id AS wup_id, pep.dat_plan AS dat, SUM(ums_brutto_plan) AS ums_brutto_plan_dwh, SUM(ums_brutto_plan_man) AS ums_brutto_plan_hl

    FROM dbp_msi_v_view.v_pep_plan_tag pep
    WHERE pep.mandant_id = 1
    --AND pep.dat_plan BETWEEN 1131009 AND 1131031
    GROUP BY 1,2,3
    ) v05
    ON v01.mandant_id = v05.mandant_id
    AND v01.dat = v05.dat
    AND v01.wup_id = v05.wup_id

    ;