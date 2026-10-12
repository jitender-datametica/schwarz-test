CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_COCKPIT_WUP(
      MANDANT_ID,
      NB_ID,
      WUP_ID,
      WRG_ID,
      COCKPIT_VARIANTE,
      EXPBER_FG,
      UMS_DAT_VON,
      UMS_DAT_BIS,
      UMS_ZEIT_AKT,
      UMS_ZEIT_VOR,
      UMS_NETTO_WUP_AKT,
      UMS_NETTO_WUP_VOR,
      UMS_NETTO_WUP_ABW,
      UMS_NETTO_RANG,
      UMS_NETTO_NAT,
      UMS_NETTO_MIN,
      UMS_NETTO_MAX,
      ABS_DAT_VON,
      ABS_DAT_BIS,
      ABS_ZEIT_AKT,
      ABS_ZEIT_VOR,
      ABS_BRUTTO_WUP_AKT,
      ABS_UMSATZ_WUP_AKT,
      ABS_BRUTTO_WUP_VOR,
      ABS_UMSATZ_WUP_VOR,
      ABS_QUOTE_WUP,
      ABS_QUOTE_RANG,
      ABS_QUOTE_NAT,
      ABS_QUOTE_NAT_AKT,
      ABS_QUOTE_NAT_VOR,
      KUGA_DAT_VON,
      KUGA_DAT_BIS,
      KUGA_ZEIT_AKT,
      KUGA_ZEIT_VOR,
      KUGA_WUP_AKT,
      KUGA_WUP_VOR,
      KUGA_WUP_ABW,
      KUGA_RANG,
      KUGA_NAT,
      KUGA_MIN,
      KUGA_MAX,
      PK_DAT_VON,
      PK_DAT_BIS,
      PK_ZEIT_AKT,
      PK_ZEIT_VOR,
      PK_KOSTEN_WUP_AKT,
      PK_UMSATZ_WUP_AKT,
      PK_KOSTEN_WUP_VOR,
      PK_UMSATZ_WUP_VOR,
      PK_QUOTE_WUP,
      PK_QUOTE_RANG,
      PK_QUOTE_NAT,
      PK_QUOTE_NAT_AKT,
      PK_QUOTE_NAT_VOR,
      KUNDE_WUP_AKT,
      KUNDE_WUP_VOR,
      KUNDE_WUP_ABW,
      KUNDE_RANG,
      KUNDE_NAT,
      KUNDE_MIN,
      KUNDE_MAX
) AS
   -- FAKT/AGGREGAT VIS Cockpit (Umsatz, Abschrift, Kundengarantie, Personal) pro wup
   -- Unterschiedliche Zeitraume, Variante monatlich (0) bzw. GJ kum. (1)
   -- 2011KW07 INITIAL
   -- 2011-02-11 laufender Monat + Erweiterung PK
   -- 2011-03-11 Erweiterung kum. Sicht (cockpit_variante)
   -- 2012KW28 Kundenzahlenerweiterung (view-loesung)

