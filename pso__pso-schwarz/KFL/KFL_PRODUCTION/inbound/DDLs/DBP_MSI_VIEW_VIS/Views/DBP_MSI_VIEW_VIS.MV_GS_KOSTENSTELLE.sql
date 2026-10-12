CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_KOSTENSTELLE
 AS
    -- LOOKUP/SPRACHE Kostenstelle fuer Geschenk-Karten
    -- Bezeichnung nur in Sprache DE verfuegbar
    -- 2010KW17 GSS Redesign + Rollout KMO
    -- 20130508 Review : Anpassung Kostenstelle/Buchungskreis
    -- 20140729 Incident : Anpassung/Erweiterung Mapping Gastro Kostenstellen
    -- 20160301 FIX : Ausnahme Like -800 angepasst, da geaendertes Feldformat mit trailing Space
    -- 2017.0727 ssch0611 : Neue Logik: Mapping mit Transaktion 4 - AP0017681/SPEC0023484

    SELECT
    sub01.mandant_id, sub01.nb_id, sub01.wup_id, sub01.buchungskreis_id, sub01.gs_kostenstelle_id, sub01.gs_kostenstelle_bez
    FROM (
    -- Teil 1 : Filiale
    SELECT DISTINCT
    wp01.mandant_id, wp01.wup_id, wp01.nb_id, wp01.buchungskreis_id AS buchungskreis_id, gss.kostenstelle_id   AS gs_kostenstelle_id, wp01.wup_standort     AS gs_kostenstelle_bez,
    CASE -- Anpassung GS Gastro Kostenstellen
    WHEN SUBSTRING(gss.kostenstelle_id, 6, 3) = '200' AND SUBSTRING(gss.kostenstelle_id, 1, 1) NOT IN ('0','9')
    THEN SUBSTRING(gss.kostenstelle_id, 1, 4) + 2
    ELSE SUBSTRING(gss.kostenstelle_id, 1, 4)
    END AS gs_wup_id
    FROM dbp_view.v_gutschein gss
    INNER JOIN (
    SELECT mandant_id, nb_id, wup_id, wup_standort, buchungskreis_id FROM dbp_view.v_wup
    WHERE nb_id IN (-2, -1, 0, 2, 7) AND dat_eroeffnung > CAST('1900-01-01' AS DATE) AND dat_von > CAST('1900-01-01' AS DATE)
    ) wp01
    ON wp01.mandant_id = gss.mandant_id  AND wp01.wup_id = CASE -- Anpassung GS Gastro Kostenstellen
                                                             WHEN SUBSTRING(gss.kostenstelle_id, 6, 3) = '200' AND SUBSTRING(gss.kostenstelle_id, 1, 1) NOT IN ('0','9')
                                                              THEN SUBSTRING(gss.kostenstelle_id, 1, 4) + 2
                                                              ELSE SUBSTRING(gss.kostenstelle_id, 1, 4)
                                                              END
   WHERE gss.transaktion_id = 4

    UNION ALL -- Teil 2 : nicht Filiale
    SELECT DISTINCT
    gss.mandant_id, 0::INTEGER      AS wup_id, -1::SMALLINT    AS nb_id, CASE
    WHEN gss.mandant_id = 1 AND CONTAINS( gss.kostenstelle_id, '-800P') THEN 1
    WHEN gss.mandant_id = 1 AND CONTAINS( gss.kostenstelle_id, '-800') THEN 100
    ELSE COALESCE(ikp.buchungskreis_id, 0)
    END AS buchungskreis_id, gss.kostenstelle_id                                    AS gs_kostenstelle_id, COALESCE(iksz.kostenstelle_bez, gss.kostenstelle_id)   AS gs_kostenstelle_bez, SUBSTRING(gss.kostenstelle_id, 1, 4)::SMALLINT AS gs_wup_id
    FROM dbp_view.v_gutschein gss
    LEFT JOIN (
    SELECT mandant_id, kostenstelle_id, buchungskreis_id
    FROM dbp_view.v_in_kostenstelle_per
    WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT mandant_id, kostenstelle_id, MAX(dat_bis)FROM dbp_view.v_in_kostenstelle_per GROUP BY mandant_id, kostenstelle_id)
    ) ikp
    ON ikp.mandant_id = gss.mandant_id AND ikp.kostenstelle_id = gss.kostenstelle_id
    LEFT JOIN (
    SELECT mandant_id, kostenstelle_id, kostenstelle_bez
    FROM dbp_view.v_in_kostenstelle_spr_zu_per
    WHERE (mandant_id, kostenstelle_id, dat_bis) IN (SELECT mandant_id, kostenstelle_id, MAX(dat_bis)FROM dbp_view.v_in_kostenstelle_per GROUP BY mandant_id, kostenstelle_id)
    AND spr_id = 22
    ) iksz
    ON iksz.mandant_id = gss.mandant_id
    AND iksz.kostenstelle_id = gss.kostenstelle_id

    WHERE gss.transaktion_id = 4
    AND (gss.mandant_id, gs_wup_id) NOT IN (SELECT mandant_id, wup_id FROM dbp_view.v_wup WHERE nb_id IN (-2, -1, 0, 2, 7) AND dat_eroeffnung > CAST('1900-01-01' AS DATE) AND dat_von > CAST('1900-01-01' AS DATE))

    ) sub01
    ;