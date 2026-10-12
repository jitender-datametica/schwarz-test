CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_KOND(
	MANDANT_ID,
	MV_INTRENO,
	MO_INTRENO,
	WRG_ID,
	WRG_HILF,
	WRG_TYP_ID,
	DAT_MO_GUELTIG_VON,
	DAT_MO_GUELTIG_BIS,
	MIETE_PER_ANNO3040,
	MIETE_PER_ANNO6200,
	MIETE_PER_ANNO3120_3240,
	INVESTMIETE,
	UMSATZMIETE,
	GRUND_MIETE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS 
--View for metrics Immo.Verw.Kosten, Umsatz mietabschlag, sonst.Ertraege. Invst.Miete, Umsatz Miete, Grund Miete. Checks whether the conditions are in EUR OR national currency in the source table AND also whether the conditions are actual OR in the future.
--Conditions for mietobjects with status 0 AND 6 are taken from immo_mietobjekt_kondition_per (objects without contracts) AND conditions for mietobjects with stati different from 0 AND 6 are taken from immo_mietvertrag_kondition_per (mietobjects with contracts)
--lsvi0303 20181012:Konditionsart 3170 entfenrt (Grundmiete)
--lsvi0303 20181012:Konditionsart 3020 entfenrt (Grundmiete)
--richternic 20210323: Konditionsart 3240 hinzufuegen -->  Sonst. Ertraege

----------immo_mietvertrag_kondition_per - unterschiedliche wrg_typ_id
SELECT
   DISTINCT a.mandant_id,
   a.mv_intreno,
   a.mo_intreno,
   v3.wrg_id,
   a.wrg_id AS wrg_hilf,
   v3.wrg_typ_id,
   v4.dat_mo_gueltig_von,
   v4.dat_mo_gueltig_bis,
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ), --current
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ), --current
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3040,--Immo-Verwk Kosten
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN a.konditionsart_id = 3040
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN a.konditionsart_id = 3040
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3040_future, */--Immo-Verwk Kosten future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno6200, -- Umsatz-mietabschlag
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN a.konditionsart_id = 6200
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN a.konditionsart_id = 6200
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno6200_future, */-- Umsatz-mietabschlag future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3120_3240, --sonst. Ertraege
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN  (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3120_3240_future,*/ --sonst. Ertraege future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS InvestMiete, -- Invest.Miete
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('3030')
               OR a.konditionsart_id = ('8050')
               OR a.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('3030')
               OR a.konditionsart_id = ('8050')
               OR a.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS InvestMiete_future,*/ -- Invest.Miete future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS UmsatzMiete, --Umsatz.Miete
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('6000')
               OR a.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('6000')
               OR a.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS UmsatzMiete_future,*/ --Umsatz.Miete future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v9.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS grund_miete
   /*,
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = 3000
               OR a.konditionsart_id = 6100
               OR a.konditionsart_id = 8000
               OR a.konditionsart_id = 8003
               OR a.konditionsart_id = 8200
               OR a.konditionsart_id = 8210
               OR a.konditionsart_id = 8220
               OR a.konditionsart_id = 8230
            )
            AND a.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = 3000
               OR a.konditionsart_id = 6100
               OR a.konditionsart_id = 8000
               OR a.konditionsart_id = 8003
               OR a.konditionsart_id = 8200
               OR a.konditionsart_id = 8210
               OR a.konditionsart_id = 8220
               OR a.konditionsart_id = 8230
            )
            AND a.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END as grund_miete_future*/
FROM
   dbp_view.v_immo_mietvertrag_kondition_per a
   JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3 ON a.mandant_id = v3.mandant_id
   JOIN dbp_msi_view_immo.mv_mietobjekt AS v4 ON a.mo_intreno = v4.mo_intreno
   AND a.mandant_id = v4.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8 ON v8.wrg_typ_id = 0
   AND v8.mandant_id = a.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v9 ON v9.wrg_typ_id = 1
   AND v9.mandant_id = a.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie AS v5 ON a.mandant_id = v5.mandant_id
   AND a.mv_intreno = v5.mv_intreno
   AND a.mo_intreno = v5.mo_intreno
WHERE
   CURRENT_DATE() <= a.dat_bis
   AND a.konditionsart_id IN (
      3040,
      6200,
      3030,
      8050,
      1050,
      3120,
	  3240,
      6000,
      3000,
      6100,
      8000,
      8003,
      8200,
      8210,
      8220,
      8230
   )
   AND v3.wrg_typ_id = 1
   AND v5.mo_status_id NOT IN (0, 6)
GROUP BY
   1,
   2,
   3,
   4,
   5,
   6,
   7,
   8
UNION
ALL
SELECT
   DISTINCT a.mandant_id,
   a.mv_intreno,
   a.mo_intreno,
   v3.wrg_id,
   a.wrg_id AS wrg_hilf,
   v3.wrg_typ_id,
   v4.dat_mo_gueltig_von,
   v4.dat_mo_gueltig_bis,
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 3040
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3040,--Immo-Verwk Kosten
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN a.konditionsart_id = 3040
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN a.konditionsart_id = 3040
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3040_future,*/--Immo-Verwk Kosten future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN a.konditionsart_id = 6200
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno6200, -- Umsatz-mietabschlag
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN a.konditionsart_id = 6200
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN a.konditionsart_id = 6200
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno6200_future,*/ -- Umsatz-mietabschlag future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN a.konditionsart_id IN (3120,3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3120_3240, -- sont. Ertraege
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (a.konditionsart_id   = 3120
                    OR a.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3120_3240_future,*/ -- sont. Ertraege future
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('3030')
                  OR a.konditionsart_id = ('8050')
                  OR a.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS InvestMiete, -- Invest.Miete
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('3030')
               OR a.konditionsart_id = ('8050')
               OR a.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('3030')
               OR a.konditionsart_id = ('8050')
               OR a.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS InvestMiete_future,*/
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = ('6000')
                  OR a.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= a.dat_bis
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS UmsatzMiete,
   /*CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('6000')
               OR a.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = ('6000')
               OR a.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= a.dat_bis
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS UmsatzMiete_future,*/
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  a.konditionsart_id = 3000
                  OR a.konditionsart_id = 6100
                  OR a.konditionsart_id = 8000
                  OR a.konditionsart_id = 8003
                  OR a.konditionsart_id = 8200
                  OR a.konditionsart_id = 8210
                  OR a.konditionsart_id = 8220
                  OR a.konditionsart_id = 8230
               )
               AND a.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS grund_miete
   /*,
   CASE
      WHEN a.wrg_id = 'EUR'
      AND a.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               a.konditionsart_id = 3000
               OR a.konditionsart_id = 6100
               OR a.konditionsart_id = 8000
               OR a.konditionsart_id = 8003
               OR a.konditionsart_id = 8200
               OR a.konditionsart_id = 8210
               OR a.konditionsart_id = 8220
               OR a.konditionsart_id = 8230
            )
            AND a.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= a.dat_von THEN a.miete_per_anno * v8.umrechnungskurs
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               a.konditionsart_id = 3000
               OR a.konditionsart_id = 6100
               OR a.konditionsart_id = 8000
               OR a.konditionsart_id = 8003
               OR a.konditionsart_id = 8200
               OR a.konditionsart_id = 8210
               OR a.konditionsart_id = 8220
               OR a.konditionsart_id = 8230
            )
            AND a.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= a.dat_von THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END as grund_miete_future*/
FROM
   dbp_view.v_immo_mietvertrag_kondition_per a
   JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3 ON a.mandant_id = v3.mandant_id
   JOIN dbp_msi_view_immo.mv_mietobjekt AS v4 ON a.mo_intreno = v4.mo_intreno
   AND a.mandant_id = v4.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8 ON v8.wrg_typ_id = 1
   AND  v8.mandant_id = a.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie AS v5 ON a.mandant_id = v5.mandant_id
   AND a.mv_intreno = v5.mv_intreno
   AND a.mo_intreno = v5.mo_intreno
WHERE
   CURRENT_DATE <= a.dat_bis
   AND a.konditionsart_id IN (
      3040,
      6200,
      3030,
      8050,
      1050,
      3120,
	  3240,
      6000,
      3000,
      6100,
      8000,
      8003,
      8200,
      8210,
      8220,
      8230
   )
   AND v3.wrg_typ_id = 0
   AND v5.mo_status_id NOT IN (0, 6)
GROUP BY
   1,
   2,
   3,
   4,
   5,
   6,
   7,
   8
UNION
ALL 
----------immo_mietobjekt_kondition_per - unterschiedliche wrg_typ_id
SELECT
   DISTINCT v6.mandant_id,
   v5.mv_intreno,
   v6.mo_intreno,
   v3.wrg_id,
   v6.wrg_id AS wrg_hilf,
   v3.wrg_typ_id,
   v4.dat_mo_gueltig_von,
   v4.dat_mo_gueltig_bis,
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3040,--Immo-Verwk Kosten
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN v6.konditionsart_id = 3040
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN v6.konditionsart_id = 3040
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3040_future,*/--Immo-Verwk Kosten future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno6200, -- Umsatz-mietabschlag
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN v6.konditionsart_id = 6200
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN v6.konditionsart_id = 6200
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno6200_future,*/ -- Umsatz-mietabschlag future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3120_3240, -- sont. Ertraege
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3120_3240_future, */-- sont. Ertraege future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS InvestMiete, -- Invest.Miete
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('3030')
               OR v6.konditionsart_id = ('8050')
               OR v6.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('3030')
               OR v6.konditionsart_id = ('8050')
               OR v6.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS InvestMiete_future,*/
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS UmsatzMiete,
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('6000')
               OR v6.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('6000')
               OR v6.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS UmsatzMiete_future,*/
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS grund_miete
   /*,
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = 3000
               OR v6.konditionsart_id = 6100
               OR v6.konditionsart_id = 8000
               OR v6.konditionsart_id = 8003
               OR v6.konditionsart_id = 8200
               OR v6.konditionsart_id = 8210
               OR v6.konditionsart_id = 8220
               OR v6.konditionsart_id = 8230
            )
            AND v6.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = 3000
               OR v6.konditionsart_id = 6100
               OR v6.konditionsart_id = 8000
               OR v6.konditionsart_id = 8003
               OR v6.konditionsart_id = 8200
               OR v6.konditionsart_id = 8210
               OR v6.konditionsart_id = 8220
               OR v6.konditionsart_id = 8230
            )
            AND v6.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END as grund_miete_future*/
FROM
   dbp_view.v_immo_mietobjekt_kondition_per AS v6
   JOIN dbp_msi_view_immo.mv_mietobjekt AS v4 ON v6.mo_intreno = v4.mo_intreno
   AND v6.mandant_id = v4.mandant_id
   JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3 ON v6.mandant_id = v3.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8 ON v8.wrg_typ_id = 1
   AND v8.mandant_id = v6.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie AS v5 ON v4.mandant_id = v5.mandant_id
   AND v4.mo_intreno = v5.mo_intreno
WHERE
   v6.konditionsart_id IN (
      3040,
      6200,
      3030,
      8050,
      1050,
      3120,
	  3240,
      6000,
      3000,
      6100,
      8000,
      8003,
      8200,
      8210,
      8220,
      8230
   )
   AND v3.wrg_typ_id = 0
   AND v5.mo_status_id IN (0, 6)
   AND CURRENT_DATE <= v6.dat_bis
GROUP BY
   1,
   2,
   3,
   4,
   5,
   6,
   7,
   8
UNION
ALL
SELECT
   DISTINCT v6.mandant_id,
   v5.mv_intreno,
   v6.mo_intreno,
   v3.wrg_id,
   v6.wrg_id AS wrg_hilf,
   v3.wrg_typ_id,
   v4.dat_mo_gueltig_von,
   v4.dat_mo_gueltig_bis,
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 3040
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3040,--Immo-Verwk Kosten
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN v6.konditionsart_id = 3040
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN v6.konditionsart_id = 3040
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3040_future,*/--Immo-Verwk Kosten future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN v6.konditionsart_id = 6200
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno6200, -- Umsatz-mietabschlag
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN v6.konditionsart_id = 6200
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN v6.konditionsart_id = 6200
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno6200_future,*/ -- Umsatz-mietabschlag future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS miete_per_anno3120_3240, -- sont. Ertraege
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (v6.konditionsart_id   = 3120
                    OR v6.konditionsart_id = 3240) -- 3240 aufgenommen -> zaehlt zu den Sonst. Ertraege
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS miete_per_anno3120_3240_future,*/ -- sont. Ertraege future
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('3030')
                  OR v6.konditionsart_id = ('8050')
                  OR v6.konditionsart_id = ('1050')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS InvestMiete, -- Invest.Miete
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('3030')
               OR v6.konditionsart_id = ('8050')
               OR v6.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('3030')
               OR v6.konditionsart_id = ('8050')
               OR v6.konditionsart_id = ('1050')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS InvestMiete_future,*/
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = ('6000')
                  OR v6.konditionsart_id = ('6200')
               )
               AND CURRENT_DATE() <= v6.dat_bis
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS UmsatzMiete,
   /*CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('6000')
               OR v6.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = ('6000')
               OR v6.konditionsart_id = ('6200')
            )
            AND CURRENT_DATE() <= v6.dat_bis
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END AS UmsatzMiete_future,*/
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
               ELSE 0
            END
         )
      )
      ELSE COALESCE(
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() >= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE NULL
            END
         ),
         SUM(
            CASE
               WHEN (
                  v6.konditionsart_id = 3000
                  OR v6.konditionsart_id = 6100
                  OR v6.konditionsart_id = 8000
                  OR v6.konditionsart_id = 8003
                  OR v6.konditionsart_id = 8200
                  OR v6.konditionsart_id = 8210
                  OR v6.konditionsart_id = 8220
                  OR v6.konditionsart_id = 8230
               )
               AND v6.dat_bis >= CURRENT_DATE()
               AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
               ELSE 0
            END
         )
      )
   END AS grund_miete
   /*,
   CASE
      WHEN v6.wrg_id = 'EUR'
      AND v6.mandant_id NOT IN (1, 5) THEN SUM(
         CASE
            WHEN (
               v6.konditionsart_id = 3000
               OR v6.konditionsart_id = 6100
               OR v6.konditionsart_id = 8000
               OR v6.konditionsart_id = 8003
               OR v6.konditionsart_id = 8200
               OR v6.konditionsart_id = 8210
               OR v6.konditionsart_id = 8220
               OR v6.konditionsart_id = 8230
            )
            AND v6.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= v6.dat_von THEN v6.miete_per_anno *(v8.umrechnungskurs)
            ELSE 0
         END
      )
      ELSE SUM(
         CASE
            WHEN (
               v6.konditionsart_id = 3000
               OR v6.konditionsart_id = 6100
               OR v6.konditionsart_id = 8000
               OR v6.konditionsart_id = 8003
               OR v6.konditionsart_id = 8200
               OR v6.konditionsart_id = 8210
               OR v6.konditionsart_id = 8220
               OR v6.konditionsart_id = 8230
            )
            AND v6.dat_bis >= CURRENT_DATE()
            AND CURRENT_DATE() <= v6.dat_von THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
            ELSE 0
         END
      )
   END as grund_miete_future*/
FROM
   dbp_view.v_immo_mietobjekt_kondition_per AS v6
   JOIN dbp_msi_view_immo.mv_mietobjekt AS v4 ON v6.mo_intreno = v4.mo_intreno
   AND v6.mandant_id = v4.mandant_id
   JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3 ON v6.mandant_id = v3.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8 ON v8.wrg_typ_id = 0
   AND v8.mandant_id = v6.mandant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie AS v5 ON v4.mandant_id = v5.mandant_id
   AND v4.mo_intreno = v5.mo_intreno
WHERE
   v6.konditionsart_id IN (
      3040,
      6200,
      3030,
      8050,
      1050,
      3120,
	  3240,
      6000,
      3000,
      6100,
      8000,
      8003,
      8200,
      8210,
      8220,
      8230
   )
   AND v3.wrg_typ_id = 1
   AND v5.mo_status_id IN (0, 6)
   AND CURRENT_DATE <= v6.dat_bis
GROUP BY
   1,
   2,
   3,
   4,
   5,
   6,
   7,
   8;