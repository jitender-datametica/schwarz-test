CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_VIS_MONAT_UMS_2
-- 22.08.2016 twie: SPEC0008548 Umsatzkennzahl summiert pro Land_2, Monat_2 aus VIS Aggregat für Management Cockpits
-- 29.03.2017 twie: SPEC0021846 Daten für VVJ und VVVJ sind als extra Spalte in der Tabelle. Damit man mit Transformationen arbeiten kann, in View als eigene Zeile mit entspr. KJMO ausgeben

(
mandant_id
,kjmo
,ums_netto
)
AS

   -- Umsätze für aktuelles und Vorjahr (akt_gj 0 und -1)
   SELECT

   v01.mandant_id,
   v01.kjmo,
   SUM(v01.ums_netto)

   FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 v01

   -- Daten sind gleichzeitig in Euro und Landeswährung in Tabelle, keine Umrechnung nötig
   -- Management Cockpits sind ausschließlich in Euro
   WHERE v01.wrg_id = 'EUR' AND akt_gj >=-1

   GROUP BY  v01.mandant_id, v01.kjmo


   UNION ALL


   --Umsätze für Vorvorjahr (VJ Metrik des akt_gj -1)
   SELECT

   v01.mandant_id,
   v01.kjmo - 100 AS kjmo --1 Jahr zurück, da Werte aus VJ Metrik
   ,
   SUM(v01.ums_netto_kvj) AS ums_netto

   FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 v01

   WHERE v01.wrg_id = 'EUR' AND akt_gj = -1

   GROUP BY  v01.mandant_id, v01.kjmo


   UNION ALL


   --Umsätze für Vorvorvorjahr (VVJ Metrik des akt_gj -1)
   SELECT

   v01.mandant_id,
   v01.kjmo - 200 AS kjmo --2 Jahre zurück, da Werte aus VVJ Metrik
   ,
   SUM(v01.ums_netto_kvvj) AS ums_netto

   FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 v01

   WHERE v01.wrg_id = 'EUR' AND akt_gj = -1

   GROUP BY  v01.mandant_id, v01.kjmo
;