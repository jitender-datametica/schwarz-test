CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_GUTSCHEIN_1
AS
   -- FAKT Geschenk-Karten [gutschein_1] - angereichert
   -- Stammdaten Kostenstelle [st_kostenstelle_per/kostenstelle_per_1]
   -- Stammdaten Markt [wup_1]
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2010KW42PU Anpassung Anreicherung (gs_ID + gs_BEZ)
   -- 2011KW47 Anpassung Dummy_1 
   -- 20130508 Review : Anpassung Kostenstelle/Buchungskreis
   -- 2017.0727 ssch0611 : Neue Logik: Mapping mit Transaktion 4 - AP0017681/SPEC0023484

   SELECT
   gss.mandant_id, gss.gutschein_id, gss.zeitstempel, CAST(gss.zeitstempel AS VARCHAR) AS dat, CAST(gss.zeitstempel AS TIME(6))                  AS uhrzeit, gss.system_id, gss.profil_id, gss.ereignisquelle_id, gss.transaktion_id  --> Status_1
   , gss.ausgeber_typ_id  --> Bereich
   , CASE WHEN gss.ausgeber_id IN('',' ') THEN '0' ELSE gss.ausgeber_id END::VARCHAR(10) AS ausgeber_id --> Grund
   , gss.wrg_id, 1::INTEGER          AS gutschein_anzahl, gss.betrag_gutschein AS gutschein_betrag, kstl.wup_id, kstl.nb_id, kstl.buchungskreis_id, kstl.gs_kostenstelle_id, kstl.gs_kostenstelle_bez, gss.kostenstelle_id  AS kostl_gss, SUBSTRING(gss.kostenstelle_id, 1, 4)::CHAR(4) AS kostl_wup
   FROM dbp_view.v_gutschein_1 gss
   INNER JOIN
   ( -- Teil 1 : Filiale
   SELECT
         DISTINCT wp01.mandant_id,
         wp01.wup_id,
         wp01.nb_id,
         gss.gutschein_id,
         wp01.buchungskreis_id AS buchungskreis_id,
         gss.kostenstelle_id AS gs_kostenstelle_id,
         wp01.wup_standort AS gs_kostenstelle_bez,
         CASE
            
            WHEN SUBSTRING(gss.kostenstelle_id, 6, 3) = '200' 
            -- IFNULL Anpassung für Snowflake
            AND SUBSTRING(gss.kostenstelle_id, 1, 1) NOT IN ('0', '9') THEN IFNULL(
               try_to_numeric(SUBSTRING(gss.kostenstelle_id, 1, 4)) + 2,
               2
            )
            ELSE IFNULL(
               try_to_numeric(SUBSTRING(gss.kostenstelle_id, 1, 4)),
               0
            )
         END :: SMALLINT AS gs_wup_id
      FROM
         dbp_view.v_gutschein_1 gss
         INNER JOIN (
            SELECT
               mandant_id,
               nb_id,
               wup_id,
               wup_standort,
               buchungskreis_id
            FROM
               dbp_view.v_wup_1
            WHERE
               nb_id IN (-2, -1, 0, 2, 7)
               AND dat_eroeffnung > '1900-01-01'
               AND dat_von > '1900-01-01'
         ) wp01 ON wp01.mandant_id = gss.mandant_id
         -- Anpassung für Snowflake: CASE WHEN muss ausgeschrieben werden und kann nicht als Spalte aus dem Select übernommen werden
         AND wp01.wup_id = CASE
            
            WHEN SUBSTRING(gss.kostenstelle_id, 6, 3) = '200' 
            
            AND SUBSTRING(gss.kostenstelle_id, 1, 1) NOT IN ('0', '9') THEN IFNULL(
               try_to_numeric(SUBSTRING(gss.kostenstelle_id, 1, 4)) + 2,
               2
            )
            ELSE IFNULL(
               try_to_numeric(SUBSTRING(gss.kostenstelle_id, 1, 4)),
               0
            )
         END :: SMALLINT
      WHERE
         gss.transaktion_id = 4
      UNION
      ALL 
      SELECT
         DISTINCT gss.mandant_id,
         0 :: INTEGER AS wup_id,
         -1 :: SMALLINT AS nb_id,
         gss.gutschein_id,
         CASE
            WHEN gss.mandant_id = 1
            AND CONTAINS(gss.kostenstelle_id, '-800P') THEN 1
            WHEN gss.mandant_id = 1
            AND CONTAINS(gss.kostenstelle_id, '-800') THEN 100
            ELSE COALESCE(ikp.buchungskreis_id, 0)
         END AS buchungskreis_id,
         gss.kostenstelle_id AS gs_kostenstelle_id,
         COALESCE(iksz.kostenstelle_bez, gss.kostenstelle_id) AS gs_kostenstelle_bez,
         -- Anpassung für Snowflake: Leerstring wird nicht wie in TD implizit zu 0 konvertiert wie bei TD. Daher hier mit IIF
         IFF(SUBSTRING(gss.kostenstelle_id, 1, 4) = '',0,SUBSTRING(gss.kostenstelle_id, 1, 4))  :: SMALLINT AS gs_wup_id
      FROM
         dbp_view.v_gutschein_1 gss
         LEFT JOIN (
            SELECT
               mandant_id,
               kostenstelle_id,
               buchungskreis_id
            FROM
               dbp_view.v_in_kostenstelle_per_1
            WHERE
               (mandant_id, kostenstelle_id, dat_bis) IN (
                  SELECT
                     mandant_id,
                     kostenstelle_id,
                     MAX(dat_bis)
                  FROM
                     dbp_view.v_in_kostenstelle_per_1
                  GROUP BY
                     mandant_id,
                     kostenstelle_id
               )
         ) ikp ON ikp.mandant_id = gss.mandant_id
         AND ikp.kostenstelle_id = gss.kostenstelle_id
         LEFT JOIN (
            SELECT
               mandant_id,
               kostenstelle_id,
               kostenstelle_bez
            FROM
               dbp_view.v_in_kostenstelle_spr_zu_per_1
            WHERE
               (mandant_id, kostenstelle_id, dat_bis) IN (
                  SELECT
                     mandant_id,
                     kostenstelle_id,
                     MAX(dat_bis)
                  FROM
                     dbp_view.v_in_kostenstelle_per_1
                  GROUP BY
                     mandant_id,
                     kostenstelle_id
               )
               AND spr_id = 22
         ) iksz ON iksz.mandant_id = gss.mandant_id
         AND iksz.kostenstelle_id = gss.kostenstelle_id
      WHERE
         gss.transaktion_id = 4
         AND (gss.mandant_id, gs_wup_id) NOT IN (
            SELECT
               mandant_id,
               wup_id
            FROM
               dbp_view.v_wup_1
            WHERE
               nb_id IN (-2, -1, 0, 2, 7)
               AND dat_eroeffnung > '1900-01-01'
               AND dat_von > '1900-01-01'
         )

   ) kstl
   ON kstl.mandant_id = gss.mandant_id
   AND kstl.gutschein_id = gss.gutschein_id
   ;