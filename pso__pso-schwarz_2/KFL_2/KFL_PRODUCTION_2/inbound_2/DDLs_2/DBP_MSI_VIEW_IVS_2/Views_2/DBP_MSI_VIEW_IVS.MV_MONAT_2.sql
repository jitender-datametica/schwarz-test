CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MONAT_2
                    AS
                       -- 2008-12-15 NEU
                       -- FAKTVIEW Zeit_2 (Monat_2)
                       -- Dynamisch letzte 5 und folgendes GJ
                       -- Ergänzungen: Monatsbeginn/Ende, Buchungsschluss KER
                       --  2009-11-30 Abbildung vom Halbjahr
                       --  2010-08-06 Anpassung Join auf buchungstatus_ker von inner auf left, damit keine Daten herausfallen. Coalesce auf feld akt_buchungs_schluss

                       SELECT
                       m.kjmo,
                       m.kj,
                       m.mo_kj,
                       TO_DATE(CAST(kjmo AS CHAR(6)), 'YYYYMM') AS dat_mo_beginn,
                       ADD_MONTHS(dat_mo_beginn, 1) - 1                    AS dat_mo_ende,
                       m.gjmo,
                       m.gj,
                       m.mo_gj,
                       m.akt_gj,
                       m.akt_gj_komplett,
                       m.akt_mo,
                       m.akt_mo_komplett,
                       COALESCE(k.akt_buchungs_schluss, 99) AS akt_buchungs_schluss,
                       TRIM(s.mo_bez)                                      AS mo_bez,
                       TRIM(s.mo_bez) || ' ' || TRIM(m.kj)                 AS mo_bez_land,
                       SUBSTRING(TRIM(s.mo_bez), 1, 3) || ' ' || SUBSTRING(CAST(kj AS CHAR(4)), 3, 4)         AS mo_bez_kurz,
                       s.spr_id,
                       CASE WHEN MOD( kjmo, 100) <= 6 THEN 1 ELSE 2 END AS hj

                       FROM dbp_view.v_monat_2 m
                       LEFT JOIN dbp_view.v_l_buchungsstatus_ker_2 k
                       ON    m.kjmo = k.kj_ker_mo_id
                       INNER JOIN dbp_view.v_monat_spr_zu_2 s
                       ON    m.mo_kj = s.mo_id
                       AND   s.spr_id=22

                       WHERE m.akt_gj BETWEEN -5 AND 1;