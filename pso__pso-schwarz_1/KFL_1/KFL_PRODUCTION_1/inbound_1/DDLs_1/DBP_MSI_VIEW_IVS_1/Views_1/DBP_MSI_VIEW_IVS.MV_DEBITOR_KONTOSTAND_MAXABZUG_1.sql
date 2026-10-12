CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_DEBITOR_KONTOSTAND_MAXABZUG_1
   AS
      -- 2009-06-15
      -- FAKTVIEW Debitor Kontostand/Salden (KJMO)
      -- 2009KW17 EUR + LW über waehrungstyp
      -- 2009KW27 Historisierung Kurs_1
      -- 2009KW47 Umstellung mv_zeit_1 auf v_monat_1
      -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten

      SELECT
      dk.mandant_id,
      dk.debitor_id,
      dk.kjmo,
      sub01.last_abzug_id         AS abzug_id,
      dk.saldo_vortrag * kurs_1     AS saldo_vortrag,
      dk.summe_soll * kurs_1        AS summe_soll,
      dk.summe_haben * kurs_1       AS summe_haben,
      sub01.summe_haben_10 * kurs_1 AS summe_haben_abzug_10,
      sub01.summe_haben_20 * kurs_1 AS summe_haben_abzug_20,
      sub01.summe_haben_30 * kurs_1 AS summe_haben_abzug_30,
      sub01.summe_haben_0 * kurs_1  AS summe_haben_abzug_0,
      dk.saldo_soll * kurs_1        AS saldo_soll,
      dk.saldo_haben * kurs_1       AS saldo_haben,
      dk.saldo_konto * kurs_1       AS saldo_konto,
      kurs.wrg_id,
      kurs.wrg_typ_id
     --, dk.buchungskreis_id NOT USED --
     --, dk.sonderhauptbuch_id NOT USED --
     FROM
      dbp_view.v_ivs_debitor_kontostand_1  dk

      JOIN ( -- Ermittlung der letzen Abzug_id, Verteilung Haben auf Abzug
      SELECT
      mandant_id,
      debitor_id,
      kjmo,
      CASE WHEN MIN(abzug_id) = 0 THEN 0 ELSE MAX(abzug_id) END AS last_abzug_id,
      SUM(CASE WHEN abzug_id = 10 THEN summe_haben ELSE 0 END)  AS summe_haben_10,
      SUM(CASE WHEN abzug_id = 20 THEN summe_haben ELSE 0 END)  AS summe_haben_20,
      SUM(CASE WHEN abzug_id = 30 THEN summe_haben ELSE 0 END)  AS summe_haben_30,
      SUM(CASE WHEN abzug_id =  0 THEN summe_haben ELSE 0 END)  AS summe_haben_0
     FROM dbp_view.v_ivs_debitor_kontostand_1

     GROUP BY
     mandant_id
     , debitor_id
     , kjmo
     ) sub01
      ON dk.mandant_id = sub01.mandant_id
      AND dk.debitor_id = sub01.debitor_id
      AND dk.kjmo = sub01.kjmo
      AND dk.abzug_id = sub01.last_abzug_id
      INNER JOIN dbp_view.v_monat_1  zeit_1
      ON zeit.kjmo = dk.kjmo
      INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1  kurs_1
      ON kurs.mandant_id = dk.mandant_id;