SELECT
   v01.mandant_id
   , v01.nb_id
   , v01.wup_id
   , v01.wrg_id
   , v01.cockpit_variante
   , v01.exp_ber_fg  AS expber_fg
   , v01.ums_dat_von
   , v01.ums_dat_bis
   , CAST('(' || CAST(v01.ums_dat_von AS VARCHAR) || ' - ' || CAST(v01.ums_dat_bis AS VARCHAR) || ')' AS VARCHAR(30)) AS ums_zeit_akt
   , CAST('(' || CAST((v01.ums_dat_von - 364) AS VARCHAR) || ' - ' || CAST((v01.ums_dat_bis - 364) AS VARCHAR) || ')' AS VARCHAR(30)) AS ums_zeit_vor
   , v01.ums_netto_wup_akt
   , v01.ums_netto_wup_vor
   , v01.ums_netto_wup_abw
   , v01.ums_netto_rang
   , v01.ums_netto_nat
   , v01.ums_netto_min
   , v01.ums_netto_max
   , v01.abs_dat_von
   , v01.abs_dat_bis
   , CAST('(' || CAST(v01.abs_dat_von AS VARCHAR) || ' - ' || CAST(v01.abs_dat_bis AS VARCHAR) || ')' AS VARCHAR(30)) AS abs_zeit_akt
   , CAST('(' || CAST((v01.abs_dat_von - 364) AS VARCHAR) || ' - ' || CAST((v01.abs_dat_bis - 364) AS VARCHAR) || ')' AS VARCHAR(30)) AS abs_zeit_vor
   , v01.abs_brutto_wup_akt
   , v01.abs_umsatz_wup_akt
   , v01.abs_brutto_wup_vor
   , v01.abs_umsatz_wup_vor
   , v01.abs_quote_wup
   , v01.abs_quote_rang
   , v01.abs_quote_nat
   , v01.abs_quote_nat_akt
   , v01.abs_quote_nat_vor
   , v01.kuga_dat_von
   , v01.kuga_dat_bis
   , CAST('(' || CAST(NULLIF(v01.kuga_dat_von, '1900-01-01') AS VARCHAR) || ' - ' || CAST(v01.kuga_dat_bis AS VARCHAR) || ')' AS VARCHAR(30)) AS kuga_zeit_akt
   , CAST('(' || CAST((NULLIF(v01.kuga_dat_von, '2091-01-01') - 364) AS VARCHAR) || ' - ' || CAST((v01.kuga_dat_bis - 364) AS VARCHAR) || ')' AS VARCHAR(30)) AS kuga_zeit_vor
   , v01.kuga_wup_akt
   , v01.kuga_wup_vor
   , v01.kuga_wup_abw
   , v01.kuga_rang
   , v01.kuga_nat
   , v01.kuga_min
   , v01.kuga_max
   , v01.pk_dat_von
   , v01.pk_dat_bis
   , CAST('(' || CAST(v01.pk_dat_von AS VARCHAR) || ' - ' || CAST(v01.pk_dat_bis AS VARCHAR) || ')' AS VARCHAR(30)) AS pk_zeit_akt
   , CAST('(' || CAST(ADD_MONTHS(v01.pk_dat_von, -12) AS VARCHAR) || ' - ' || CAST(ADD_MONTHS(v01.pk_dat_bis, -12) AS VARCHAR) || ')' AS VARCHAR(30)) AS pk_zeit_vor
   , v01.pk_kosten_wup_akt
   , v01.pk_umsatz_wup_akt
   , v01.pk_kosten_wup_vor
   , v01.pk_umsatz_wup_vor
   , v01.pk_quote_wup
   , v01.pk_quote_rang
   , v01.pk_quote_nat
   , v01.pk_quote_nat_akt
   , v01.pk_quote_nat_vor
   , sub01.kunde_wup_akt
   , sub01.kunde_wup_vor
   , sub01.kunde_wup_abw
   , sub01.kunde_rang
   , sub01.kunde_nat
   , sub01.kunde_min
   , sub01.kunde_max
FROM dbp_msi_v_view.v_vis_cockpit_wup  v01

