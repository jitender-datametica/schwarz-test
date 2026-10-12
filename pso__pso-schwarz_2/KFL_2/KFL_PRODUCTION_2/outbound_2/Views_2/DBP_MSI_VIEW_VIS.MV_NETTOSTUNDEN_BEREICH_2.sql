CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_nettostunden_bereich_2 (mandant_id, wup_id, nb_id, dat,
dat_zeit_aenderung, hr_objekt_bereich_id, quelle_id, stunden_typ_fg, stunden_2, std_ist, std_plan, stunden_ist,
stunden_plan, stunden_sonst_ist, stunden_sonst_plan, stunden_co_ist, stunden_co_plan) AS SELECT NSB.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 NSB.nb_id,
 NSB.dat,
 NSB.dat_zeit_aenderung,
 NSB.hr_objekt_bereich_id,
 NSB.quelle_id,
 NSB.stunden_typ_fg,
 NSB.stunden_2,
  CASE
  WHEN NSB.stunden_typ_fg = 0 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01')
      AND NSB.quelle_id <> 5)
  THEN NSB.stunden_2
  ELSE 0.00
  END AS std_ist,
  CASE
  WHEN NSB.stunden_typ_fg = 1 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01')
      AND NSB.quelle_id <> 5)
  THEN NSB.stunden_2
  ELSE 0.00
  END AS std_plan,
  CASE
  WHEN NSB.quelle_id IN (1, 2, 3, 4, 5)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 0 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_ist,
  CASE
  WHEN NSB.quelle_id IN (1, 2, 3, 4, 5)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 1 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_plan,
  CASE
  WHEN NSB.quelle_id IN (9)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 0 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_sonst_ist,
  CASE
  WHEN NSB.quelle_id IN (9)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 1 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_sonst_plan,
  CASE
  WHEN NSB.quelle_id IN (6)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 0 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_co_ist,
  CASE
  WHEN NSB.quelle_id IN (6)
  THEN CASE
   WHEN NSB.stunden_typ_fg = 1 AND (NSB.dat < DATE('2019-09-01') AND NSB.quelle_id <> 1 OR NSB.dat >= DATE('2019-09-01'
         ) AND NSB.quelle_id <> 5)
   THEN NSB.stunden_2
   ELSE 0.00
   END
  ELSE 0.00
  END AS stunden_co_plan
FROM kfl_production_dbp_view.v_nettostunden_bereich_2 AS NSB
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON NSB.mandant_id = WUP.mandant_id AND NSB.wup_id = WUP.wup_id;