LEFT JOIN (
   SELECT
      v00.mandant_id
      , v00.nb_id
      , v00.wup_id
      , v02.expber_fg
      , v01.wrg_id, 0 AS cockpit_variante
      , v01.kunde_dat_von
      , v01.kunde_dat_bis
      , v01.kunde_wup_akt
      , v01.kunde_wup_vor
      , ZEROIFNULL(((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000) 
         / CASE WHEN kunde_wup_vor * expber_fg = 0 
            THEN NULL 
            ELSE kunde_wup_vor * expber_fg 
         END) AS kunde_wup_abw
      , expber_fg * RANK() OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, expber_fg DESC NULLS LAST, COALESCE(kunde_wup_abw, -9999) DESC NULLS LAST) AS kunde_rang -- TopNachFlopRank
      , SUM(v01.kunde_wup_akt * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_nat_ist
      , SUM(v01.kunde_wup_vor * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_nat_wvj
      , MIN(kunde_wup_abw) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_min
      , MAX(kunde_wup_abw) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_max
      , ZEROIFNULL(
         (
            (
               CASE WHEN kunde_nat_ist = 0 THEN NULL ELSE kunde_nat_ist END - CASE WHEN kunde_nat_wvj = 0 THEN NULL ELSE kunde_nat_wvj END
            ) 
            * 100.0000
         ) 
         / CASE WHEN kunde_nat_wvj = 0 THEN NULL ELSE kunde_nat_wvj END
      ) AS kunde_nat
   FROM dbp_view.v_wup v00
   
   JOIN (
      SELECT
         r1.mandant_id
         , r1.nb_id
         , r1.wup_id
         , MIN(r1.altersstruktur_tag_id) AS alter_min
         , CASE WHEN alter_min < 3 THEN 1 ELSE 0 END AS expber_fg
      FROM dbp_msi_v_view.v_altersstruktur_eis  r1
      WHERE r1.nb_id = 0
      GROUP BY
         r1.mandant_id
         , r1.nb_id
         , r1.wup_id
   ) v02
   ON v00.mandant_id = v02.mandant_id
   AND v00.wup_id = v02.wup_id

   JOIN (
      SELECT
         v1.mandant_id
         , v1.nb_id
         , v1.wup_id
         , v1.wrg_id             AS wrg_id
         , MIN(v2.dat)           AS kunde_dat_von
         , MAX(v2.dat)           AS kunde_dat_bis
         , SUM(v1.anz_kunde)     AS kunde_wup_akt
         , SUM(v1.anz_kunde_wvj) AS kunde_wup_vor
      FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup v1
      
      INNER JOIN dbp_view.v_tag  v2
      ON v1.dat = v2.dat
      AND v2.akt_mo = 0
      AND v2.akt_tag <= 0
      
      WHERE nb_id = 0
      GROUP BY
         v1.mandant_id
         , v1.nb_id
         , v1.wup_id
         , v1.wrg_id
   ) v01
   ON v00.mandant_id = v01.mandant_id
   AND v00.wup_id = v01.wup_id

   WHERE v00.dat_eroeffnung > '1900-01-01'
   AND v00.nb_id = 0
   -- kumuliert
   
   UNION ALL
   
   SELECT
      v00.mandant_id
      , v00.nb_id
      , v00.wup_id
      , v02.expber_fg
      , v01.wrg_id, 1 AS cockpit_variante
      , v01.kunde_dat_von
      , v01.kunde_dat_bis
      , v01.kunde_wup_akt
      , v01.kunde_wup_vor
      , ZEROIFNULL(((v01.kunde_wup_akt - v01.kunde_wup_vor) * 100.0000) / CASE WHEN kunde_wup_vor * expber_fg = 0 THEN NULL ELSE kunde_wup_vor * expber_fg END) AS kunde_wup_abw
      , expber_fg * RANK() OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, expber_fg DESC NULLS LAST, COALESCE(kunde_wup_abw, -9999) DESC NULLS LAST) AS kunde_rang -- TopNachFlopRank
      , SUM(v01.kunde_wup_akt * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_nat_ist
      , SUM(v01.kunde_wup_vor * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_nat_wvj
      , MIN(kunde_wup_abw) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_min
      , MAX(kunde_wup_abw) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) AS kunde_max
      , ZEROIFNULL(((CASE WHEN kunde_nat_ist = 0 THEN NULL ELSE kunde_nat_ist END - CASE WHEN kunde_nat_wvj = 0 THEN NULL ELSE kunde_nat_wvj END) * 100.0000) / CASE WHEN kunde_nat_wvj = 0 THEN NULL ELSE kunde_nat_wvj END) AS kunde_nat
   FROM dbp_view.v_wup v00
   
   JOIN (
      SELECT
         r1.mandant_id
         , r1.nb_id
         , r1.wup_id
         , MIN(r1.altersstruktur_tag_id) AS alter_min
         , CASE WHEN alter_min < 3 THEN 1 ELSE 0 END AS expber_fg
      FROM dbp_msi_v_view.v_altersstruktur_eis  r1
      WHERE r1.nb_id = 0
      GROUP BY
         r1.mandant_id
         , r1.nb_id
         , r1.wup_id
   ) v02
   ON v00.mandant_id = v02.mandant_id
   AND v00.wup_id = v02.wup_id

   JOIN (
      SELECT
         v1.mandant_id
         , v1.nb_id
         , v1.wup_id
         , v1.wrg_id             AS wrg_id
         , MIN(v2.dat)           AS kunde_dat_von
         , MAX(v2.dat)           AS kunde_dat_bis
         , SUM(v1.anz_kunde)     AS kunde_wup_akt
         , SUM(v1.anz_kunde_wvj) AS kunde_wup_vor
      FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup v1
      INNER JOIN dbp_view.v_tag  v2
      ON v1.dat = v2.dat
      AND v2.akt_gj = 0
      AND v2.akt_tag <= 0
      WHERE nb_id = 0
      GROUP BY
         v1.mandant_id
         , v1.nb_id
         , v1.wup_id
         , v1.wrg_id
   ) v01
   ON v00.mandant_id = v01.mandant_id
   AND v00.wup_id = v01.wup_id

   WHERE v00.dat_eroeffnung > '1900-01-01'
   AND v00.nb_id = 0
   ) sub01
   ON v01.mandant_id = sub01.mandant_id
   AND v01.wup_id = sub01.wup_id
   AND v01.wrg_id = sub01.wrg_id
   AND v01.cockpit_variante = sub01.cockpit_variante
   ;